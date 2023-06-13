//
//  ProfileObserver.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 13.06.2023.
//

import RxSwift
import RxCocoa

final class ProfileObserver {
    static let shared = ProfileObserver()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var profileManager = ProfileManager()
    
    private init() {}
}

// MARK: Public
extension ProfileObserver {
    func observe() {
        TaskMediator.shared
            .didCompletedTask
            .asObservable()
            .flatMap { id -> Single<Void> in
                Self.shared.profileManager
                    .add(fatigueBalls: 10) 
            }
            .subscribe()
            .disposed(by: disposeBag)
    }
}
