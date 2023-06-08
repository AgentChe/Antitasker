//
//  SchedulerTableView.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 05.06.2023.
//

import UIKit
import RxSwift
import RxCocoa

final class SchedulerTableView: UITableView {
    lazy var elements = [SchedulerTableElement]()
    
    private lazy var didSelectDateTrigger = PublishRelay<Date>()
    private lazy var didSelectTaskTrigger = PublishRelay<Task>()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension SchedulerTableView {
    func setup(elements: [SchedulerTableElement]) {
        self.elements = elements
        
        reloadData()
    }
    
    var didSelectDate: Signal<Date> {
        didSelectDateTrigger.asSignal()
    }
    
    var didSelectTask: Signal<Task> {
        didSelectTaskTrigger.asSignal()
    }
}

// MARK: UITableViewDataSource
extension SchedulerTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch elements[indexPath.row] {
        case .header(let element):
            let cell = dequeueReusableCell(withIdentifier: String(describing: SchedulerHeaderCell.self), for: indexPath) as! SchedulerHeaderCell
            cell.setup(element: element)
            return cell
        case .calendar:
            let cell = dequeueReusableCell(withIdentifier: String(describing: SchedulerCalendarCell.self), for: indexPath) as! SchedulerCalendarCell
            cell.calendarView.didSelectDate = { [weak self] date in
                self?.didSelectDateTrigger.accept(date)
            }
            return cell
        case .date(let element):
            let cell = dequeueReusableCell(withIdentifier: String(describing: SchedulerDateCell.self), for: indexPath) as! SchedulerDateCell
            cell.setup(element: element)
            return cell
        case .task(let element):
            let cell = dequeueReusableCell(withIdentifier: String(describing: SchedulerTaskCell.self), for: indexPath) as! SchedulerTaskCell
            cell.setup(element: element)
            return cell
        case .empty:
            return dequeueReusableCell(withIdentifier: String(describing: SchedulerEmptyCell.self), for: indexPath)
        case .easterTask(let element):
            let cell = dequeueReusableCell(withIdentifier: String(describing: SchedulerEasterTaskCell.self), for: indexPath) as! SchedulerEasterTaskCell
            cell.setup(element: element)
            return cell
        }
    }
}

// MARK: UITableViewDelegate
extension SchedulerTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch elements[indexPath.row] {
        case .header:
            return 229.scale
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard case let .task(task) = elements[indexPath.row] else {
            return
        }
        
        didSelectTaskTrigger.accept(task)
    }
}

// MARK: Private
private extension SchedulerTableView {
    func initialize() {
        register(SchedulerHeaderCell.self, forCellReuseIdentifier: String(describing: SchedulerHeaderCell.self))
        register(SchedulerCalendarCell.self, forCellReuseIdentifier: String(describing: SchedulerCalendarCell.self))
        register(SchedulerDateCell.self, forCellReuseIdentifier: String(describing: SchedulerDateCell.self))
        register(SchedulerTaskCell.self, forCellReuseIdentifier: String(describing: SchedulerTaskCell.self))
        register(SchedulerEmptyCell.self, forCellReuseIdentifier: String(describing: SchedulerEmptyCell.self))
        register(SchedulerEasterTaskCell.self, forCellReuseIdentifier: String(describing: SchedulerEasterTaskCell.self))
        
        dataSource = self
        delegate = self
    }
}
