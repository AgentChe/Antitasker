//
//  SchedulerHeaderCell.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 05.06.2023.
//

import UIKit

final class SchedulerHeaderCell: UITableViewCell {
    lazy var nameLabel = makeLabel(numberOfLines: 1)
    lazy var ballsLabel = makeLabel(numberOfLines: 1)
    lazy var fatigueTitleLabel = makeFatigueTitleLabel()
    lazy var fatigueValueLabel = makeLabel(numberOfLines: 3)
    lazy var percentBackgroundView = makeScoreView(color: UIColor(integralRed: 254, green: 245, blue: 232))
    lazy var percentView = makeScoreView(color: UIColor(integralRed: 242, green: 155, blue: 25))
    lazy var tagContainer = makeTagContainer()
    lazy var tagLabel = makeTagLabel()
    lazy var largeCircleView = makeLargeCircleView()
    lazy var smallCircleView = makeSmallCircleView()
    
    private lazy var percentHeightConstrant = NSLayoutConstraint()
    
    private lazy var nameAttrs = TextAttributes()
        .textColor(UIColor(integralRed: 29, green: 29, blue: 29))
        .font(Fonts.Ubuntu.medium(size: 24.scale))
        .lineHeight(28.scale)
        .textAlignment(.left)
        .letterSpacing(-0.41.scale)
    private lazy var ballsAttrs = TextAttributes()
        .textColor(UIColor(integralRed: 29, green: 29, blue: 29))
        .font(Fonts.Ubuntu.regular(size: 16.scale))
        .lineHeight(20.scale)
        .textAlignment(.center)
        .letterSpacing(-0.3.scale)
    private lazy var fatigueAttrs = TextAttributes()
        .textColor(UIColor(integralRed: 29, green: 29, blue: 29))
        .font(Fonts.Ubuntu.regular(size: 14.scale))
        .lineHeight(16.scale)
        .textAlignment(.left)
        .letterSpacing(-0.3.scale)
    private lazy var tagAttrs = TextAttributes()
        .textColor(UIColor.white)
        .font(Fonts.Ubuntu.regular(size: 14.scale))
        .lineHeight(16.scale)
        .textAlignment(.left)
        .letterSpacing(-0.3.scale)
    
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
extension SchedulerHeaderCell {
    func setup(element: SchedulerHeaderElement) {
        let name = String(format: "Scheduler.Header.Hello".localized, element.name)
        nameLabel.attributedText = name.attributed(with: nameAttrs)
        
        let fatigueBalls = element.fatigueBalls
        
        let ballsString = String.choosePluralForm(
            byNumber: fatigueBalls,
            one: String(format: "Scheduler.Header.Ball".localized, fatigueBalls),
            two: String(format: "Scheduler.Header.Balls".localized, fatigueBalls),
            many: String(format: "Scheduler.Header.ManyBalls".localized, fatigueBalls)
        )
        ballsLabel.attributedText = ballsString.attributed(with: ballsAttrs)
        
        let fatigue: String
        switch element.fatigue {
        case .workLikeHorse:
            fatigue = "Information.Fatigue.WorkLikeHorse".localized
        case .ratherWeekend:
            fatigue = "Information.Fatigue.RatherWeekend".localized
        case .eyesOnClock:
            fatigue = "Information.Fatigue.EyesOnClock".localized
        case .whenIsHoliday:
            fatigue = "Information.Fatigue.WhenIsHoliday".localized
        case .maternityLeave:
            fatigue = "Information.Fatigue.MaternityLeave".localized
        case .bali:
            fatigue = "Information.Fatigue.Bali".localized
        }
        fatigueValueLabel.attributedText = fatigue.attributed(with: fatigueAttrs)
        
        tagLabel.attributedText = element.tag.attributed(with: tagAttrs)
        
        let percentHeight = 205.scale / CGFloat(100) * CGFloat(element.fatiguePercent)
        percentHeightConstrant.isActive = false
        percentHeightConstrant.constant = min(205.scale, percentHeight)
        percentHeightConstrant.isActive = true
        
        layoutIfNeeded()
    }
}

// MARK: Private
private extension SchedulerHeaderCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension SchedulerHeaderCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -110.scale)
        ])
        
        NSLayoutConstraint.activate([
            tagContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 44.scale),
            tagContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -128.scale),
            tagContainer.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 28.scale)
        ])
        
        NSLayoutConstraint.activate([
            tagLabel.leadingAnchor.constraint(equalTo: tagContainer.leadingAnchor, constant: 12.scale),
            tagLabel.trailingAnchor.constraint(equalTo: tagContainer.trailingAnchor, constant: -12.scale),
            tagLabel.topAnchor.constraint(equalTo: tagContainer.topAnchor, constant: 8.scale),
            tagLabel.bottomAnchor.constraint(equalTo: tagContainer.bottomAnchor, constant: -8.scale)
        ])
        
        NSLayoutConstraint.activate([
            largeCircleView.widthAnchor.constraint(equalToConstant: 17.scale),
            largeCircleView.heightAnchor.constraint(equalToConstant: 17.scale),
            largeCircleView.trailingAnchor.constraint(equalTo: tagContainer.leadingAnchor),
            largeCircleView.topAnchor.constraint(equalTo: tagContainer.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            smallCircleView.widthAnchor.constraint(equalToConstant: 11.scale),
            smallCircleView.heightAnchor.constraint(equalToConstant: 11.scale),
            smallCircleView.trailingAnchor.constraint(equalTo: largeCircleView.leadingAnchor),
            smallCircleView.topAnchor.constraint(equalTo: largeCircleView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            ballsLabel.centerXAnchor.constraint(equalTo: percentBackgroundView.centerXAnchor),
            ballsLabel.bottomAnchor.constraint(equalTo: percentBackgroundView.topAnchor, constant: -4.scale)
        ])
        
        NSLayoutConstraint.activate([
            percentBackgroundView.widthAnchor.constraint(equalToConstant: 96.scale),
            percentBackgroundView.heightAnchor.constraint(equalToConstant: 205.scale),
            percentBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24.scale),
            percentBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale)
        ])
        
        percentHeightConstrant = percentView.heightAnchor.constraint(equalToConstant: 0)
        NSLayoutConstraint.activate([
            percentView.widthAnchor.constraint(equalToConstant: 96.scale),
            percentView.bottomAnchor.constraint(equalTo: percentBackgroundView.bottomAnchor),
            percentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            percentHeightConstrant
        ])
        
        NSLayoutConstraint.activate([
            fatigueTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            fatigueTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -110.scale),
            fatigueTitleLabel.bottomAnchor.constraint(equalTo: fatigueValueLabel.topAnchor, constant: -8.scale)
        ])
        
        NSLayoutConstraint.activate([
            fatigueValueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            fatigueValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -110.scale),
            fatigueValueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension SchedulerHeaderCell {
    func makeLabel(numberOfLines: Int) -> UILabel {
        let view = UILabel()
        view.numberOfLines = numberOfLines
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeFatigueTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 28, green: 55, blue: 209))
            .font(Fonts.Ubuntu.regular(size: 16.scale))
            .lineHeight(20.scale)
            .letterSpacing(-0.3.scale)
            .textAlignment(.left)
        
        let view = UILabel()
        view.attributedText = "Scheduler.Header.Level".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeScoreView(color: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        view.layer.cornerRadius = 12.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeTagContainer() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(integralRed: 28, green: 55, blue: 209)
        view.layer.cornerRadius = 12.scale
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeTagLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        tagContainer.addSubview(view)
        return view
    }
    
    func makeLargeCircleView() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 8.5.scale
        view.backgroundColor = UIColor(integralRed: 141, green: 155, blue: 232)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeSmallCircleView() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 5.5.scale
        view.backgroundColor = UIColor(integralRed: 210, green: 215, blue: 246)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
