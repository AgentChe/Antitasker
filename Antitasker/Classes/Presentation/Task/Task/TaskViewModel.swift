//
//  TaskViewModel.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 05.06.2023.
//

import RxSwift
import RxCocoa

final class TaskViewModel {
    enum Route {
        case completed
        case deleted
    }
    
    private lazy var task = makeTask()
    private let initialTask: Driver<Task>
    
    private lazy var taskManager = TaskManager()
    
    init(task: Task) {
        self.initialTask = BehaviorRelay(value: task).asDriver()
    }
}

// MARK: Public
extension TaskViewModel {
    struct Input {
        let didTapComplete: Signal<Void>
        let didTapDelete: Signal<Void>
    }
    
    struct Output {
        let elements: Driver<[TaskTableElement]>
        let route: Driver<Route>
    }
    
    func configure(input: Input) -> Output {
        Output(
            elements: makeElements(),
            route: makeRoute(
                didTapComplete: input.didTapComplete,
                didTapDelete: input.didTapDelete
            )
        )
    }
}

// MARK: Private
private extension TaskViewModel {
    func makeElements() -> Driver<[TaskTableElement]> {
        task
            .map { task -> [TaskTableElement] in
                let image: String
                let advice: String
                
                switch task.state {
                case .open:
                    image = "Task.Open"
                    advice = "Task.Advice.Open".localized
                case .completed:
                    image = "Task.Completed"
                    advice = "Task.Advice.Completed".localized
                }
                
                let name = TaskNameElement(
                    name: task.name,
                    status: task.state
                )
                
                let formatter = DateFormatter()
                formatter.locale = Locale.current
                formatter.dateFormat = "dd.MM.yyyy"
                let date = formatter.string(from: task.date)
                
                var elements: [TaskTableElement] = [
                    .image(image),
                    .advice(advice),
                    .name(name),
                    .description(task.description),
                    .date(date),
                ]
                
                if task.state == .open {
                    elements.append(contentsOf: [.complete, .delete])
                }
                
                return elements
            }
    }
    
    func makeRoute(
        didTapComplete: Signal<Void>,
        didTapDelete: Signal<Void>
    ) -> Driver<Route> {
        Driver
            .merge(
                makeComplete(didTapComplete: didTapComplete),
                makeDelete(didTapDelete: didTapDelete)
            )
    }
    
    func makeComplete(didTapComplete: Signal<Void>) -> Driver<Route> {
        didTapComplete
            .withLatestFrom(task)
            .flatMapLatest { [weak self] task -> Driver<Route> in
                guard let self = self else {
                    return .never()
                }
                
                return self.taskManager
                    .complete(id: task.id)
                    .asDriver(onErrorDriveWith: .never())
                    .map { Route.completed }
            }
    }
    
    func makeDelete(didTapDelete: Signal<Void>) -> Driver<Route> {
        didTapDelete
            .withLatestFrom(task)
            .flatMapLatest { [weak self] task -> Driver<Route> in
                guard let self = self else {
                    return .never()
                }
                
                return self.taskManager
                    .delete(id: task.id)
                    .asDriver(onErrorDriveWith: .never())
                    .map { Route.deleted }
            }
    }
    
    func makeTask() -> Driver<Task> {
        let triggers = Signal
            .merge(
                TaskMediator.shared.didCompletedTask,
                TaskMediator.shared.didDeleteTask
            )
        
        let updated = triggers
            .withLatestFrom(initialTask)
            .flatMapLatest { [weak self] task -> Driver<Task> in
                guard let self = self else {
                    return .never()
                }
                
                return self.taskManager
                    .obtainTasks()
                    .compactMap { tasks -> Task? in
                        tasks.first(where: { $0.id == task.id })
                    }
                    .asDriver(onErrorDriveWith: .never())
            }
        
        return Driver
            .merge(
                initialTask,
                updated
            )
    }
}
