//
//  SplashView.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 23.05.2023.
//

import UIKit

final class SplashView: UIView {
    lazy var imageView = makeImageView()
    lazy var tag1Label = makeTagLabel(text: "Splash.Tag1".localized)
    lazy var tag2Label = makeTagLabel(text: "Splash.Tag2".localized)
    lazy var tag3Label = makeTagLabel(text: "Splash.Tag3".localized)
    
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
private extension SplashView {
    func initialize() {
        backgroundColor = UIColor.white
        
        tag1Label.backgroundColor = UIColor(integralRed: 28, green: 55, blue: 209)
        tag2Label.backgroundColor = UIColor(integralRed: 242, green: 155, blue: 25)
        tag3Label.backgroundColor = UIColor(integralRed: 105, green: 126, blue: 248)
    }
}

// MARK: Make constraints
private extension SplashView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 383.scale),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 109.scale : 30.scale)
        ])
        
        NSLayoutConstraint.activate([
            tag1Label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21.scale),
            tag1Label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            tag2Label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 189.scale),
            tag2Label.topAnchor.constraint(equalTo: tag1Label.bottomAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            tag3Label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 75.scale),
            tag3Label.topAnchor.constraint(equalTo: tag2Label.bottomAnchor, constant: 24.scale)
        ])
    }
}

// MARK: Lazy initialiation
private extension SplashView {
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "Splash.Image")
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTagLabel(text: String) -> PaddingLabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.Ubuntu.regular(size: 18.scale))
            .lineHeight(22.scale)
            .textAlignment(.left)
            .letterSpacing(-0.41.scale)
        
        let view = PaddingLabel()
        view.layer.cornerRadius = 20.scale
        view.layer.masksToBounds = true
        view.insets = UIEdgeInsets(top: 12.scale, left: 20.scale, bottom: 12.scale, right: 20.scale)
        view.numberOfLines = 0
        view.attributedText = text.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
