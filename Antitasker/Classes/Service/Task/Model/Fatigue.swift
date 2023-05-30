//
//  Fatigue.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 30.05.2023.
//

enum Fatigue: Codable, Hashable {
    case workLikeHorse
    case ratherWeekend
    case eyesOnClock
    case whenIsHoliday
    case maternityLeave
    case bali
    
    var range: (from: Int, to: Int) {
        switch self {
        case .workLikeHorse:
            return (from: 0, to: 100)
        case .ratherWeekend:
            return (from: 101, to: 190)
        case .eyesOnClock:
            return (from: 191, to: 270)
        case .whenIsHoliday:
            return (from: 271, to: 340)
        case .maternityLeave:
            return (from: 341, to: 400)
        case .bali:
            return (from: 400, to: 1000)
        }
    }
}
