//
//  SchedulerTaskCell.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 06.06.2023.
//

import UIKit

final class SchedulerTaskCell: UITableViewCell {
    lazy var container = makeContainer()
    lazy var label = makeLabel()
    
    private lazy var attrs = TextAttributes()
        .textColor(UIColor(integralRed: 29, green: 29, blue: 29))
        .font(Fonts.Ubuntu.regular(size: 16.scale))
        .lineHeight(20.scale)
        .textAlignment(.left)
        .letterSpacing(-0.3.scale)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension SchedulerTaskCell {
    func setup(element: Task) {
        label.attributedText = element.name.attributed(with: attrs)
    }
}

// MARK: Private
private extension SchedulerTaskCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension SchedulerTaskCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12.scale),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12.scale),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12.scale),
            label.topAnchor.constraint(equalTo: container.topAnchor, constant: 12.scale),
            label.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -12.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension SchedulerTaskCell {
    func makeContainer() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 16.scale
        view.backgroundColor = UIColor(integralRed: 241, green: 243, blue: 252)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
}
