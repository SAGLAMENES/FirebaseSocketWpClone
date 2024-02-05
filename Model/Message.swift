//
//  Message.swift
//  Socketchat
//
//  Created by Enes Saglam on 4.02.2024.
//

import Foundation
import Firebase

struct Message{
    let text: String
    let fromId: String
    let toId: String
    let timestamp: Timestamp
    let userName: String
    let fullName: String
    let profileImageUrl: String
    
    var isFromCurrentUser: Bool
    init (dictionary: [String: Any]) {
        self.text = dictionary["text"] as? String ?? ""
        self.fromId = dictionary["fromId"] as? String ?? ""
        self.toId = dictionary["toId"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.userName = dictionary["username"] as? String ?? ""
        self.fullName = dictionary["fullname"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        
        self.isFromCurrentUser = fromId == Auth.auth().currentUser?.uid
    }
}
