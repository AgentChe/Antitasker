//
//  TaskViewController.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 05.06.2023.
//

import UIKit
import RxSwift

final class TaskViewController: UIViewController {
    lazy var mainView = TaskView()
    
    private let viewModel: TaskViewModel
    
    private lazy var disposeBag = DisposeBag()
    
    private init(task: Task) {
        viewModel = TaskViewModel(task: task)
        
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
        
        let output = viewModel.configure(input: TaskViewModel.Input(
            didTapComplete: mainView.tableView.didTapComplete,
            didTapDelete: mainView.tableView.didTapDelete
        ))
        
        output.elements
            .drive(Binder(mainView.tableView) { base, elements in
                base.setup(elements: elements)
            })
            .disposed(by: disposeBag)
        
        output.route
            .drive(Binder(self) { base, route in
                base.route(route)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: Public
extension TaskViewController {
    static func make(task: Task) -> TaskViewController {
        let vc = TaskViewController(task: task)
        vc.navigationItem.title = "Task.Title".localized
        vc.navigationItem.backButtonTitle = " "
        return vc
    }
}

// MARK: Private
private extension TaskViewController {
    func route(_ route: TaskViewModel.Route) {
        switch route {
        case .completed:
            let vc = TaskAlertViewController.make(mode: .completed)
            present(vc, animated: true)
        case .deleted:
            let vc = TaskAlertViewController.make(mode: .deleted) { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            present(vc, animated: true)
        }
    }
}
