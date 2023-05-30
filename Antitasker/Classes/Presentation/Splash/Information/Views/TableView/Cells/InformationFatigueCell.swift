//
//  InformationFatigueCell.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 30.05.2023.
//

import UIKit

final class InformationFatigueCell: UITableViewCell {
    lazy var label = makeLabel()
    
    private lazy var attrs = TextAttributes()
        .textColor(UIColor(integralRed: 29, green: 29, blue: 29))
        .font(Fonts.Ubuntu.light(size: 15.scale))
        .lineHeight(20.scale)
        .letterSpacing(-0.3.scale)
        .textAlignment(.left)
    private lazy var selectionAttrs = TextAttributes()
        .textColor(UIColor(integralRed: 29, green: 29, blue: 29))
        .font(Fonts.Ubuntu.medium(size: 15.scale))
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
extension InformationFatigueCell {
    func setup(element: InformationFatigueElement) {
        let string: String
        switch element.fatigue {
        case .workLikeHorse:
            string = "Information.Fatigue.WorkLikeHorse".localized
        case .ratherWeekend:
            string = "Information.Fatigue.RatherWeekend".localized
        case .eyesOnClock:
            string = "Information.Fatigue.EyesOnClock".localized
        case .whenIsHoliday:
            string = "Information.Fatigue.WhenIsHoliday".localized
        case .maternityLeave:
            string = "Information.Fatigue.MaternityLeave".localized
        case .bali:
            string = "Information.Fatigue.Bali".localized
        }
        
        let mutableString = NSMutableAttributedString(attributedString: string.attributed(with: attrs))
        
        if element.withBalls {
            mutableString.append(": ".attributed(with: attrs))
            
            let ballsRange = element.fatigue.range
            let ballsString = String(format: "%i - %i", ballsRange.from, ballsRange.to)
            mutableString.append(ballsString.attributed(with: selectionAttrs))
        }
        
        label.attributedText = mutableString
    }
}

// MARK: Private
private extension InformationFatigueCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension InformationFatigueCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12.scale),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension InformationFatigueCell {
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
