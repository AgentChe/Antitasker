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
    func delete(id: String) -> Single<Void>
    func complete(id: String) -> Single<Void>
    func obtainPunishment() -> Single<Punishment?>
    func donePunishment() -> Single<Void>
    func appointPunishment() -> Single<Void>
}

final class TaskManager {
    enum Constants {
        static let tasksKey = "task_manager_tasks_key"
        static let punishmentKey = "task_manager_punishment_key"
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
    
    func delete(id: String) -> Single<Void> {
        obtainTasks()
            .flatMap { tasks -> Single<Void> in
                Single<Void>.create { event in
                    var result = tasks
                    result.removeAll(where: { $0.id == id })
                    
                    if let data = try? JSONEncoder().encode(result) {
                        UserDefaults.standard.set(data, forKey: Constants.tasksKey)
                    }
                    
                    event(.success(Void()))
                    
                    TaskMediator.shared.taskDeleted(id: id)
                    
                    return Disposables.create()
                }
            }
    }
    
    func complete(id: String) -> Single<Void> {
        obtainTasks()
            .flatMap { tasks -> Single<Void> in
                Single<Void>.create { event in
                    var result = tasks
                    
                    if let index = result.firstIndex(where: { $0.id == id }) {
                        let task = result[index]
                        
                        let newTask = Task(
                            id: task.id,
                            name: task.name,
                            description: task.description,
                            date: task.date,
                            state: .completed,
                            createdDate: task.createdDate
                        )
                        result[index] = newTask
                        
                        if let data = try? JSONEncoder().encode(result) {
                            UserDefaults.standard.set(data, forKey: Constants.tasksKey)
                        }
                    }
                    
                    event(.success(Void()))
                    
                    TaskMediator.shared.taskCompleted(id: id)
                    
                    return Disposables.create()
                }
            }
    }
    
    func obtainPunishment() -> Single<Punishment?> {
        Single<Punishment?>.create { event in
            guard let data = UserDefaults.standard.data(forKey: Constants.punishmentKey) else {
                event(.success(nil))
                return Disposables.create()
            }
            
            let punishment = try? JSONDecoder().decode(Punishment.self, from: data)
            
            event(.success(punishment))
            
            return Disposables.create()
        }
    }
    
    func donePunishment() -> Single<Void> {
        Single<Void>.create { event in
            UserDefaults.standard.removeObject(forKey: Constants.punishmentKey)
            
            event(.success(Void()))
            
            TaskMediator.shared.donePunishment()
            
            return Disposables.create()
        }
    }
    
    func appointPunishment() -> Single<Void> {
        Single<Void>.create { event in
            let all: [Punishment] = [
                .screen,
                .virus,
                .spa,
                .fastfood
            ]
            let punishment = all.randomElement()!
            
            if let data = try? JSONEncoder().encode(punishment) {
                UserDefaults.standard.set(data, forKey: Constants.punishmentKey)
                
                TaskMediator.shared.appoint(punishment: punishment)
            }
            
            event(.success(Void()))
            
            return Disposables.create()
        }
    }
}
