//
//  InputNameViewController.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 30.05.2023.
//

import UIKit
import RxSwift

final class InputNameViewController: UIViewController {
    lazy var mainView = InputNameView()

    private lazy var disposeBag = DisposeBag()

    private let didInputName: ((String) -> Void)

    private init(didInputName: @escaping ((String) -> Void)) {
        self.didInputName = didInputName

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.button.rx.tap
            .bind(to: Binder(self) { base, void in
                let name = base.mainView.textField.text ?? ""

                base.animateDismiss {
                    base.didInputName(name)
                }
            })
            .disposed(by: disposeBag)
        
        mainView.rx.keyboardHeight
            .bind(to: Binder(mainView) { base, keyboardHeight in
                base.updatePosition(at: keyboardHeight)
            })
            .disposed(by: disposeBag)

        prepareToAnimate()
        check()
        mainView.textField.delegate = self
        mainView.textField.addTarget(self, action: #selector(didChange(field:)), for: .editingChanged)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        animateShow()

        mainView.textField.becomeFirstResponder()
    }
}

// MARK: Make
extension InputNameViewController {
    static func make(didInputName: @escaping ((String) -> Void)) -> InputNameViewController {
        let vc = InputNameViewController(didInputName: didInputName)
        vc.modalPresentationStyle = .overFullScreen
        return vc
    }
}

// MARK: UITextFieldDelegate
extension InputNameViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: Private
private extension InputNameViewController {
    @objc
    func didChange(field: UITextField) {
        if mainView.textField === field {
            check()
        }
    }

    func check() {
        let enable = isValid()

        mainView.button.isEnabled = enable
        mainView.button.alpha = enable ? 1 : 0.5
    }

    func isValid() -> Bool {
        guard let name = mainView.textField.text else {
            return false
        }
        
        return (name.count >= 3) && (name.count <= 20)
    }

    func prepareToAnimate() {
        mainView.backgroundColor = UIColor.black.withAlphaComponent(0)
        mainView.container.alpha = 0
    }

    func animateShow() {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.mainView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            self?.mainView.container.alpha = 1
        })
    }

    func animateDismiss(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.mainView.backgroundColor = UIColor.black.withAlphaComponent(0)
            self?.mainView.container.alpha = 0
        }, completion: { [weak self] result in
            self?.dismiss(animated: false) {
                completion?()
            }
        })
    }
}
