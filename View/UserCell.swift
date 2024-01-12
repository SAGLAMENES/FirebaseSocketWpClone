//
//  UserCell.swift
//  Socketchat
//
//  Created by Enes Saglam on 9.01.2024.
//

import UIKit

class UserCell: UITableViewCell {

    private let profileImageView = CustomImageView(width: 48   ,height: 48,backgroundColor: .lightGray,cornerRadius: 24)
    private let userName = CustomLabel(text: "Username", labelFont: .boldSystemFont(ofSize: 17))
    private let fullname = CustomLabel(text: "fullname", labelColor: .lightGray)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        
        addSubview(profileImageView)
        profileImageView.centerY(inView: self,leftAnchor: leftAnchor)
        
        let stackView = UIStackView(arrangedSubviews: [userName,fullname])
        stackView.axis = .vertical
        stackView.spacing = 7
        stackView.alignment = .leading
        
        addSubview(stackView)
        stackView.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
