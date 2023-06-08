//
//  SchedulerEmptyCell.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 07.06.2023.
//

import UIKit

final class SchedulerEmptyCell: UITableViewCell {
    lazy var pictureView = makeImageView()
    lazy var tag1Container = makeTag1Container()
    lazy var tag1Label = makeTag1Label()
    lazy var tag1LargeCircleView = makeCircleView()
    lazy var tag1SmallCircleView = makeCircleView()
    lazy var tag2Container = makeTag2Container()
    lazy var tag2Label = makeTag2Label()
    lazy var tag2LargeCircleView = makeCircleView()
    lazy var tag2SmallCircleView = makeCircleView()
    
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
private extension SchedulerEmptyCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
        
        tag1LargeCircleView.backgroundColor = UIColor(integralRed: 249, green: 205, blue: 140)
        tag1SmallCircleView.backgroundColor = UIColor(integralRed: 252, green: 235, blue: 209)
        tag2LargeCircleView.backgroundColor = UIColor(integralRed: 141, green: 155, blue: 232)
        tag2SmallCircleView.backgroundColor = UIColor(integralRed: 210, green: 215, blue: 246)
        
        [tag1LargeCircleView, tag2LargeCircleView].forEach { $0.layer.cornerRadius = 8.5.scale }
        [tag1SmallCircleView, tag2SmallCircleView].forEach { $0.layer.cornerRadius = 5.5.scale }
    }
}

// MARK: Make constraints
private extension SchedulerEmptyCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            pictureView.widthAnchor.constraint(equalToConstant: 245.scale),
            pictureView.heightAnchor.constraint(equalToConstant: 245.scale),
            pictureView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            pictureView.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tag1Container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 95.scale),
            tag1Container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -28.scale),
            tag1Container.topAnchor.constraint(equalTo: pictureView.bottomAnchor, constant: 7.scale)
        ])
        
        NSLayoutConstraint.activate([
            tag1Label.leadingAnchor.constraint(equalTo: tag1Container.leadingAnchor, constant: 12.scale),
            tag1Label.trailingAnchor.constraint(equalTo: tag1Container.trailingAnchor, constant: -12.scale),
            tag1Label.topAnchor.constraint(equalTo: tag1Container.topAnchor, constant: 8.scale),
            tag1Label.bottomAnchor.constraint(equalTo: tag1Container.bottomAnchor, constant: -8.scale)
        ])
        
        NSLayoutConstraint.activate([
            tag1LargeCircleView.widthAnchor.constraint(equalToConstant: 17.scale),
            tag1LargeCircleView.heightAnchor.constraint(equalToConstant: 17.scale),
            tag1LargeCircleView.leadingAnchor.constraint(equalTo: tag1Container.trailingAnchor),
            tag1LargeCircleView.topAnchor.constraint(equalTo: tag1Container.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tag1SmallCircleView.widthAnchor.constraint(equalToConstant: 11.scale),
            tag1SmallCircleView.heightAnchor.constraint(equalToConstant: 11.scale),
            tag1SmallCircleView.leadingAnchor.constraint(equalTo: tag1LargeCircleView.trailingAnchor),
            tag1SmallCircleView.topAnchor.constraint(equalTo: tag1LargeCircleView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tag2Container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 37.scale),
            tag2Container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -59.scale),
            tag2Container.topAnchor.constraint(equalTo: tag1Container.bottomAnchor, constant: 37.scale),
            tag2Container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -28.scale)
        ])
        
        NSLayoutConstraint.activate([
            tag2Label.leadingAnchor.constraint(equalTo: tag2Container.leadingAnchor, constant: 12.scale),
            tag2Label.trailingAnchor.constraint(equalTo: tag2Container.trailingAnchor, constant: -12.scale),
            tag2Label.topAnchor.constraint(equalTo: tag2Container.topAnchor, constant: 8.scale),
            tag2Label.bottomAnchor.constraint(equalTo: tag2Container.bottomAnchor, constant: -8.scale)
        ])
        
        NSLayoutConstraint.activate([
            tag2LargeCircleView.widthAnchor.constraint(equalToConstant: 17.scale),
            tag2LargeCircleView.heightAnchor.constraint(equalToConstant: 17.scale),
            tag2LargeCircleView.trailingAnchor.constraint(equalTo: tag2Container.leadingAnchor),
            tag2LargeCircleView.topAnchor.constraint(equalTo: tag2Container.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tag2SmallCircleView.widthAnchor.constraint(equalToConstant: 11.scale),
            tag2SmallCircleView.heightAnchor.constraint(equalToConstant: 11.scale),
            tag2SmallCircleView.trailingAnchor.constraint(equalTo: tag2LargeCircleView.leadingAnchor),
            tag2SmallCircleView.topAnchor.constraint(equalTo: tag2LargeCircleView.bottomAnchor)
        ])
    }
}

// MARK: Lazy initializaition
private extension SchedulerEmptyCell {
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "Scheduler.Empty")
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeTag1Container() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(integralRed: 242, green: 155, blue: 25)
        view.layer.cornerRadius = 12.scale
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeTag2Container() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(integralRed: 28, green: 55, blue: 209)
        view.layer.cornerRadius = 12.scale
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeTag1Label() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.Ubuntu.medium(size: 16.scale))
            .lineHeight(20.scale)
            .letterSpacing(-0.3.scale)
        
        let view = UILabel()
        view.attributedText = "Scheduler.Empty.Tag1".localized.attributed(with: attrs)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        tag1Container.addSubview(view)
        return view
    }
    
    func makeTag2Label() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.Ubuntu.medium(size: 16.scale))
            .lineHeight(20.scale)
            .letterSpacing(-0.3.scale)
        
        let view = UILabel()
        view.attributedText = "Scheduler.Empty.Tag2".localized.attributed(with: attrs)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        tag2Container.addSubview(view)
        return view
    }
    
    func makeCircleView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
