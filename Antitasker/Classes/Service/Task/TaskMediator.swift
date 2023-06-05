//
//  TaskMediator.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 03.06.2023.
//

import RxSwift
import RxCocoa

final class TaskMediator {
    static let shared = TaskMediator()
    
    private lazy var didCreateTaskTrigger = PublishRelay<Task>()
    private lazy var didDeleteTaskTrigger = PublishRelay<String>()
    private lazy var didCompletedTaskTrigger = PublishRelay<String>()
    
    private init() {}
}

// MARK: Public
extension TaskMediator {
    func taskCreated(_ task: Task) {
        DispatchQueue.main.async { [weak self] in
            self?.didCreateTaskTrigger.accept(task)
        }
    }
    
    func taskDeleted(id: String) {
        DispatchQueue.main.async { [weak self] in
            self?.didDeleteTaskTrigger.accept(id)
        }
    }
    
    func taskCompleted(id: String) {
        DispatchQueue.main.async { [weak self] in
            self?.didCompletedTaskTrigger.accept(id)
        }
    }
    
    var didCreateTask: Signal<Task> {
        didCreateTaskTrigger.asSignal()
    }
    
    var didDeleteTask: Signal<String> {
        didDeleteTaskTrigger.asSignal()
    }
    
    var didCompletedTask: Signal<String> {
        didCompletedTaskTrigger.asSignal()
    }
}
