//
//  Buttons.swift
//  FirebaseSocketChat
//
//  Created by Enes Saglam on 3.01.2024.
//

import UIKit

extension UIButton{
    func attrributedText(firstString: String, secondString: String){
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8980392157).withAlphaComponent(0.7), .font: UIFont.systemFont(ofSize: 16)]
        let attributedTitle = NSMutableAttributedString(string: firstString,attributes: atts)
        
        let secondAtts: [NSAttributedString.Key: Any] = [.foregroundColor:#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8980392157).withAlphaComponent(0.88), .font: UIFont.boldSystemFont(ofSize: 16)]
        attributedTitle.append(NSAttributedString(string: secondString, attributes: secondAtts))
        
        
        setAttributedTitle(attributedTitle, for: .normal)
    }
    
    func defaultButton(buttonText: String){
        tintColor = .white
        setTitle(buttonText, for: .normal)
        backgroundColor = .black.withAlphaComponent(0.5)
        setTitleColor( .white.withAlphaComponent(0.7), for: .normal)
        setHeight(50)
        layer.cornerRadius =  7
        titleLabel?.font = .boldSystemFont(ofSize: 19)
        isEnabled = false
        
    }
}

extension UIColor{
        static var myCustomColor: UIColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1)
}
