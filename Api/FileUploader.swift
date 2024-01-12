//
//  FileUploader.swift
//  FirebaseSocketChat
//
//  Created by Enes Saglam on 6.01.2024.
//
import Foundation
import UIKit
import Firebase
import FirebaseStorage
struct FileUploader{
    static func uploadImage(image: UIImage, completion: @escaping(String)-> Void){
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {return}
        let uid = Auth.auth().currentUser?.uid ?? ("/profileImages/")
        
        let fileName = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/\(uid)/\(fileName)")
        
        ref.putData(imageData) {metaData , error in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            ref.downloadURL { url, error in
                if let error = error{
                    print(error.localizedDescription)
                    return
                }
                guard let fileUrl = url?.absoluteString else {return}
                completion(fileUrl)
            }
        }
        
    }
}
