//
//  User.swift
//  FirebaseSocketChat
//
//  Created by Enes Saglam on 8.01.2024.
//

import Foundation

struct User {
    let email : String
    let username : String
    let fullname: String
    let uid: String
    let profile_Image: String
    
    init(dictionary : [String: Any]){
        self.email = dictionary["email"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.profile_Image = dictionary["profile_image"] as? String ?? ""

    }
}
