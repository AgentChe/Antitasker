//
//  TaskDeleteCell.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 05.06.2023.
//

import UIKit

final class TaskDeleteCell: UITableViewCell {
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
private extension TaskDeleteCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension TaskDeleteCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22.scale),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension TaskDeleteCell {
    func makeLabel() -> PaddingLabel {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 28, green: 55, blue: 209))
            .font(Fonts.Ubuntu.regular(size: 16.scale))
            .lineHeight(20.scale)
            .textAlignment(.center)
            .letterSpacing(-0.3.scale)
        
        let view = PaddingLabel()
        view.attributedText = "Task.Delete".localized.attributed(with: attrs)
        view.insets = UIEdgeInsets(top: 13.scale, left: 0, bottom: 13.scale, right: 0)
        view.backgroundColor = UIColor.clear
        view.layer.cornerRadius = 12.scale
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor(integralRed: 28, green: 55, blue: 209).cgColor
        view.layer.borderWidth = 1.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
