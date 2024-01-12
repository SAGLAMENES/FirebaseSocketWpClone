//
//  ConversationCell.swift
//  Socketchat
//
//  Created by Enes Saglam on 8.01.2024.
//

import Foundation
import UIKit

class ConversationCell: UITableViewCell{
    private let fullName = CustomLabel(text: "Fullname")
    private let recentMessage = CustomLabel(text: "RecentMessage", labelColor: .lightGray)
    private let dateLabel = CustomLabel(text: "11/10/2024", labelColor: .lightGray)
    
    private let profileImageView = CustomImageView(image: #imageLiteral(resourceName: "apple.png").withTintColor(.black),width: 60,height: 60,backgroundColor: .lightGray,cornerRadius: 30)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubview(profileImageView)
        profileImageView.centerY(inView: self,leftAnchor: leftAnchor)
        
        let stackView = UIStackView(arrangedSubviews: [fullName,recentMessage])
        stackView.axis = .vertical
        stackView.spacing = 7
        stackView.alignment = .leading
        
        addSubview(stackView)
        stackView.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 15)
        
        addSubview(dateLabel)
        dateLabel.centerY(inView: self, rightAnchor: rightAnchor, paddingRight: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
