//
//  TaskTableElement.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 05.06.2023.
//

enum TaskTableElement {
    case image(String)
    case advice(String)
    case name(TaskNameElement)
    case description(String)
    case date(String)
    case complete
    case delete
}

struct TaskNameElement {
    let name: String
    let status: TaskStatus
}
