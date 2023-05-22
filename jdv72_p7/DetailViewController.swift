//
//  DetailViewController.swift
//  jdv72_p7
//
//  Created by David Vizueth on 4/22/23.
//

import UIKit

class DetailViewController: UIViewController {

    let messageTextView = UITextView()
    let posterTextField = UITextField()
    let saveButton = UIButton()
    let deleteButton = UIButton()

    
    weak var del: updateCell?
    let message: Message
    weak var delegate: ChangeMessageDelegate?

    init(message: Message, delegate: ChangeMessageDelegate) {
        self.message = message
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        messageTextView.text = message.message
        messageTextView.translatesAutoresizingMaskIntoConstraints = false
        messageTextView.clipsToBounds = true
        messageTextView.layer.cornerRadius = 5
        messageTextView.backgroundColor = .systemGray4
        messageTextView.font = .systemFont(ofSize: 15)
        view.addSubview(messageTextView)

        posterTextField.placeholder = message.sender
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
        saveButton.addTarget(self, action: #selector(changeMessageCell), for: .touchUpInside)
        view.addSubview(saveButton)
        
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.backgroundColor = .systemBlue
        deleteButton.layer.cornerRadius = 15
        deleteButton.addTarget(self, action: #selector(deleteMessageCell), for: .touchUpInside)
        view.addSubview(deleteButton)

        setupConstraints()
    }

    @objc func changeMessageCell() {
        if let body = messageTextView.text {
            del?.updateBody(body: body)
            delegate?.changeMessage(id: message.id, message: body, sender: message.sender)
            
        }

        navigationController?.popViewController(animated: true)
    }
    
    @objc func deleteMessageCell() {
        delegate?.deleteMessage(id: message.id)
        
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
        NSLayoutConstraint.activate([
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20),
            deleteButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

protocol updateCell: UIViewController {
    func updateBody(body:String)
}

protocol ChangeMessageDelegate: UIViewController {
    func changeMessage(id: Int, message: String, sender: String)
    func deleteMessage(id: Int)
}
