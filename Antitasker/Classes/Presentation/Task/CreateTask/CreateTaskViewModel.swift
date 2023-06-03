//
//  CreateTaskViewModel.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 02.06.2023.
//


import RxSwift
import RxCocoa

final class CreateTaskViewModel {
    enum Route {
        case alert(String)
    }
    
    private lazy var profileManager = ProfileManager()
    private lazy var taskManager = TaskManager()
}

// MARK: Public
extension CreateTaskViewModel {
    struct Input {
        let didInputName: Signal<String>
        let didInputDescription: Signal<String>
        let didInputDate: Signal<Date>
        let didTapCreate: Signal<Void>
    }
    
    struct Output {
        let enable: Driver<Bool>
        let route: Driver<Route>
    }
    
    func configure(input: Input) -> Output {
        let args = makeArgs(
            didInputName: input.didInputName,
            didInputDescription: input.didInputDescription,
            didInputDate: input.didInputDate
        )
        let userName = makeUserName()
        
        return Output(
            enable: makeEnable(
                didInputName: input.didInputName,
                didInputDescription: input.didInputDescription,
                didInputDate: input.didInputDate
            ),
            route: makeRoute(
                didTapCreate: input.didTapCreate,
                args: args,
                userName: userName
            )
        )
    }
}

// MARK: Private
private extension CreateTaskViewModel {
    func makeEnable(
        didInputName: Signal<String>,
        didInputDescription: Signal<String>,
        didInputDate: Signal<Date>
    ) -> Driver<Bool> {
        Signal
            .combineLatest(
                didInputName,
                didInputDescription,
                didInputDate
            )
            .map { name, description, date -> Bool in
                !name.isEmpty && !description.isEmpty && (date >= Date())
            }
            .startWith(false)
            .asDriver(onErrorDriveWith: .never())
    }
    
    func makeArgs(
        didInputName: Signal<String>,
        didInputDescription: Signal<String>,
        didInputDate: Signal<Date>
    ) -> Driver<(String, String, Date)> {
        Signal
            .combineLatest(
                didInputName,
                didInputDescription,
                didInputDate
            )
            .map { name, description, date -> (String, String, Date) in
                (name, description, date)
            }
            .asDriver(onErrorDriveWith: .never())
    }
    
    func makeRoute(
        didTapCreate: Signal<Void>,
        args: Driver<(String, String, Date)>,
        userName: Driver<String>
    ) -> Driver<Route> {
        didTapCreate
            .asDriver(onErrorDriveWith: .never())
            .withLatestFrom(args)
            .flatMapLatest { [weak self] args -> Driver<Task> in
                guard let self = self else {
                    return .never()
                }
                
                return self.taskManager
                    .createTask(
                        name: args.0,
                        desctiption: args.1,
                        dateTime: args.2
                    )
                    .asDriver(onErrorDriveWith: .never())
            }
            .withLatestFrom(userName)
            .map { Route.alert($0) }
    }
    
    func makeUserName() -> Driver<String> {
        profileManager
            .obtainProfile()
            .map { $0?.name ?? "" }
            .asDriver(onErrorDriveWith: .never())
    }
}
