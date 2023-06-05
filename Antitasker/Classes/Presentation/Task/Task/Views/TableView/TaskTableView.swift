//
//  TaskTableView.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 05.06.2023.
//

import UIKit
import RxSwift
import RxCocoa

final class TaskTableView: UITableView {
    lazy var elements = [TaskTableElement]()
    
    private lazy var didTapCompleteTrigger = PublishRelay<Void>()
    private lazy var didTapDeleteTrigger = PublishRelay<Void>()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension TaskTableView {
    func setup(elements: [TaskTableElement]) {
        self.elements = elements
        
        reloadData()
    }
    
    var didTapComplete: Signal<Void> {
        didTapCompleteTrigger.asSignal()
    }
    
    var didTapDelete: Signal<Void> {
        didTapDeleteTrigger.asSignal()
    }
}

// MARK: UITableViewDataSource
extension TaskTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch elements[indexPath.row] {
        case .image(let element):
            let cell = dequeueReusableCell(withIdentifier: String(describing: TaskImageCell.self), for: indexPath) as! TaskImageCell
            cell.setup(element: element)
            return cell
        case .advice(let element):
            let cell = dequeueReusableCell(withIdentifier: String(describing: TaskAdviceCell.self), for: indexPath) as! TaskAdviceCell
            cell.setup(element: element)
            return cell
        case .name(let element):
            let cell = dequeueReusableCell(withIdentifier: String(describing: TaskNameCell.self), for: indexPath) as! TaskNameCell
            cell.setup(element: element)
            return cell
        case .description(let element):
            let cell = dequeueReusableCell(withIdentifier: String(describing: TaskDescriptionCell.self), for: indexPath) as! TaskDescriptionCell
            cell.setup(element: element)
            return cell
        case .date(let element):
            let cell = dequeueReusableCell(withIdentifier: String(describing: TaskDateCell.self), for: indexPath) as! TaskDateCell
            cell.setup(element: element)
            return cell
        case .complete:
            return dequeueReusableCell(withIdentifier: String(describing: TaskCompleteCell.self), for: indexPath)
        case .delete:
            return dequeueReusableCell(withIdentifier: String(describing: TaskDeleteCell.self), for: indexPath)
        }
    }
}

// MARK: UITableViewDelegate
extension TaskTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch elements[indexPath.row] {
        case .complete:
            didTapCompleteTrigger.accept(Void())
        case .delete:
            didTapDeleteTrigger.accept(Void())
        default:
            return
        }
    }
}

// MARK: Private
private extension TaskTableView {
    func initialize() {
        register(TaskImageCell.self, forCellReuseIdentifier: String(describing: TaskImageCell.self))
        register(TaskAdviceCell.self, forCellReuseIdentifier: String(describing: TaskAdviceCell.self))
        register(TaskNameCell.self, forCellReuseIdentifier: String(describing: TaskNameCell.self))
        register(TaskDescriptionCell.self, forCellReuseIdentifier: String(describing: TaskDescriptionCell.self))
        register(TaskDateCell.self, forCellReuseIdentifier: String(describing: TaskDateCell.self))
        register(TaskCompleteCell.self, forCellReuseIdentifier: String(describing: TaskCompleteCell.self))
        register(TaskDeleteCell.self, forCellReuseIdentifier: String(describing: TaskDeleteCell.self))
        
        dataSource = self
        delegate = self
    }
}
