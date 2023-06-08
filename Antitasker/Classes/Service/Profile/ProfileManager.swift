//
//  ProfileManager.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 30.05.2023.
//

import RxSwift

protocol ProfileManagerProtocol {
    func obtainProfile() -> Single<Profile?>
    func set(name: String) -> Single<Void>
}

final class ProfileManager {
    enum Constants {
        static let profileKey = "profile_manager_profile_key"
    }
}

// MARK: ProfileManagerProtocol
extension ProfileManager: ProfileManagerProtocol {
    func obtainProfile() -> Single<Profile?> {
        Single<Profile?>.create { event in
            guard
                let data = UserDefaults.standard.data(forKey: Constants.profileKey),
                let profile = try? JSONDecoder().decode(Profile.self, from: data)
            else {
                event(.success(nil))
                return Disposables.create()
            }
            
            event(.success(profile))
            
            return Disposables.create()
        }
    }
    
    func set(name: String) -> Single<Void> {
        obtainProfile()
            .flatMap { profile -> Single<Void> in
                Single<Void>.create { event in
                    let profile = Profile(name: name, fatigueBalls: profile?.fatigueBalls ?? 0)
                    
                    if let data = try? JSONEncoder().encode(profile) {
                        UserDefaults.standard.set(data, forKey: Constants.profileKey)
                    }
                    
                    event(.success(Void()))
                    
                    ProfileMediator.shared.profileChanged()
                    
                    return Disposables.create()
                }
            }
    }
}
