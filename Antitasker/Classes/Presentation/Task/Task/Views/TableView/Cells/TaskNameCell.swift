//
//  TaskNameCell.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 05.06.2023.
//

import UIKit

final class TaskNameCell: UITableViewCell {
    lazy var nameLabel = makeLabel()
    lazy var statusLabel = makeLabel()
    lazy var circleView = makeCircleView()
    
    private lazy var nameAttrs = TextAttributes()
        .textColor(UIColor(integralRed: 29, green: 29, blue: 29))
        .font(Fonts.Ubuntu.medium(size: 18.scale))
        .lineHeight(22.scale)
        .textAlignment(.left)
        .letterSpacing(-0.41.scale)
    private lazy var openAttrs = TextAttributes()
        .textColor(UIColor(integralRed: 25, green: 178, blue: 0))
        .font(Fonts.Ubuntu.regular(size: 14.scale))
        .lineHeight(16.scale)
        .textAlignment(.left)
        .letterSpacing(-0.41.scale)
    private lazy var completedAttrs = TextAttributes()
        .textColor(UIColor(integralRed: 242, green: 155, blue: 25))
        .font(Fonts.Ubuntu.regular(size: 14.scale))
        .lineHeight(16.scale)
        .textAlignment(.left)
        .letterSpacing(-0.41.scale)
    
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
extension TaskNameCell {
    func setup(element: TaskNameElement) {
        nameLabel.attributedText = element.name.attributed(with: nameAttrs)
        
        let stateColor: UIColor
        let stateText: String
        let stateAttrs: TextAttributes
        
        switch element.status {
        case .open:
            stateColor = UIColor(integralRed: 25, green: 178, blue: 0)
            stateText = "Task.State.Open".localized
            stateAttrs = openAttrs
        case .completed:
            stateColor = UIColor(integralRed: 242, green: 155, blue: 25)
            stateText = "Task.State.Completed".localized
            stateAttrs = completedAttrs
        }
        
        circleView.backgroundColor = stateColor
        statusLabel.attributedText = stateText.attributed(with: stateAttrs)
    }
}

// MARK: Private
private extension TaskNameCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension TaskNameCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -100.scale),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32.scale),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            statusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            statusLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            circleView.widthAnchor.constraint(equalToConstant: 8.scale),
            circleView.heightAnchor.constraint(equalToConstant: 8.scale),
            circleView.trailingAnchor.constraint(equalTo: statusLabel.leadingAnchor, constant: -4.scale),
            circleView.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension TaskNameCell {
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeCircleView() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 4.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
