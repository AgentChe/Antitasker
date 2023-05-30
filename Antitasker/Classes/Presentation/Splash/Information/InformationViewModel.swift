//
//  InformationViewModel.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 30.05.2023.
//

import RxSwift
import RxCocoa

final class InformationViewModel {
    enum Route {
        case main
    }
}

// MARK: Public
extension InformationViewModel {
    struct Input {
        let didTapButton: Signal<Void>
    }
    
    struct Output {
        let sections: Driver<[InformationTableSection]>
        let route: Driver<Route>
    }
    
    func configure(input: Input) -> Output {
        Output(
            sections: makeSections(),
            route: makeRoute(didTapButton: input.didTapButton)
        )
    }
}

// MARK: Private
private extension InformationViewModel {
    func makeSections() -> Driver<[InformationTableSection]> {
        Single<[InformationTableSection]>
            .create { event in
                var sections = [InformationTableSection]()
                
                let image = InformationTableSection(opened: true, openedElements: [.image], closedElements: [])
                sections.append(image)
                
                let fatiguesSection = InformationSectionElement(
                    name: "Information.Fatigues".localized,
                    opened: false
                )
                let fatigues = InformationTableSection(
                    opened: false,
                    openedElements: [
                        .section(fatiguesSection),
                        .text(.fatigues),
                        .fatigue(.init(fatigue: .workLikeHorse, withBalls: false)),
                        .fatigue(.init(fatigue: .ratherWeekend, withBalls: false)),
                        .fatigue(.init(fatigue: .eyesOnClock, withBalls: false)),
                        .fatigue(.init(fatigue: .whenIsHoliday, withBalls: false)),
                        .fatigue(.init(fatigue: .maternityLeave, withBalls: false)),
                        .fatigue(.init(fatigue: .bali, withBalls: false)),
                        .separator
                    ],
                    closedElements: [
                        .section(fatiguesSection),
                        .separator
                    ]
                )
                sections.append(fatigues)
                
                let ballsSections = InformationSectionElement(
                    name: "Information.Balls".localized,
                    opened: false
                )
                let balls = InformationTableSection(
                    opened: false,
                    openedElements: [
                        .section(ballsSections),
                        .text(.balls),
                        .fatigue(.init(fatigue: .workLikeHorse, withBalls: true)),
                        .fatigue(.init(fatigue: .ratherWeekend, withBalls: true)),
                        .fatigue(.init(fatigue: .eyesOnClock, withBalls: true)),
                        .fatigue(.init(fatigue: .whenIsHoliday, withBalls: true)),
                        .fatigue(.init(fatigue: .maternityLeave, withBalls: true)),
                        .fatigue(.init(fatigue: .bali, withBalls: true)),
                        .separator
                    ],
                    closedElements: [
                        .section(ballsSections),
                        .separator
                    ]
                )
                sections.append(balls)
                
                let punishmentsSections = InformationSectionElement(
                    name: "Information.Punishment".localized,
                    opened: false
                )
                let punishments = InformationTableSection(
                    opened: false,
                    openedElements: [
                        .section(punishmentsSections),
                        .text(.punishments)
                    ],
                    closedElements: [
                        .section(punishmentsSections)
                    ]
                )
                sections.append(punishments)
                
                let button = InformationTableSection(opened: true, openedElements: [.button], closedElements: [])
                sections.append(button)
                
                event(.success(sections))
                
                return Disposables.create()
            }
            .asDriver(onErrorJustReturn: [])
    }
    
    func makeRoute(didTapButton: Signal<Void>) -> Driver<Route> {
        didTapButton
            .map { Route.main }
            .asDriver(onErrorDriveWith: .never())
    }
}
