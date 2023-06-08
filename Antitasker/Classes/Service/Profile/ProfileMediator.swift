//
//  ProfileMediator.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 05.06.2023.
//

import RxSwift
import RxCocoa

final class ProfileMediator {
    static let shared = ProfileMediator()
    
    private lazy var profileDidChangeTrigger = PublishRelay<Void>()
    
    private init() {}
}

// MARK: Public
extension ProfileMediator {
    func profileChanged() {
        DispatchQueue.main.async { [weak self] in
            self?.profileDidChangeTrigger.accept(Void())
        }
    }
    
    var profileDidChange: Signal<Void> {
        profileDidChangeTrigger.asSignal()
    }
}
