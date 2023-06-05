//
//  CreateTaskViewController.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 02.06.2023.
//

import UIKit
import RxSwift
import RxCocoa

final class CreateTaskViewController: UIViewController {
    lazy var mainView = CreateTaskView()
    
    private lazy var viewModel = CreateTaskViewModel()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var didInputNameTrigger = PublishRelay<String>()
    private lazy var didInputDescriptionTrigger = PublishRelay<String>()
    private lazy var didInputDateTrigger = PublishRelay<Date>()
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        formatter.locale = Locale.current
        return formatter
    }()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let output = viewModel.configure(input: CreateTaskViewModel.Input(
            didInputName: didInputNameTrigger.asSignal(),
            didInputDescription: didInputDescriptionTrigger.asSignal(),
            didInputDate: didInputDateTrigger.asSignal(),
            didTapCreate: mainView.button.rx.tap.asSignal()
        ))
        
        output.enable
            .drive(Binder(mainView.button) { base, enable in
                base.alpha = enable ? 1 : 0.5
                base.isEnabled = enable
            })
            .disposed(by: disposeBag)
        
        output.route
            .drive(Binder(self) { base, route in
                base.route(route)
            })
            .disposed(by: disposeBag)
        
        mainView.rx.keyboardHeight
            .bind(to: Binder(mainView.scrollView) { base, keyboardHeight in
                base.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
            })
            .disposed(by: disposeBag)
        
        mainView.nameTextField.delegate = self
        mainView.descriptionTextField.delegate = self
        mainView.dateTimeTextField.delegate = self
        
        mainView.dateTimeTextField.inputView = mainView.datePicker

        mainView.nameTextField.addTarget(self, action: #selector(textEditing(sender:)), for: .editingChanged)
        mainView.descriptionTextField.addTarget(self, action: #selector(textEditing(sender:)), for: .editingChanged)
        mainView.datePicker.addTarget(self, action: #selector(dateTimeChanged), for: .valueChanged)
    }
}

// MARK: Public
extension CreateTaskViewController {
    static func make() -> CreateTaskViewController {
        let vc = CreateTaskViewController()
        vc.navigationItem.backButtonTitle = " "
        vc.navigationItem.title = "CreateTask.Title".localized
        return vc
    }
}

// MARK: UITextFieldDelegate
extension CreateTaskViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: Private
private extension CreateTaskViewController {
    @objc
    func textEditing(sender: UITextField) {
        if sender === mainView.nameTextField {
            didInputNameTrigger.accept(sender.text ?? "")
        }
        
        if sender === mainView.descriptionTextField {
            didInputDescriptionTrigger.accept(sender.text ?? "")
        }
    }
    
    @objc
    func dateTimeChanged() {
        let date = mainView.datePicker.date
        
        mainView.dateTimeTextField.text = dateFormatter.string(from: date)
        
        didInputDateTrigger.accept(date)
    }
    
    func route(_ route: CreateTaskViewModel.Route) {
        switch route {
        case .alert(let name):
            let vc = DiscontentAlertViewController.make(name: name) { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            present(vc, animated: false)
        }
    }
}
