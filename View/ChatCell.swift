//
//  ChatCell.swift
//  Socketchat
//
//  Created by Enes Saglam on 9.01.2024.
//

import Foundation
import UIKit

class ChatCell: UICollectionViewCell{
    private let profileImageView = CustomImageView(image: #imageLiteral(resourceName: "profile"), width: 30, height: 30, backgroundColor: .black,cornerRadius: 15)
    private let dateLabel = CustomLabel(text: "10/10/2020")
    private let bubbleContainer : UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9420607686, green: 0.9420607686, blue: 0.9420607686, alpha: 1)
        return view
    }()
    var bubbleRightAnchor: NSLayoutConstraint!
    var bubbleLeftAnchor: NSLayoutConstraint!
    
    var dateRightAnchor: NSLayoutConstraint!
    var dateLeftAnchor: NSLayoutConstraint!
    private var textView : UITextView = {
        let tf = UITextView()
        tf.backgroundColor = .clear
        tf.isEditable = false
        tf.isScrollEnabled = false
        tf.font = .systemFont(ofSize: 15)
        return tf
    }()

    override init(frame: CGRect){
        super.init(frame: frame)
        addSubview(profileImageView)
        profileImageView.anchor(left: leftAnchor,bottom: bottomAnchor,paddingLeft: 20)
        
        addSubview(bubbleContainer)
        bubbleContainer.layer.cornerRadius = 12
        bubbleContainer.anchor(top: topAnchor, bottom: bottomAnchor)
        bubbleContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        
        bubbleContainer.addSubview(textView)
        textView.anchor(top: bubbleContainer.topAnchor, left: bubbleContainer.leftAnchor, bottom: bubbleContainer.bottomAnchor,right: bubbleContainer.rightAnchor, paddingTop: 12, paddingLeft: 4, paddingBottom: 12, paddingRight: 4)
        
        bubbleLeftAnchor = bubbleContainer.leftAnchor.constraint(equalTo: profileImageView.rightAnchor,constant: 12)
        bubbleLeftAnchor.isActive = false
        
        bubbleRightAnchor = bubbleContainer.rightAnchor.constraint(equalTo: rightAnchor,constant: -12)
        bubbleRightAnchor.isActive = false
        
        addSubview(dateLabel)
       dateLeftAnchor = dateLabel.leftAnchor.constraint(equalTo: bubbleContainer.rightAnchor, constant: 12)
       dateLeftAnchor.isActive = false
      
       dateRightAnchor = dateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -12)
       dateRightAnchor.isActive = false
        
        dateLabel.anchor(bottom: bottomAnchor)
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String){
        bubbleLeftAnchor.isActive = true
        bubbleRightAnchor.isActive = true
        textView.text = text
    }
}
