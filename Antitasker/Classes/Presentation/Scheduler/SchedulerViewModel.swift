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
        case task(Task)
    }
    
    private lazy var profile = makeProfile()
    private lazy var tasks = makeTasks()
    
    private lazy var profileManager = ProfileManager()
    private lazy var taskManager = TaskManager()
}

// MARK: Public
extension SchedulerViewModel {
    struct Input {
        let didTapCreateTask: Signal<Void>
        let didSelectDate: Signal<Date>
        let didSelectTask: Signal<Task>
    }
    
    struct Output {
        let elements: Driver<[SchedulerTableElement]>
        let route: Driver<Route>
    }
    
    func configure(input: Input) -> Output {
        let selectedDate = input.didSelectDate
            .asDriver(onErrorDriveWith: .never())
            .startWith(Date())
        let headerElement = makeHeaderElement()
        let tasksOnSelectedDate = makeTasksOn(selectedDate: selectedDate)
        
        return Output(
            elements: makeElements(
                headerElement: headerElement,
                didSelectDate: selectedDate,
                tasksOnSelectedDate: tasksOnSelectedDate
            ),
            route: makeRoute(
                didTapCreateTask: input.didTapCreateTask,
                didSelectTask: input.didSelectTask
            )
        )
    }
}

// MARK: Private
private extension SchedulerViewModel {
    func makeElements(
        headerElement: Driver<SchedulerTableElement>,
        didSelectDate: Driver<Date>,
        tasksOnSelectedDate: Driver<[Task]>
    ) -> Driver<[SchedulerTableElement]> {
        Driver
            .combineLatest(
                headerElement,
                didSelectDate,
                tasksOnSelectedDate,
                makeEasterTask(didSelectDate: didSelectDate)
            )
            .map { header, selectedDate, tasks, easterTask -> [SchedulerTableElement] in
                var result: [SchedulerTableElement] = [header, .calendar]
                
                let calendar = Calendar.current
                let currentDate = Date()
                
                let isCurrentYear = calendar.isDate(selectedDate, equalTo: currentDate, toGranularity: .year)
                
                let formatter = DateFormatter()
                formatter.locale = Locale.current
                formatter.dateFormat = isCurrentYear ? "dd MMM" : "dd MMM yyyy"
                
                result.append(.date(formatter.string(from: selectedDate)))
                
                if tasks.isEmpty {
                    result.append(.empty)
                } else {
                    tasks.enumerated().forEach { index, task in
                        if let easterTask = easterTask {
                            if tasks.count >= 1 && index == 1 {
                                result.append(.easterTask(easterTask))
                            }
                        }
                        
                        result.append(.task(task))
                    }
                }
                
                return result
            }
    }
    
    func makeHeaderElement() -> Driver<SchedulerTableElement> {
        profile
            .map { profile -> SchedulerTableElement in
                let tag = [
                    "Scheduler.Header.Tag1".localized,
                    "Scheduler.Header.Tag2".localized
                ].randomElement()!
                
                let fatigueBalls = profile.fatigueBalls
                let fatigue = Fatigue(balls: fatigueBalls)
                
                let fatigueRange = fatigue.range
                let fatiguePercent = (fatigueBalls - fatigueRange.from) / (fatigueRange.to - fatigueRange.from) * 100
                
                let header = SchedulerHeaderElement(
                    name: profile.name,
                    fatigueBalls: profile.fatigueBalls,
                    fatigue: fatigue,
                    fatiguePercent: fatiguePercent,
                    tag: tag
                )
                
                return .header(header)
            }
    }
    
    func makeTasksOn(selectedDate: Driver<Date>) -> Driver<[Task]> {
        Driver
            .combineLatest(
                selectedDate,
                tasks
            )
            .map { date, tasks -> [Task] in
                let calendar = Calendar.current
                
                return tasks
                    .filter { task -> Bool in
                        calendar.isDate(date, equalTo: task.date, toGranularity: .day)
                    }
                    .sorted(by: { $0.createdDate < $1.createdDate })
            }
    }
    
    func makeEasterTask(didSelectDate: Driver<Date>) -> Driver<EasterTask?> {
        didSelectDate
            .map { date -> EasterTask? in
                let random = Int.random(in: 1...100)
                guard (random >= 1) && (random <= 15) else {
                    return nil
                }
                
                return EasterTask.all.randomElement()
            }
    }
    
    func makeRoute(
        didTapCreateTask: Signal<Void>,
        didSelectTask: Signal<Task>
    ) -> Driver<Route> {
        let create = didTapCreateTask
            .map { Route.createTask }
            .asDriver(onErrorDriveWith: .never())
        let task = didSelectTask
            .map { Route.task($0) }
            .asDriver(onErrorDriveWith: .never())
        return Driver
            .merge(create, task)
    }
    
    func makeProfile() -> Driver<Profile> {
        ProfileMediator.shared
            .profileDidChange
            .startWith(Void())
            .flatMapLatest { [weak self] void -> Driver<Profile> in
                guard let self = self else {
                    return .never()
                }
                
                return self.profileManager
                    .obtainProfile()
                    .compactMap { $0 }
                    .asDriver(onErrorDriveWith: .never())
            }
            .asDriver(onErrorDriveWith: .never())
    }
    
    func makeTasks() -> Driver<[Task]> {
        let triggers = Signal<Void>
            .merge(
                TaskMediator.shared
                    .didCompletedTask
                    .map { id in Void() },
                TaskMediator.shared
                    .didCreateTask
                    .map { task in Void() },
                TaskMediator.shared
                    .didDeleteTask
                    .map { id in Void() }
            )
            .startWith(Void())
        
        return triggers
            .flatMapLatest { [weak self] void -> Driver<[Task]> in
                guard let self = self else {
                    return .never()
                }
                
                return self.taskManager
                    .obtainTasks()
                    .asDriver(onErrorJustReturn: [])
            }
    }
}
