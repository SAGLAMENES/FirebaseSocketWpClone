//
//  CustomTextView.swift
//  Socketchat
//
//  Created by Enes Saglam on 14.01.2024.
//

import Foundation
import UIKit

class CustomTextView: UITextView{
    let placeHolder = CustomLabel(text: "  Type message", labelColor: .lightGray)
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        layer.cornerRadius = 20
        isScrollEnabled = false
        font = .systemFont(ofSize: 16)
        
        addSubview(placeHolder)
        placeHolder.centerY(inView: self,leftAnchor: leftAnchor,rightAnchor: rightAnchor,paddingLeft: 8)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextChanged), name: UITextView.textDidChangeNotification, object: nil)
        paddingView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleTextChanged(){
        placeHolder.isHidden = !text.isEmpty
    }
}


extension UITextView{
    func paddingView(){
        self.textContainerInset = UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12)
    }
}
