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
    
    private init() {}
}

// MARK: Public
extension TaskMediator {
    func taskCreated(_ task: Task) {
        DispatchQueue.main.async { [weak self] in
            self?.didCreateTaskTrigger.accept(task)
        }
    }
    
    var didCreateTask: Signal<Task> {
        didCreateTaskTrigger.asSignal()
    }
}
