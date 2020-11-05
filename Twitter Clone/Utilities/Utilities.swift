//
//  Utilities.swift
//  TwitterClone
//
//  Created by Muhammad Adam on 9/30/20.
//  Copyright © 2020 MA. All rights reserved.
//

import UIKit


class Utilities {
    
    
    class func inputContainerView(image: UIImage, textField: UITextField) -> UIView{
        let v = UIView()
        v.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let iv = UIImageView(image: image)
        iv.contentMode = .scaleAspectFit
        v.addSubview(iv)
        iv.anchor(leading: v.leadingAnchor, paddingLeft: 8,  width: 24, height: 24)
        iv.centerY(inView: v)
        
        v.addSubview(textField)
        textField.anchor(leading: iv.trailingAnchor, trailing: v.trailingAnchor, paddingLeft: 8, paddingRight: 8,height: 24)
        textField.centerY(inView: v)
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        v.addSubview(dividerView)
        dividerView.anchor(top: textField.bottomAnchor, leading: v.leadingAnchor, trailing: v.trailingAnchor, paddingTop: 8,paddingLeft: 8,paddingRight: 8, height: 0.75)
        return v
    }
    
    class func textFieldWithPlaceholder(placeholder: String) -> UITextField{
        let txtField = UITextField()
        txtField.backgroundColor = .clear
        txtField.textColor = .white
        txtField.font = UIFont.systemFont(ofSize: 16)
        txtField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor:UIColor.white])
        
        return txtField
    }
    
    class func attributedButton(plainTitlePart: String, BoldTitlePart: String) -> UIButton{
        let button = UIButton()
        let attributedText = NSMutableAttributedString(string: plainTitlePart, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),NSAttributedString.Key.foregroundColor: UIColor.white])
        attributedText.append(NSMutableAttributedString(string: BoldTitlePart, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),NSAttributedString.Key.foregroundColor: UIColor.white]))
        button.setAttributedTitle(attributedText, for: .normal)
        return button
        
    }
}




func debugLog(_ message:String, file:String = #file, function:String = #function, line:Int = #line){
    print("DEBUG: \(message) \(function) \(file.split(separator: "/").last ?? ""):[\(line)]")
}

func errorLog(_ message:String, file:String = #file, function:String = #function, line:Int = #line){
    print("Error: \(message) \(function) \(file.split(separator: "/").last ?? ""):[\(line)]")
}
