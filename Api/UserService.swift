//
//  UserService.swift
//  Socketchat
//
//  Created by Enes Saglam on 8.01.2024.
//

import Foundation
import Firebase
import FirebaseFirestore

struct UserService {
    func fetchUser(uid: String, completion: @escaping (User) -> Void) {
       /* User_Collection.getDocuments { snapshot, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let dictionary = snapshot?.documents else {
                print("Data not found")
                return
            }*/
    
        Firestore.firestore().collection("users").document(uid).addSnapshotListener { snapshot, error in
            if let error = error {
                // Handle the error (e.g., insufficient permissions, network issues, etc.)
                print("Error getting user document: \(error)")
                return
            }

            guard let data = snapshot?.data() else {
                // Handle the case where the document doesn't exist or has no data
                print("Document data was empty.")
                return
            }
            
            let user = User(dictionary: data)
            completion(user)
        }

            
        }
       /* User_Collection.document(uid).addSnapshotListener { snapshot, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let dictionary = snapshot?.data() else {
                print("Data not found")
                return
            }
            
            let user = User(dictionary: dictionary)
            completion(user)
        }*/
    }


