//
//  DiscontentAlertView.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 03.06.2023.
//

import UIKit

final class DiscontentAlertView: UIView {
    lazy var container = makeContainer()
    lazy var imageView = makeImageView()
    lazy var textLabel = makeTextLabel()
    lazy var button = makeButton()
    
    private let name: String
    
    init(name: String) {
        self.name = name
        
        super.init(frame: .zero)

        makeConstraints()
        initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension DiscontentAlertView {
    func initialize() {
        backgroundColor = UIColor.white.withAlphaComponent(0)
    }
}

// MARK: Make constraints
private extension DiscontentAlertView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            container.widthAnchor.constraint(equalToConstant: 343.scale),
            container.centerXAnchor.constraint(equalTo: centerXAnchor),
            container.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 240.scale : 150.scale)
        ])
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 57.scale),
            imageView.heightAnchor.constraint(equalToConstant: 57.scale),
            imageView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: container.topAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            textLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.scale),
            textLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 84.scale),
            textLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -76.scale)
        ])
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            button.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.scale),
            button.heightAnchor.constraint(equalToConstant: 48.scale),
            button.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 12.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension DiscontentAlertView {
    func makeContainer() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 20.scale
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "Discontent.Image")
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeTextLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 29, green: 29, blue: 29))
            .font(Fonts.Ubuntu.regular(size: 16.scale))
            .lineHeight(20.scale)
            .letterSpacing(-0.3.scale)
            .textAlignment(.center)
        let string = String(format: "Discontent.Text".localized, name)
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = string.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.Ubuntu.medium(size: 17.scale))
            .letterSpacing(-0.41.scale)
        
        let view = UIButton()
        view.backgroundColor = UIColor(integralRed: 28, green: 55, blue: 209)
        view.layer.cornerRadius = 12.scale
        view.setAttributedTitle("Discontent.Button".localized.attributed(with: attrs), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
}
