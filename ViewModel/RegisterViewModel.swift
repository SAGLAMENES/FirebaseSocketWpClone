//
//  RegisterViewModel.swift
//  FirebaseSocketChat
//
//  Created by Enes Saglam on 5.01.2024.
//

import Foundation
import UIKit

struct RegisterViewModel: AuthUserProtocol{
    var email: String?
    var password: String?
    var userName: String?
    var fullName: String?
    
    var isEmpty: Bool{
        return email?.isEmpty == false && password?.isEmpty == false && userName?.isEmpty == false && fullName?.isEmpty == false
    }
    
    var buttonBackgroundColor : UIColor{
        return isEmpty ? .black : .black.withAlphaComponent(0.5)
    }
    
    var buttonTitleColor : UIColor{
        return isEmpty ? .white : .white.withAlphaComponent(0.7)
    }
}
