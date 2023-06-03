//
//  SchedulerViewController.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 02.06.2023.
//

import UIKit
import RxSwift

final class SchedulerViewController: UIViewController {
    lazy var mainView = SchedulerView()
    
    private lazy var viewModel = SchedulerViewModel()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var addButton = UIButton()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let output = viewModel.configure(input: SchedulerViewModel.Input(
            didTapCreateTask: addButton.rx.tap.asSignal()
        ))
        
        output.route
            .drive(Binder(self) { base, route in
                base.route(route)
            })
            .disposed(by: disposeBag)
        
        inputAddButton()
    }
}

// MARK: Public
extension SchedulerViewController {
    static func make() -> SchedulerViewController {
        let vc = SchedulerViewController()
        vc.navigationItem.backButtonTitle = " "
        vc.navigationItem.title = "Scheduler.Title".localized
        return vc
    }
}

// MARK: Private
private extension SchedulerViewController {
    func inputAddButton() {
        let item = UIBarButtonItem(customView: addButton)
        item.customView?.translatesAutoresizingMaskIntoConstraints = false
        
        item.customView?.widthAnchor.constraint(equalToConstant: 24.scale).isActive = true
        item.customView?.heightAnchor.constraint(equalToConstant: 24.scale).isActive = true
        
        addButton.setImage(UIImage(named: "Scheduler.Add"), for: .normal)
        
        navigationItem.rightBarButtonItem = item
    }
    
    func route(_ route: SchedulerViewModel.Route) {
        switch route {
        case .createTask:
            let vc = CreateTaskViewController.make()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
