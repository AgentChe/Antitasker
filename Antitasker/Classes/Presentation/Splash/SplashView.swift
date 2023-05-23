//
//  SplashView.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 23.05.2023.
//

import UIKit

final class SplashView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension SplashView {
    func initialize() {
        backgroundColor = UIColor.white
    }
}

// MARK: Make constraints
private extension SplashView {
    func makeConstraints() {
        
    }
}

// MARK: Lazy initialiation
private extension SplashView {
    
}
