//
//  NetworkManager.swift
//  jdv72_p7
//
//  Created by David Vizueth on 4/22/23.
//

import Foundation

class NetworkManager {

    static let shared = NetworkManager()

    var url = URL(string: "http://34.85.172.228/messages")!

    func getAllMessages(completion: @escaping ([Message]) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("jdv72", forHTTPHeaderField: "netid")
        
        let task = URLSession.shared.dataTask(with: request) {data, response, err in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(MessageResponse.self, from: data)
                    completion(response.messages)
                }
                catch (let error){
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
        
        
        //TODO: Get all Messages

    }

    func createMessage(body: String, sender: String, to:String?="", completion: @escaping (Message) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("jdv72", forHTTPHeaderField: "netid")
        var toSomeone = to
        if (to == "") {
            toSomeone = sender
        }
        let body: [String: Any] = [
            "message": body,
            "toNetId": toSomeone ?? sender,
            "sender": sender
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Message.self, from: data)
                    completion(response)
                }
                catch (let error) {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()

    }
    
    func changeMessage(id: Int, body: String, sender: String, completion: @escaping (Message) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("jdv72", forHTTPHeaderField: "netid")
        let body: [String: Any] = [
            "id": id,
            "message": body,
//            "fromNetId": fromNetId,
//            "toNetId": toNetId,
            "sender": sender
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Message.self, from: data)
                    completion(response)
                }
                catch (let error) {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()

    }
    
    func deleteMessage(id: Int, completion: @escaping (Message) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("jdv72", forHTTPHeaderField: "netid")
        let body: [String: Any] = [
            "id": id
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Message.self, from: data)
                    completion(response)
                }
                catch (let error) {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()

    }

}
