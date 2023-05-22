//
//  MessageTableViewCell.swift
//  jdv72_p7
//
//  Created by David Vizueth on 4/21/23.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    let messageLabel = UILabel()
    let posterLabel = UILabel()

    let stackView = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupViews()
        setupConstraints()
    }

    func setupViews() {
        messageLabel.font = UIFont.systemFont(ofSize: 15)
        messageLabel.numberOfLines = 0
        messageLabel.translatesAutoresizingMaskIntoConstraints = false

        posterLabel.font = UIFont.systemFont(ofSize: 10, weight: .heavy)
        posterLabel.translatesAutoresizingMaskIntoConstraints = false

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical

        stackView.addArrangedSubview(messageLabel)
        stackView.addArrangedSubview(posterLabel)
        contentView.addSubview(stackView)
    }

    func setupConstraints() {
        let profileImageDim: CGFloat = 50
        let verticalPadding: CGFloat = 20.0
        let sidePadding: CGFloat = 20.0

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: verticalPadding),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -verticalPadding),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    func configure(messageObject: Message) {
        messageLabel.text = messageObject.message
        posterLabel.text = messageObject.sender
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }}
