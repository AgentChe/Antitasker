//
//  PunishmentView.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 13.06.2023.
//

import UIKit

final class PunishmentView: UIView {
    lazy var headerView = makeHeaderView()
    lazy var appIconView = makeAppIconView()
    lazy var appNameLabel = makeAppNameLabel()
    lazy var separator = makeSeparator()
    lazy var tableView = makeTableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension PunishmentView {
    func initialize() {
        backgroundColor = UIColor.white
    }
}

// MARK: Make constraints
private extension PunishmentView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: ScreenSize.isIphoneXFamily ? 90.scale : 70.scale)
        ])
        
        NSLayoutConstraint.activate([
            appIconView.widthAnchor.constraint(equalToConstant: 32.scale),
            appIconView.heightAnchor.constraint(equalToConstant: 32.scale),
            appIconView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -5.scale),
            appIconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 114.scale)
        ])
        
        NSLayoutConstraint.activate([
            appNameLabel.leadingAnchor.constraint(equalTo: appIconView.trailingAnchor, constant: 8.scale),
            appNameLabel.centerYAnchor.constraint(equalTo: appIconView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            separator.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1.scale),
            separator.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension PunishmentView {
    func makeHeaderView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(integralRed: 249, green: 249, blue: 249, alpha: 0.94)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeAppIconView() -> UIImageView {
        let view = UIImageView()
        view.layer.cornerRadius = 16.scale
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "Punishment.AppIcon")
        view.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(view)
        return view
    }
    
    func makeAppNameLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.black)
            .font(Fonts.Ubuntu.medium(size: 16.scale))
            .lineHeight(20.scale)
            .letterSpacing(-0.3.scale)
        
        let view = UILabel()
        view.attributedText = "Punishment.AppName".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(view)
        return view
    }
    
    func makeSeparator() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(integralRed: 60, green: 60, blue: 67, alpha: 0.36)
        view.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(view)
        return view
    }
    
    func makeTableView() -> PunishmentTableView {
        let view = PunishmentTableView()
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 32.scale, right: 0)
        view.setContentOffset(CGPoint.zero, animated: false)
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        view.contentInsetAdjustmentBehavior = .never
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
