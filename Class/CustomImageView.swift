//
//  CustomImageView.swift
//  Socketchat
//
//  Created by Enes Saglam on 8.01.2024.
//

import Foundation
import UIKit
class CustomImageView: UIImageView{
    init(image: UIImage? = nil, width: CGFloat? = nil, height: CGFloat? = nil,backgroundColor: UIColor? = nil, cornerRadius : CGFloat = 0) {
        super.init(frame: .zero)
         contentMode = .scaleAspectFit
         layer.cornerRadius = cornerRadius
         if let image = image {
             self.image = image
         }
         if let width = width{
             setWidth(width)
         }
         if let height = height{
             setWidth(height)
         }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
