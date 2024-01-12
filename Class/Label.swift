//
//  Label.swift
//  FirebaseSocketChat
//
//  Created by Enes Saglam on 6.01.2024.
//

import UIKit

class CustomLabel: UILabel{
    init(text: String, labelFont: UIFont = .systemFont(ofSize: 20), labelColor: UIColor = .black) {
        super.init(frame: .zero)
        self.text = text
        font = labelFont
        textColor = labelColor
        
        textAlignment = .center
        numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
