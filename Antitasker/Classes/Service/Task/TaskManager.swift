//
//  TaskManager.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 30.05.2023.
//

import RxSwift

protocol TaskManagerProtocol {
    func createTask(
        name: String,
        desctiption: String,
        dateTime: Date
    ) -> Single<Task>
    func obtainTasks() -> Single<[Task]>
}

final class TaskManager {
    enum Constants {
        static let tasksKey = "task_manager_tasks_key"
    }
}

// MARK: TaskManagerProtocol
extension TaskManager: TaskManagerProtocol {
    func createTask(
        name: String,
        desctiption: String,
        dateTime: Date
    ) -> Single<Task> {
        obtainTasks()
            .flatMap { tasks -> Single<Task> in
                Single<Task>.create { event in
                    var result = tasks
                    
                    let newTask = Task(
                        id: UUID().uuidString,
                        name: name,
                        description: desctiption,
                        date: dateTime,
                        state: .open
                    )
                    
                    result.append(newTask)
                    
                    if let data = try? JSONEncoder().encode(result) {
                        UserDefaults.standard.set(data, forKey: Constants.tasksKey)
                    }
                    
                    event(.success(newTask))
                    
                    TaskMediator.shared.taskCreated(newTask)
                    
                    return Disposables.create()
                }
            }
    }
    
    func obtainTasks() -> Single<[Task]> {
        Single<[Task]>.create { event in
            guard
                let data = UserDefaults.standard.data(forKey: Constants.tasksKey),
                let tasks = try? JSONDecoder().decode([Task].self, from: data)
            else {
                event(.success([]))
                return Disposables.create()
            }
            
            event(.success(tasks))
            
            return Disposables.create()
        }
    }
}

// MARK: Private
private extension TaskManager {
    
}
