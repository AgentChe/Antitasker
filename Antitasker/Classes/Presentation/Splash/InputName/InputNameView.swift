//
//  InputNameView.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 30.05.2023.
//

import UIKit

final class InputNameView: UIView {
    lazy var container = makeContainer()
    lazy var titleLabel = makeTitleLabel()
    lazy var textField = makeTextField()
    lazy var button = makeButton()
    
    private lazy var containerCenterYConstraint = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        makeConstraints()
        initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension InputNameView {
    func updatePosition(at keyboardHeight: CGFloat) {
        containerCenterYConstraint.isActive = false
        containerCenterYConstraint.constant = keyboardHeight > 0 ? -50.scale : 0
        containerCenterYConstraint.isActive = true
        
        layoutIfNeeded()
    }
}

// MARK: Private
private extension InputNameView {
    func initialize() {
        backgroundColor = UIColor.white.withAlphaComponent(0)
    }
}

// MARK: Make constraints
private extension InputNameView {
    func makeConstraints() {
        containerCenterYConstraint = container.centerYAnchor.constraint(equalTo: centerYAnchor)
        NSLayoutConstraint.activate([
            container.widthAnchor.constraint(equalToConstant: 343.scale),
            container.heightAnchor.constraint(equalToConstant: 172.scale),
            container.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerCenterYConstraint
        ])

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            textField.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.scale),
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.scale)
        ])
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            button.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.scale),
            button.heightAnchor.constraint(equalToConstant: 46.scale),
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension InputNameView {
    func makeContainer() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 20.scale
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }

    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 29, green: 29, blue: 29))
            .font(Fonts.Ubuntu.medium(size: 17.scale))
            .lineHeight(22.scale)
            .letterSpacing(-0.41.scale)
            .textAlignment(.left)

        let view = UILabel()
        view.attributedText = "InputName.Title".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }

    func makeTextField() -> PaddingTextField {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 29, green: 29, blue: 29))
            .font(Fonts.Ubuntu.regular(size: 16.scale))
            .letterSpacing(-0.3.scale)

        let placeholderAttrs = TextAttributes()
            .textColor(UIColor(integralRed: 170, green: 170, blue: 170))
            .font(Fonts.Ubuntu.regular(size: 16.scale))
            .letterSpacing(-0.3.scale)

        let view = PaddingTextField()
        view.backgroundColor = UIColor(integralRed: 243, green: 244, blue: 246)
        view.textPadding = UIEdgeInsets(top: 12.scale, left: 16.scale, bottom: 16.scale, right: 12.scale)
        view.defaultTextAttributes = attrs.dictionary
        view.attributedPlaceholder = "InputName.Placeholder".localized.attributed(with: placeholderAttrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.Ubuntu.regular(size: 16.scale))
            .letterSpacing(-0.3.scale)
        
        let view = UIButton()
        view.backgroundColor = UIColor(integralRed: 28, green: 55, blue: 209)
        view.layer.cornerRadius = 12.scale
        view.setAttributedTitle("InputName.Button".localized.attributed(with: attrs), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
}
