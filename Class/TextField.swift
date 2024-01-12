//
//  TextField.swift
//  FirebaseSocketChat
//
//  Created by Enes Saglam on 5.01.2024.
//

import Foundation
import UIKit

class CustomTextField: UITextField{
    init(placeHolder: String, isSecure : Bool = false, keyboardType : UIKeyboardType = .default) {
        super.init(frame: .zero)
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12)
        
        leftView = spacer
        leftViewMode = .always
        
        borderStyle = .roundedRect
        textColor = .black
        keyboardAppearance = .light
        clearButtonMode = .whileEditing
        backgroundColor =         #colorLiteral(red: 0.8493646979, green: 0.8493646979, blue: 0.8493646979, alpha: 0.6647868377)
        setHeight(50)
        
        self.keyboardType = keyboardType
        isSecureTextEntry = isSecure
        attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [.foregroundColor: UIColor.black.withAlphaComponent(0.7)])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
