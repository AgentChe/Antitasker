//
//  SchedulerEasterTaskCell.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 07.06.2023.
//

import UIKit

final class SchedulerEasterTaskCell: UITableViewCell {
    lazy var container = makeContainer()
    lazy var label = makeLabel()
    lazy var pictureView = makeImageView()
    
    private lazy var attrs = TextAttributes()
        .textColor(UIColor.white)
        .font(Fonts.Ubuntu.regular(size: 16.scale))
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
extension SchedulerEasterTaskCell {
    func setup(element: EasterTask) {
        label.attributedText = element.text.attributed(with: attrs)
    }
}

// MARK: Private
private extension SchedulerEasterTaskCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension SchedulerEasterTaskCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12.scale),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12.scale),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -126.scale),
            label.topAnchor.constraint(equalTo: container.topAnchor, constant: 12.scale),
            label.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -12.scale)
        ])
        
        NSLayoutConstraint.activate([
            pictureView.widthAnchor.constraint(equalToConstant: 100.scale),
            pictureView.heightAnchor.constraint(equalToConstant: 100.scale),
            pictureView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            pictureView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -22.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension SchedulerEasterTaskCell {
    func makeContainer() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(integralRed: 242, green: 155, blue: 25)
        view.layer.cornerRadius = 12.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.image = UIImage(named: "Scheduler.EasterTask")
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
}

// MARK: Additional (EasterTask)
private extension EasterTask {
    var text: String {
        switch self {
        case .friends:
            return "Scheduler.EasterTask.Friends".localized
        }
    }
}
