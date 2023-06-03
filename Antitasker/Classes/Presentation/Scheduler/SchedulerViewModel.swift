//
//  SchedulerViewModel.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 02.06.2023.
//

import RxSwift
import RxCocoa

final class SchedulerViewModel {
    enum Route {
        case createTask
    }
}

// MARK: Public
extension SchedulerViewModel {
    struct Input {
        let didTapCreateTask: Signal<Void>
    }
    
    struct Output {
        let route: Driver<Route>
    }
    
    func configure(input: Input) -> Output {
        Output(
            route: makeRoute(didTapCreateTask: input.didTapCreateTask)
        )
    }
}

// MARK: Private
private extension SchedulerViewModel {
    func makeRoute(didTapCreateTask: Signal<Void>) -> Driver<Route> {
        didTapCreateTask
            .map { Route.createTask }
            .asDriver(onErrorDriveWith: .never())
    }
}
