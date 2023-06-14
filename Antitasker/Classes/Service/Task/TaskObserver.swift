//
//  TaskObserver.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 13.06.2023.
//

import RxSwift
import RxCocoa

final class TaskObserver {
    static let shared = TaskObserver()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var profile = makeProfile()
    
    private lazy var profileManager = ProfileManager()
    private lazy var taskManager = TaskManager()
    
    private init() {}
}

// MARK: Public
extension TaskObserver {
    func observe() {
        profile
            .map { Fatigue(balls: $0.fatigueBalls) }
            .scan((false, nil)) { previous, rhs -> (Bool, Fatigue?) in
                guard let lhs = previous.1 else {
                    return (false, rhs)
                }
                
                return (rhs > lhs, rhs)
            }
            .map { $0.0 }
            .filter { $0 }
            .flatMapLatest { up -> Single<Void> in
                Self.shared.taskManager
                    .appointPunishment()
            }
            .subscribe()
            .disposed(by: disposeBag)
    }
}

// MARK: Private
private extension TaskObserver {
    func makeProfile() -> Observable<Profile> {
        ProfileMediator.shared
            .profileDidChange
            .startWith(())
            .asObservable()
            .flatMapLatest {
                Self.shared.profileManager
                    .obtainProfile()
                    .compactMap { $0 }
            }
    }
}
