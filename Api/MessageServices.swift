//
//  MessageServices.swift
//  Socketchat
//
//  Created by Enes Saglam on 4.02.2024.
//

import Foundation
import Firebase
struct MessageServices{
    static func fetchMessages(){
        
    }
    
    static func fetchRecentMessages(){
        
    }
    
    static func uploadMessage(message: String, currentUser: User, otherUser: User, completion: ((Error?) -> Void)?){
        
        let dataFrom: [String: Any] = [
            "text": message,
            "fromId": currentUser.uid,
            "toId": otherUser.uid,
            "timestamp": Timestamp(date: Date()),
            
            "username": otherUser.username,
            "fullname": otherUser.fullname,
            "profileImageUrl": otherUser.profile_Image
        ]
        let dataTo: [String: Any] = [
            "text": message,
            "fromId": currentUser.uid,
            "toId": otherUser.uid,
            "timestamp": Timestamp(date: Date()),
            
            "username": currentUser.username,
            "fullname": currentUser.fullname,
            "profileImageUrl": currentUser.profile_Image
        ]
        
        Collection_Messages.document(currentUser.uid).collection(otherUser.uid).addDocument(data: dataFrom){ _ in
            Collection_Messages.document(otherUser.uid).collection(currentUser.uid).addDocument(data: dataTo, completion: completion)
            Collection_Messages.document(currentUser.uid).collection("recent-messages").document(otherUser.uid).setData(dataFrom)
            Collection_Messages.document(otherUser.uid).collection("recent-messages").document(currentUser.uid).setData(dataTo)
        }
    }
    
}
