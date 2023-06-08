//
//  SchedulerCalendarCell.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 06.06.2023.
//

import UIKit

final class SchedulerCalendarCell: UITableViewCell {
    lazy var calendarView = makeCalendarView()

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
private extension SchedulerCalendarCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
        
        calendarView.scrollToDate(.init(), animateScroll: false) { [weak self] in
            guard let self = self else {
                return
            }
            
            self.calendarView.selectDates([.init()])
            
            if let today = self.calendarView.indexPathsForSelectedItems?.first {
                self.calendarView.scrollToItem(at: today, at: .centeredVertically, animated: false)
            }
        }
    }
}

// MARK: Make constraints
private extension SchedulerCalendarCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 29.scale),
            calendarView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            calendarView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16.scale),
            calendarView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16.scale),
            calendarView.heightAnchor.constraint(equalToConstant: 56.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension SchedulerCalendarCell {
    func makeCalendarView() -> CalendarView {
        let view = CalendarView()
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = UIColor.clear
        view.scrollingMode = .stopAtEachCalendarFrame
        view.scrollDirection = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
