//
//  ViewController.swift
//  jdv72_p7
//
//  Created by David Vizueth on 4/21/23.
//

import UIKit

class ViewController: UIViewController {
    
    let messageTableView = UITableView()
    let messageReuseIdentifier = "messageReuseIdentifier"
    var currentIndex = IndexPath()
    
    let addMessageButton = UIBarButtonItem()
    let refreshControl = UIRefreshControl()
    
    var messagesData: [Message] = []
    var shownMessagesData: [Message] = []

    override func viewDidLoad() {
        
        var url = URL(string: "http://34.85.172.228/")!
        let formatParameter = URLQueryItem(name: "format", value: "json")
        url.append(queryItems: [formatParameter])
        
        super.viewDidLoad()
        title = "Message Board"
        view.backgroundColor = .red

        messageTableView.translatesAutoresizingMaskIntoConstraints = false
        messageTableView.delegate = self
        messageTableView.dataSource = self
        messageTableView.register(MessageTableViewCell.self, forCellReuseIdentifier: messageReuseIdentifier)
        view.addSubview(messageTableView)

        //TODO: #1.5 Setup refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)

        if #available(iOS 10.0, *) {
            messageTableView.refreshControl = refreshControl
        } else {
            messageTableView.addSubview(refreshControl)
        }

        addMessageButton.image = UIImage(systemName: "plus.message")
        addMessageButton.target = self
        addMessageButton.action = #selector(pushMessageView)
        navigationItem.rightBarButtonItem = addMessageButton

        createDummyData()
        setupConstraints()
        // Do any additional setup after loading the view.
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            messageTableView.topAnchor.constraint(equalTo: view.topAnchor),
            messageTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            messageTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            messageTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    func createDummyData() {
        
        NetworkManager.shared.getAllMessages { messages in
            DispatchQueue.main.async {
                self.shownMessagesData = messages
                self.messageTableView.reloadData()
            }
        }
    }
    
    @objc func refreshData() {
        //TODO: Refresh Data
        NetworkManager.shared.getAllMessages { messages in
            DispatchQueue.main.async {
                self.shownMessagesData = messages
                self.messageTableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }


    @objc func pushMessageView() {
        navigationController?.pushViewController(CreateMessageViewController(delegate: self), animated: true)
    }

}

extension ViewController: updateCell {
    func updateBody(body: String) {
        shownMessagesData[currentIndex.row].message = body
        messageTableView.reloadData()
    }
}


extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.currentIndex = indexPath
        let currentMessage = shownMessagesData[indexPath.row]
        
        let vc = DetailViewController(message: currentMessage, delegate: self)
        vc.del = self
        
        navigationController?.pushViewController(vc, animated: true)
    }

//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if(editingStyle == UITableViewCell.EditingStyle.delete) {
//            let deletedMessage = shownMessagesData[indexPath.row]
//            shownMessagesData.remove(at: indexPath.row)
//            messageTableView.deleteRows(at: [indexPath], with: .fade)
//
//            //TODO: #2 Delete Message
//
//        }
//    }
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownMessagesData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: messageReuseIdentifier, for: indexPath) as! MessageTableViewCell
        let messageObject = shownMessagesData[indexPath.row]
        cell.configure(messageObject: messageObject)
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension ViewController: CreateMessageDelegate {

    func createMessage(message: String, sender: String) {
        
        NetworkManager.shared.createMessage(body: message, sender: sender) { message in
            print("success!")
        }
        //TODO: Create a message

        
    }
}

extension ViewController: ChangeMessageDelegate {
    func changeMessage(id: Int, message: String, sender: String) {
        NetworkManager.shared.changeMessage(id: id, body: message, sender: sender) {message in
            print("changed Message!")
        }
        
    }
    
    func deleteMessage(id: Int) {
        NetworkManager.shared.deleteMessage(id: id) { message in
            print("deleted successfully!")

        }
        
    }

}

