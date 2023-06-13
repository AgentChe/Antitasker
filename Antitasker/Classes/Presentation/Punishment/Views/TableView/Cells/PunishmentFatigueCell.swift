//
//  PunishmentFatigueCell.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 13.06.2023.
//

import UIKit

final class PunishmentFatigueCell: UITableViewCell {
    lazy var titleLabel = makeTitleLabel()
    lazy var fatigueLabel = makeLabel()
    
    private lazy var fatigueAttrs = TextAttributes()
        .textColor(UIColor(integralRed: 28, green: 55, blue: 209))
        .font(Fonts.Ubuntu.regular(size: 16.scale))
        .lineHeight(20.scale)
        .letterSpacing(-0.3.scale)
        .textAlignment(.left)
    
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
extension PunishmentFatigueCell {
    func setup(element: String) {
        fatigueLabel.attributedText = element.attributed(with: fatigueAttrs)
    }
}

// MARK: Private
private extension PunishmentFatigueCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension PunishmentFatigueCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12.scale)
        ])
        
        NSLayoutConstraint.activate([
            fatigueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            fatigueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            fatigueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12.scale),
            fatigueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension PunishmentFatigueCell {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 29, green: 29, blue: 29))
            .font(Fonts.Ubuntu.regular(size: 16.scale))
            .lineHeight(20.scale)
            .letterSpacing(-0.3.scale)
            .textAlignment(.left)
        
        let view = UILabel()
        view.attributedText = "Punishment.Fatigue.Title".localized.attributed(with: attrs)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
