//
//  SplashViewController.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 23.05.2023.
//

import UIKit
import RxSwift
import RxCocoa

final class SplashViewController: UIViewController {
    lazy var mainView = SplashView()
    
    private lazy var viewModel = SplashViewModel()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var didInputNameTrigger = PublishRelay<String>()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let output = viewModel.configure(input: SplashViewModel.Input(
            didInputName: didInputNameTrigger.asSignal()
        ))
        
        output.route
            .drive(Binder(self) { base, route in
                base.route(route)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: Make
extension SplashViewController {
    static func make() -> SplashViewController {
        SplashViewController()
    }
}

// MARK: Private
private extension SplashViewController {
    func route(_ route: SplashViewModel.Route) {
        switch route {
        case .requestName:
            let vc = InputNameViewController.make { [weak self] name in
                self?.didInputNameTrigger.accept(name)
            }
            present(vc, animated: false)
        case .information:
            let vc = InformationViewController.make()
            present(vc, animated: true)
        case .main:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let vc = NavigationController(rootViewController: SchedulerViewController.make())
                UIApplication.shared.keyWindow?.rootViewController = vc
            }
        }
    }
}
