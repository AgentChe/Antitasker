//
//  PunishmentViewModel.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 13.06.2023.
//

import RxSwift
import RxCocoa

final class PunishmentViewModel {
    enum Route {
        case dismiss
    }
    
    private lazy var profile = makeProfile()
    private let punishment: Driver<Punishment>
    
    private lazy var profileManager = ProfileManager()
    
    init(punishment: Punishment) {
        self.punishment = BehaviorRelay(value: punishment).asDriver()
    }
}

// MARK: Public
extension PunishmentViewModel {
    struct Input {
        let didTapDone: Signal<Void>
    }
    
    struct Output {
        let elements: Driver<[PunishmentTableElement]>
        let route: Driver<Route>
    }
    
    func configure(input: Input) -> Output {
        Output(
            elements: makeElements(),
            route: makeRoute(didTapDone: input.didTapDone)
        )
    }
}

// MARK: Private
private extension PunishmentViewModel {
    func makeElements() -> Driver<[PunishmentTableElement]> {
        Driver
            .combineLatest(
                profile,
                punishment
            )
            .map { profile, punishment -> [PunishmentTableElement] in
                var result = [PunishmentTableElement]()
                
                let fatigue: String
                switch Fatigue(balls: profile.fatigueBalls) {
                case .workLikeHorse:
                    fatigue = "Information.Fatigue.WorkLikeHorse".localized
                case .ratherWeekend:
                    fatigue = "Information.Fatigue.RatherWeekend".localized
                case .eyesOnClock:
                    fatigue = "Information.Fatigue.EyesOnClock".localized
                case .whenIsHoliday:
                    fatigue = "Information.Fatigue.WhenIsHoliday".localized
                case .maternityLeave:
                    fatigue = "Information.Fatigue.MaternityLeave".localized
                case .bali:
                    fatigue = "Information.Fatigue.Bali".localized
                }
                
                switch punishment {
                case .screen:
                    result.append(contentsOf: [
                        .image("Punishment.Screen"),
                        .fatigue(fatigue),
                        .punishment("Punishment.Screen.Description".localized)
                    ])
                case .fastfood:
                    result.append(contentsOf: [
                        .image("Punishment.FastFood"),
                        .fatigue(fatigue),
                        .punishment("Punishment.FastFood.Description".localized)
                    ])
                case .spa:
                    result.append(contentsOf: [
                        .image("Punishment.SPA"),
                        .fatigue(fatigue),
                        .punishment("Punishment.SPA.Description".localized)
                    ])
                case .virus:
                    result.append(contentsOf: [
                        .image("Punishment.Virus"),
                        .fatigue(fatigue),
                        .punishment("Punishment.Virus.Description".localized)
                    ])
                }
                
                result.append(.done)
                
                return result
            }
    }
    
    func makeRoute(didTapDone: Signal<Void>) -> Driver<Route> {
        didTapDone
            .map { Route.dismiss }
            .asDriver(onErrorDriveWith: .never())
    }
    
    func makeProfile() -> Driver<Profile> {
        profileManager
            .obtainProfile()
            .compactMap { $0 }
            .asDriver(onErrorDriveWith: .never())
    }
}
