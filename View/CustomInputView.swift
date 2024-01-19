//
//  CustomInputView.swift
//  Socketchat
//
//  Created by Enes Saglam on 14.01.2024.
//

import Foundation
import UIKit

protocol CustomInputViewDelegate: AnyObject{
    func inputView(_ view: CustomInputView, wantUploadMessage: String)
}

class CustomInputView: UIView{
    
    //MARK: - Properties
    let inputTextView = CustomTextView()
    weak var delegate: CustomInputViewDelegate?
    
    private let postBackgroundColor : CustomImageView = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handlePostButton))
        let imageView = CustomImageView(width: 40,height: 40,backgroundColor: .black,cornerRadius: 20)
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
        
        return imageView
    }()
    
    private lazy var postButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        button.tintColor = .red
        button.addTarget(self, action: #selector(handlePostButton), for: .touchUpInside)
        button.setDimensions(height: 28, width: 28)
        
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [inputTextView,postBackgroundColor])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        autoresizingMask = .flexibleHeight
        
      
        
        addSubview(stackView)
        stackView.anchor(top: topAnchor,left: leftAnchor,right: rightAnchor, paddingLeft: 5,paddingRight: 5)
        
        addSubview(postButton)
        postButton.center(inView: postBackgroundColor)
        
        inputTextView.anchor(top: topAnchor,left: leftAnchor,bottom: safeAreaLayoutGuide.bottomAnchor,right: postBackgroundColor.leftAnchor,paddingTop: 12,paddingLeft: 8,paddingBottom: 5,paddingRight: 8)
        
        let dividerView = UIView()
        dividerView.backgroundColor = .lightGray
        addSubview(dividerView)
        dividerView.anchor(top: topAnchor,left: leftAnchor,right: rightAnchor,height: 0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override var intrinsicContentSize: CGSize{
        return .zero
    }
    //MARK: - Helpers
    @objc func handlePostButton(){
        delegate?.inputView(self, wantUploadMessage: inputTextView.text)
    }
    func clearTextView(){
        inputTextView.text = ""
        inputTextView.placeHolder.isHidden = false
     }
}
