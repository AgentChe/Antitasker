//
//  PunishmentDoneCell.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 13.06.2023.
//

import UIKit

final class PunishmentDoneCell: UITableViewCell {
    lazy var label = makeLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension PunishmentDoneCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension PunishmentDoneCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.scale),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.scale),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 42.scale),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension PunishmentDoneCell {
    func makeLabel() -> PaddingLabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.Ubuntu.regular(size: 16.scale))
            .lineHeight(20.scale)
            .letterSpacing(-0.3.scale)
            .textAlignment(.center)
        
        let view = PaddingLabel()
        view.layer.cornerRadius = 12.scale
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(integralRed: 28, green: 55, blue: 209)
        view.attributedText = "Punishment.Done".localized.attributed(with: attrs)
        view.insets = UIEdgeInsets(top: 13.scale, left: 0, bottom: 13.scale, right: 0)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
