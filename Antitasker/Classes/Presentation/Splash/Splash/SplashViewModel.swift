//
//  SplashViewModel.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 23.05.2023.
//

import RxSwift
import RxCocoa

final class SplashViewModel {
    enum Route {
        case requestName
        case information
        case main
    }
    
    private lazy var profile = makeProfile()
    
    private lazy var profileManager = ProfileManager()
}

// MARK: Public
extension SplashViewModel {
    struct Input {
        let didInputName: Signal<String>
    }
    
    struct Output {
        let route: Driver<Route>
    }
    
    func configure(input: Input) -> Output {
        Output(
            route: makeRoute(didInputName: input.didInputName)
        )
    }
}

// MARK: Private
private extension SplashViewModel {
    func makeRoute(didInputName: Signal<String>) -> Driver<Route> {
        let requestName = profile
            .compactMap { $0 == nil ? Route.requestName : (InformationViewController.wasViewed ? .main : .information) }
        
        let set = didInputName
            .asDriver(onErrorDriveWith: .never())
            .flatMapLatest { [weak self] name -> Driver<Route> in
                guard let self = self else {
                    return .never()
                }
                
                return self.profileManager
                    .set(name: name)
                    .asDriver(onErrorDriveWith: .never())
                    .map { InformationViewController.wasViewed ? .main : .information }
            }
        
        return Driver
            .merge(requestName, set)
    }
    
    func makeProfile() -> Driver<Profile?> {
        profileManager
            .obtainProfile()
            .delaySubscription(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .asDriver(onErrorJustReturn: nil)
    }
}
