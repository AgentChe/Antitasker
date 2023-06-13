//
//  PunishmentTableView.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 13.06.2023.
//

import UIKit
import RxSwift
import RxCocoa

final class PunishmentTableView: UITableView {
    lazy var elements = [PunishmentTableElement]()
    
    private lazy var didTapDoneTrigger = PublishRelay<Void>()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension PunishmentTableView {
    func setup(elements: [PunishmentTableElement]) {
        self.elements = elements
        
        reloadData()
    }
    
    var didTapDone: Signal<Void> {
        didTapDoneTrigger.asSignal()
    }
}

// MARK: UITableViewDataSource
extension PunishmentTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch elements[indexPath.row] {
        case .image(let element):
            let cell = dequeueReusableCell(withIdentifier: String(describing: PunishmentImageCell.self), for: indexPath) as! PunishmentImageCell
            cell.setup(element: element)
            return cell
        case .fatigue(let element):
            let cell = dequeueReusableCell(withIdentifier: String(describing: PunishmentFatigueCell.self), for: indexPath) as! PunishmentFatigueCell
            cell.setup(element: element)
            return cell
        case .punishment(let element):
            let cell = dequeueReusableCell(withIdentifier: String(describing: PunishmentDescriptionCell.self), for: indexPath) as! PunishmentDescriptionCell
            cell.setup(element: element)
            return cell
        case .done:
            return dequeueReusableCell(withIdentifier: String(describing: PunishmentDoneCell.self), for: indexPath)
        }
    }
}

// MARK: UITableViewDelegate
extension PunishmentTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard case .done = elements[indexPath.row] else {
            return
        }
        
        didTapDoneTrigger.accept(Void())
    }
}

// MARK: Private
private extension PunishmentTableView {
    func initialize() {
        register(PunishmentImageCell.self, forCellReuseIdentifier: String(describing: PunishmentImageCell.self))
        register(PunishmentFatigueCell.self, forCellReuseIdentifier: String(describing: PunishmentFatigueCell.self))
        register(PunishmentDescriptionCell.self, forCellReuseIdentifier: String(describing: PunishmentDescriptionCell.self))
        register(PunishmentDoneCell.self, forCellReuseIdentifier: String(describing: PunishmentDoneCell.self))
        
        dataSource = self
        delegate = self
    }
}
