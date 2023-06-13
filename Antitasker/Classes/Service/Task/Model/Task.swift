//
//  Task.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 30.05.2023.
//

import Foundation

struct Task: Codable, Hashable {
    let id: String
    let name: String
    let description: String
    let date: Date
    let state: TaskStatus
    let createdDate: Date
    
    init(
        id: String,
        name: String,
        description: String,
        date: Date,
        state: TaskStatus,
        createdDate: Date = Date()
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.date = date
        self.state = state
        self.createdDate = createdDate
    }
}
