//
//  CalendarView.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 06.06.2023.
//

import UIKit
import JTAppleCalendar

final class CalendarView: JTACMonthView {
    var didSelectDate: ((Date) -> Void)?

    override init() {
        super.init()
        
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: JTACMonthViewDataSource
extension CalendarView: JTACMonthViewDataSource {
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        let calendar = Calendar.current
        let currentDate = Date()
        
        let startDate = calendar.date(byAdding: .year, value: -2, to: currentDate) ?? currentDate
        let endDate = calendar.date(byAdding: .year, value: 2, to: currentDate) ?? currentDate
        
        return ConfigurationParameters(
            startDate: startDate,
            endDate: endDate,
            numberOfRows: 1,
            firstDayOfWeek: .monday
        )
    }
}

// MARK: JTACMonthViewDelegate
extension CalendarView: JTACMonthViewDelegate {
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: String(describing: CalendarDayCell.self), for: indexPath) as! CalendarDayCell
        configureCell(cell: cell, cellState: cellState)
        return cell
    }
    
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        guard let cell = cell as? CalendarDayCell else {
            return
        }
        
        configureCell(cell: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        guard let cell = cell as? CalendarDayCell else {
            return
        }
        
        cell.marked = cellState.isSelected
        didSelectDate?(date)
    }
    
    func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        guard let cell = cell as? CalendarDayCell else {
            return
        }
        
        cell.marked = cellState.isSelected
    }
}

// MARK: Private
private extension CalendarView {
    func initialize() {
        register(CalendarDayCell.self, forCellWithReuseIdentifier: String(describing: CalendarDayCell.self))
        
        calendarDelegate = self
        calendarDataSource = self
    }
    
    func configureCell(cell: CalendarDayCell, cellState: CellState) {
        cell.setup(text: cellState.text, weekDay: cellState.day)
        cell.marked = cellState.isSelected
    }
}
