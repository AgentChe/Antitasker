//
//  InformationTableElement.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 30.05.2023.
//

final class InformationTableSection {
    var opened: Bool
    let openedElements: [InformationTableElement]
    let closedElements: [InformationTableElement]
    
    init(
        opened: Bool,
        openedElements: [InformationTableElement],
        closedElements: [InformationTableElement]
    ) {
        self.opened = opened
        self.openedElements = openedElements
        self.closedElements = closedElements
    }
}

enum InformationTableElement {
    case image
    case section(InformationSectionElement)
    case separator
    case button
    case text(InformationTextElement)
    case fatigue(InformationFatigueElement)
}

final class InformationSectionElement {
    let name: String
    var opened: Bool
    
    init(
        name: String,
        opened: Bool
    ) {
        self.name = name
        self.opened = opened
    }
}

enum InformationTextElement {
    case fatigues
    case balls
    case punishments
}

struct InformationFatigueElement {
    let fatigue: Fatigue
    let withBalls: Bool
}
