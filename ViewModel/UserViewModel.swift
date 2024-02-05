//
//  UserViewModel.swift
//  Socketchat
//
//  Created by Enes Saglam on 22.01.2024.
//

import Foundation


struct UserViewModel{
    let user: User
    
    var fullname: String{
        return user.fullname
    }
    var username: String{
        return user.username
    }
    
    var profileImageUrl: URL?{
        return URL(string: user.profile_Image)
    }
    init(user: User) {
        self.user = user
    }
}
