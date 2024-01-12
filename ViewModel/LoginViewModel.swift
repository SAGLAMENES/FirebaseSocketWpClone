//
//  LoginViewModel.swift
//  FirebaseSocketChat
//
//  Created by Enes Saglam on 4.01.2024.
//

import Foundation
import UIKit

protocol AuthUserProtocol{
    var email: String? { get  }
    var password: String? { get }
    var isEmpty: Bool { get  }
    var buttonBackgroundColor : UIColor{ get  }
    
    var buttonTitleColor : UIColor{ get  }
}
struct LoginViewModel: AuthUserProtocol{
    var email: String?
    var password: String?
    
    var isEmpty: Bool{
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
    var buttonBackgroundColor : UIColor{
        return isEmpty ? .black : .black.withAlphaComponent(0.5)
    }
    
    var buttonTitleColor : UIColor{
        return isEmpty ? .white : .white.withAlphaComponent(0.7)
    }

}
