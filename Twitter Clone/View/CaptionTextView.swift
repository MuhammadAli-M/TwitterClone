//
//  CaptionTextView.swift
//  TwitterClone
//
//  Created by Muhammad Adam on 10/14/20.
//  Copyright © 2020 MA. All rights reserved.
//

import UIKit

class CaptionTextView: UITextView {

    public var placeholderText: String = "" {
        didSet{
            textPlaceholderLabel.text = placeholderText
        }
    }
    
    private static let fontSize: CGFloat = 16.0
    
    private let textPlaceholderLabel: UILabel = {
        let label  = UILabel()
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textColor = .darkGray
        return label
    }()
    
    override init(frame: CGRect, textContainer: NSTextContainer?){
        super.init(frame:frame, textContainer: textContainer)
        
        font = UIFont.systemFont(ofSize: CaptionTextView.fontSize)
        addSubview(textPlaceholderLabel)
        textPlaceholderLabel.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, paddingTop: 7, paddingLeft: 5)

        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChanged), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleTextInputChanged(){
        textPlaceholderLabel.isHidden = !text.isEmpty
    }
    
}

