//
//  InformationTextCell.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 30.05.2023.
//

import UIKit

final class InformationTextCell: UITableViewCell {
    lazy var label = makeLabel()
    
    private lazy var attrs = TextAttributes()
        .textColor(UIColor(integralRed: 29, green: 29, blue: 29))
        .font(Fonts.Ubuntu.light(size: 15.scale))
        .lineHeight(20.scale)
        .letterSpacing(-0.3.scale)
        .textAlignment(.left)
    private lazy var selectionAttrs = TextAttributes()
        .textColor(UIColor(integralRed: 28, green: 55, blue: 209))
        .font(Fonts.Ubuntu.light(size: 15.scale))
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
extension InformationTextCell {
    func setup(element: InformationTextElement) {
        switch element {
        case .fatigues:
            label.attributedText = "Information.Fatigues.Text".localized.attributed(with: attrs)
        case .balls:
            let add = "Information.Balls.AddBalls".localized
            let minus = "Information.Balls.MinusBalls".localized
            
            let string = String(format: "Information.Balls.Text".localized, add, minus)
            let attrString = string.attributed(with: attrs)
            let mutableString = NSMutableAttributedString(attributedString: attrString)
            
            let addRange = (string as NSString).range(of: add)
            let minusRange = (string as NSString).range(of: minus)
            
            mutableString.addAttributes(selectionAttrs.dictionary, range: addRange)
            mutableString.addAttributes(selectionAttrs.dictionary, range: minusRange)
            
            label.attributedText = mutableString
        case .punishments:
            label.attributedText = "Information.Punishment.Text".localized.attributed(with: attrs)
        }
    }
}

// MARK: Private
private extension InformationTextCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension InformationTextCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.scale),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension InformationTextCell {
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
