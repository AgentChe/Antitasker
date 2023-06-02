//
//  SchedulerView.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 02.06.2023.
//

import UIKit

final class SchedulerView: UIView {
    lazy var separator = makeSeparator()
    
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
private extension SchedulerView {
    func initialize() {
        backgroundColor = UIColor.white
    }
}

// MARK: Make constraints
private extension SchedulerView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            separator.leadingAnchor.constraint(equalTo: leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor),
            separator.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension SchedulerView {
    func makeSeparator() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(integralRed: 236, green: 236, blue: 236)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
