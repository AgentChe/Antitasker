//
//  CalendarDayCell.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 06.06.2023.
//

import UIKit
import JTAppleCalendar

final class CalendarDayCell: JTACDayCell {
    lazy var marked: Bool = false {
        didSet {
            update()
        }
    }
    
    lazy var weekDayLabel = makeLabel()
    lazy var dayLabel = makeLabel()
    
    private lazy var attrs = TextAttributes()
        .textColor(UIColor.white)
        .font(Fonts.Ubuntu.regular(size: 16.scale))
        .lineHeight(20.scale)
        .letterSpacing(-0.3.scale)
        .textAlignment(.center)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension CalendarDayCell {
    func update() {
        layer.cornerRadius = marked ? 6.scale : 0
        backgroundColor = marked ? UIColor(integralRed: 242, green: 155, blue: 25) : UIColor.clear
        
        let textColor = marked ? UIColor.white : UIColor(integralRed: 170, green: 170, blue: 170)
        weekDayLabel.textColor = textColor
        dayLabel.textColor = textColor
    }
    
    func setup(text: String, weekDay: DaysOfWeek) {
        weekDayLabel.attributedText = weekDay.dayName.attributed(with: attrs)
        dayLabel.attributedText = text.attributed(with: attrs)
        
        update()
    }
}

// MARK: Make constraints
private extension CalendarDayCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            weekDayLabel.bottomAnchor.constraint(equalTo: centerYAnchor),
            weekDayLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            dayLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            dayLabel.topAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension CalendarDayCell {
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}

// MARK: Additional (JTAppleCalendar.DaysOfWeek)
private extension JTAppleCalendar.DaysOfWeek {
    var dayName: String {
        switch self {
        case .monday:
            return "Scheduler.DaysOfWeek.Mo".localized
        case .tuesday:
            return "Scheduler.DaysOfWeek.Tu".localized
        case .wednesday:
            return "Scheduler.DaysOfWeek.We".localized
        case .thursday:
            return "Scheduler.DaysOfWeek.Th".localized
        case .friday:
            return "Scheduler.DaysOfWeek.Fr".localized
        case .saturday:
            return "Scheduler.DaysOfWeek.Sa".localized
        case .sunday:
            return "Scheduler.DaysOfWeek.Su".localized
        }
    }
}
