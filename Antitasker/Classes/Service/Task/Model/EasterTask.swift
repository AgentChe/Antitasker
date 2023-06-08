//
//  EasterTask.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 30.05.2023.
//

enum EasterTask: Codable, Hashable {
    case friends
    
    static var all: [EasterTask] {
        [
            .friends
        ]
    }
}
