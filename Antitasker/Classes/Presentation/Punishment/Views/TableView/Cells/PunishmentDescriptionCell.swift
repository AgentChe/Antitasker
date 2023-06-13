//
//  PunishmentDescriptionCell.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 13.06.2023.
//

import UIKit

final class PunishmentDescriptionCell: UITableViewCell {
    lazy var titleLabel = makeTitleLabel()
    lazy var punishmentLabel = makeLabel()
    
    private lazy var punishmentAttrs = TextAttributes()
        .textColor(UIColor(integralRed: 29, green: 29, blue: 29))
        .font(Fonts.Ubuntu.light(size: 16.scale))
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
extension PunishmentDescriptionCell {
    func setup(element: String) {
        punishmentLabel.attributedText = element.attributed(with: punishmentAttrs)
    }
}

// MARK: Private
private extension PunishmentDescriptionCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension PunishmentDescriptionCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20.scale)
        ])
        
        NSLayoutConstraint.activate([
            punishmentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            punishmentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            punishmentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16.scale),
            punishmentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension PunishmentDescriptionCell {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 29, green: 29, blue: 29))
            .font(Fonts.Ubuntu.bold(size: 20.scale))
            .lineHeight(22.scale)
            .letterSpacing(-0.41.scale)
            .textAlignment(.left)
        
        let view = UILabel()
        view.attributedText = "Punishment.Description.Title".localized.attributed(with: attrs)
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
