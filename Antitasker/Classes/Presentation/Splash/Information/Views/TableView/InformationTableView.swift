//
//  InformationTableView.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 30.05.2023.
//

import UIKit
import RxSwift
import RxCocoa

final class InformationTableView: UITableView {
    lazy var sections = [InformationTableSection]()
    
    private lazy var didTapButtonTrigger = PublishRelay<Void>()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension InformationTableView {
    func setup(sections: [InformationTableSection]) {
        self.sections = sections
        
        reloadData()
    }
    
    var didTapButton: Signal<Void> {
        didTapButtonTrigger.asSignal()
    }
}

// MARK: UITableViewDataSource
extension InformationTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let s = sections[section]
        return s.opened ? s.openedElements.count : s.closedElements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        let elements = section.opened ? section.openedElements : section.closedElements
        
        switch elements[indexPath.row] {
        case .image:
            return dequeueReusableCell(withIdentifier: String(describing: InformationImageCell.self), for: indexPath)
        case .section(let element):
            let cell = dequeueReusableCell(withIdentifier: String(describing: InformationSectionCell.self), for: indexPath) as! InformationSectionCell
            cell.setup(element: element)
            return cell
        case .separator:
            return dequeueReusableCell(withIdentifier: String(describing: InformationSeparatorCell.self), for: indexPath)
        case .button:
            return dequeueReusableCell(withIdentifier: String(describing: InformationButtonCell.self), for: indexPath)
        case .text(let element):
            let cell = dequeueReusableCell(withIdentifier: String(describing: InformationTextCell.self), for: indexPath) as! InformationTextCell
            cell.setup(element: element)
            return cell
        case .fatigue(let element):
            let cell = dequeueReusableCell(withIdentifier: String(describing: InformationFatigueCell.self), for: indexPath) as! InformationFatigueCell
            cell.setup(element: element)
            return cell
        }
    }
}

// MARK: UITableViewDelegate
extension InformationTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        let elements = section.opened ? section.openedElements : section.closedElements
        
        switch elements[indexPath.row] {
        case .button:
            didTapButtonTrigger.accept(Void())
        case .section(let element):
            element.opened.toggle()
            section.opened.toggle()
            
            reloadSections([indexPath.section], with: .automatic)
        default:
            return
        }
    }
}

// MARK: Private
private extension InformationTableView {
    func initialize() {
        register(InformationImageCell.self, forCellReuseIdentifier: String(describing: InformationImageCell.self))
        register(InformationSeparatorCell.self, forCellReuseIdentifier: String(describing: InformationSeparatorCell.self))
        register(InformationSectionCell.self, forCellReuseIdentifier: String(describing: InformationSectionCell.self))
        register(InformationButtonCell.self, forCellReuseIdentifier: String(describing: InformationButtonCell.self))
        register(InformationTextCell.self, forCellReuseIdentifier: String(describing: InformationTextCell.self))
        register(InformationFatigueCell.self, forCellReuseIdentifier: String(describing: InformationFatigueCell.self))
        
        dataSource = self
        delegate = self
    }
}
