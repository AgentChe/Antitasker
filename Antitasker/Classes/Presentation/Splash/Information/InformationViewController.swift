//
//  InformationViewController.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 30.05.2023.
//

import UIKit
import RxSwift

final class InformationViewController: UIViewController {
    lazy var mainView = InformationView()
    
    private lazy var viewModel = InformationViewModel()
    
    private lazy var disposeBag = DisposeBag()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let output = viewModel.configure(input: InformationViewModel.Input(
            didTapButton: mainView.tableView.didTapButton
        ))
        
        output.sections
            .drive(Binder(mainView.tableView) { base, sections in
                base.setup(sections: sections)
            })
            .disposed(by: disposeBag)
        
        output.route
            .drive(Binder(self) { base, route in
                base.route(route)
            })
            .disposed(by: disposeBag)
        
        markAsViewed()
    }
}

// MARK: Public
extension InformationViewController {
    static func make() -> InformationViewController {
        let vc = InformationViewController()
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
    
    static var wasViewed: Bool {
        UserDefaults.standard.bool(forKey: Constansts.wasViewedKey)
    }
}

// MARK: Private
private extension InformationViewController {
    enum Constansts {
        static let wasViewedKey = "information_was_viewed_key"
    }
    
    func markAsViewed() {
        UserDefaults.standard.set(true, forKey: Constansts.wasViewedKey)
    }
    
    func route(_ route: InformationViewModel.Route) {
        switch route {
        case .main:
            let vc = NavigationController(rootViewController: SchedulerViewController.make())
            UIApplication.shared.keyWindow?.rootViewController = vc
        }
    }
}
