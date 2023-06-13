//
//  PunishmentViewController.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 13.06.2023.
//

import UIKit
import RxSwift

final class PunishmentViewController: UIViewController {
    lazy var mainView = PunishmentView()
    
    private lazy var disposeBag = DisposeBag()
    
    private let viewModel: PunishmentViewModel
    
    private init(punishment: Punishment) {
        viewModel = PunishmentViewModel(punishment: punishment)
        
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
        
        let output = viewModel.configure(input: PunishmentViewModel.Input(
            didTapDone: mainView.tableView.didTapDone
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
extension PunishmentViewController {
    static func make(punishment: Punishment) -> PunishmentViewController {
        let vc = PunishmentViewController(punishment: punishment)
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
}

// MARK: Private
private extension PunishmentViewController {
    func route(_ route: PunishmentViewModel.Route) {
        switch route {
        case .dismiss:
            dismiss(animated: true)
        }
    }
}
