//
//  AuthServices.swift
//  FirebaseSocketChat
//
//  Created by Enes Saglam on 6.01.2024.
//

import UIKit
import Firebase
import FirebaseAuth

struct AuthInfo {
    let userName: String
    let email: String
    let password: String
    let fullName: String
    let profileImage: UIImage
}

struct AuthServices{
    static func loginUser(withEmail email: String, withPassword password: String, completion: @escaping (AuthDataResult?,Error?) -> Void){
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    static func registerUser(userInfo: AuthInfo, completion: @escaping (Error?) -> Void){
        FileUploader.uploadImage(image: userInfo.profileImage) { imageURL in
            Auth.auth().createUser(withEmail: userInfo.email, password: userInfo.password){ result, error in
                if let error = error{
                    print("Error Message: \(error.localizedDescription)")
                    return
                }
                guard let uid = result?.user.uid else {return}
                let data: [String: Any] = [
                    "email": userInfo.email,
                    "username": userInfo.userName,
                    "fullname": userInfo.fullName,
                    "uid": uid,
                    "profile_image": imageURL
                ]
                
                User_Collection.document(uid).setData(data, completion: completion)
            }
        }
    }
}
