//
//  CreateMessageViewController.swift
//  jdv72_p7
//
//  Created by David Vizueth on 4/21/23.
//

import Foundation
import UIKit

class CreateMessageViewController: UIViewController {

    let messageTextView = UITextView()
    let posterTextField = UITextField()
    let saveButton = UIButton()

    weak var delegate: CreateMessageDelegate?

    init(delegate: CreateMessageDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        messageTextView.text = "Insert Body"
        messageTextView.translatesAutoresizingMaskIntoConstraints = false
        messageTextView.clipsToBounds = true
        messageTextView.layer.cornerRadius = 5
        messageTextView.backgroundColor = .systemGray4
        messageTextView.font = .systemFont(ofSize: 15)
        view.addSubview(messageTextView)

        posterTextField.placeholder = "Who's creating this post?"
        posterTextField.translatesAutoresizingMaskIntoConstraints = false
        posterTextField.clipsToBounds = true
        posterTextField.layer.cornerRadius = 5
        posterTextField.backgroundColor = .systemGray4
        posterTextField.font = .systemFont(ofSize: 20)
        view.addSubview(posterTextField)

        saveButton.setTitle("Save", for: .normal)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.backgroundColor = .systemBlue
        saveButton.layer.cornerRadius = 15
        saveButton.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        view.addSubview(saveButton)

        setupConstraints()
    }

    @objc func saveAction() {
        let body = messageTextView.text!
        let poster = posterTextField.text!

        delegate?.createMessage(message: body, sender: poster)

        navigationController?.popViewController(animated: true)
    }

    func setupConstraints() {
        let widthMultiplier: CGFloat = 0.75

        NSLayoutConstraint.activate([
            messageTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messageTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            messageTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: widthMultiplier),
            messageTextView.heightAnchor.constraint(equalTo: view.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            posterTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            posterTextField.topAnchor.constraint(equalTo: messageTextView.bottomAnchor, constant: 20),
            posterTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: widthMultiplier)
        ])

        NSLayoutConstraint.activate([
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.topAnchor.constraint(equalTo: posterTextField.bottomAnchor, constant: 20),
            saveButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

protocol CreateMessageDelegate: UIViewController {
    func createMessage(message: String, sender: String)
}
