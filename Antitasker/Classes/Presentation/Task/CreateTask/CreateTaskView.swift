//
//  CreateTaskView.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 02.06.2023.
//

import UIKit

final class CreateTaskView: UIView {
    lazy var separator = makeSeparator()
    lazy var scrollView = makeScrollView()
    lazy var nameTitleLabel = makeTitleLabel("CreateTask.Name.Title".localized)
    lazy var nameTextField = makeTextField("CreateTask.Name.Placeholder".localized)
    lazy var descriptionTitleLabel = makeTitleLabel("CreateTask.Description.Title".localized)
    lazy var descriptionTextField = makeTextField("CreateTask.Description.Placeholder".localized)
    lazy var dateTimeTitleLabel = makeTitleLabel("CreateTask.DateTime.Title".localized)
    lazy var dateTimeTextField = makeTextField("CreateTask.DateTime.Placeholder".localized)
    lazy var dateTimeIconView = makeDateIconView()
    lazy var button = makeButton()
    lazy var datePicker = makeDatePicker()
    
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
private extension CreateTaskView {
    func initialize() {
        backgroundColor = UIColor.white
    }
}

// MARK: Make constraints
private extension CreateTaskView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            separator.leadingAnchor.constraint(equalTo: leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor),
            separator.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1.scale)
        ])
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: separator.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -2.scale)
        ])
        
        NSLayoutConstraint.activate([
            nameTitleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 13.scale),
            nameTitleLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -13.scale),
            nameTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 13.scale),
            nameTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -13.scale),
            nameTitleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 18.scale)
        ])
        
        NSLayoutConstraint.activate([
            nameTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 13.scale),
            nameTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -13.scale),
            nameTextField.topAnchor.constraint(equalTo: nameTitleLabel.bottomAnchor, constant: 8.scale)
        ])
        
        NSLayoutConstraint.activate([
            descriptionTitleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 13.scale),
            descriptionTitleLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -13.scale),
            descriptionTitleLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            descriptionTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 13.scale),
            descriptionTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -13.scale),
            descriptionTextField.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: 8.scale)
        ])
        
        NSLayoutConstraint.activate([
            dateTimeTitleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 13.scale),
            dateTimeTitleLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -13.scale),
            dateTimeTitleLabel.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            dateTimeTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 13.scale),
            dateTimeTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -13.scale),
            dateTimeTextField.topAnchor.constraint(equalTo: dateTimeTitleLabel.bottomAnchor, constant: 8.scale),
            dateTimeTextField.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            dateTimeIconView.centerYAnchor.constraint(equalTo: dateTimeTextField.centerYAnchor),
            dateTimeIconView.widthAnchor.constraint(equalToConstant: 24.scale),
            dateTimeIconView.heightAnchor.constraint(equalToConstant: 24.scale),
            dateTimeIconView.trailingAnchor.constraint(equalTo: dateTimeTextField.trailingAnchor, constant: -16.scale)
        ])
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18.scale),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18.scale),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ScreenSize.isIphoneXFamily ? -42.scale : -20.scale),
            button.heightAnchor.constraint(equalToConstant: 46.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension CreateTaskView {
    func makeSeparator() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(integralRed: 236, green: 236, blue: 236)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeScrollView() -> UIScrollView {
        let view = UIScrollView()
        view.backgroundColor = UIColor.clear
        view.showsVerticalScrollIndicator = false
        view.contentInsetAdjustmentBehavior = .never
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTitleLabel(_ title: String) -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 29, green: 29, blue: 29))
            .font(Fonts.Ubuntu.medium(size: 17.scale))
            .lineHeight(22.scale)
            .letterSpacing(-0.41.scale)
        
        let view = UILabel()
        view.attributedText = title.attributed(with: attrs)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(view)
        return view
    }
    
    func makeTextField(_ placeholder: String) -> PaddingTextField {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 29, green: 29, blue: 29))
            .font(Fonts.Ubuntu.regular(size: 16.scale))
            .letterSpacing(-0.3.scale)

        let placeholderAttrs = TextAttributes()
            .textColor(UIColor(integralRed: 170, green: 170, blue: 170))
            .font(Fonts.Ubuntu.regular(size: 16.scale))
            .letterSpacing(-0.3.scale)

        let view = PaddingTextField()
        view.layer.cornerRadius = 12.scale
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(integralRed: 243, green: 244, blue: 246)
        view.textPadding = UIEdgeInsets(top: 12.scale, left: 16.scale, bottom: 16.scale, right: 12.scale)
        view.defaultTextAttributes = attrs.dictionary
        view.attributedPlaceholder = placeholder.attributed(with: placeholderAttrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(view)
        return view
    }
    
    func makeDateIconView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "CreateTask.Date")
        view.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(view)
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
        view.setAttributedTitle("CreateTask.Button".localized.attributed(with: attrs), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeDatePicker() -> UIDatePicker {
        let view = UIDatePicker()
        view.preferredDatePickerStyle = .wheels
        view.datePickerMode = .dateAndTime
        view.timeZone = TimeZone.current
        view.minimumDate = Date()
        return view
    }
}
