//
//  SchedulerTableElement.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 05.06.2023.
//

enum SchedulerTableElement {
    case header(SchedulerHeaderElement)
    case calendar
    case date(String)
    case task(Task)
    case empty
    case easterTask(EasterTask)
}

struct SchedulerHeaderElement {
    let name: String
    let fatigueBalls: Int
    let fatigue: Fatigue
    let fatiguePercent: Int
    let tag: String
}
