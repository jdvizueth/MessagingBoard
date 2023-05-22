//
//  Message.swift
//  jdv72_p7
//
//  Created by David Vizueth on 4/21/23.
//

import Foundation
struct Message: Codable {
    var id: Int
    var message: String
    var sender: String
    
    init(id: Int, message: String, sender: String) {
        self.message = message
        self.sender = sender
        self.id = id
    }
}

struct MessageResponse: Codable {
    var messages: [Message]
}
