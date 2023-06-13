//
//  PunishmentImageCell.swift
//  Antitasker
//
//  Created by Андрей Чернышев on 13.06.2023.
//

import UIKit

final class PunishmentImageCell: UITableViewCell {
    lazy var pictureView = makeImageView()
    
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
extension PunishmentImageCell {
    func setup(element: String) {
        pictureView.image = UIImage(named: element)
    }
}

// MARK: Private
private extension PunishmentImageCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension PunishmentImageCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            pictureView.widthAnchor.constraint(equalToConstant: 330.scale),
            pictureView.heightAnchor.constraint(equalToConstant: 330.scale),
            pictureView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            pictureView.topAnchor.constraint(equalTo: contentView.topAnchor),
            pictureView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension PunishmentImageCell {
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
