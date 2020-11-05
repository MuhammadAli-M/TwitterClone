//
//  UploadTweetViewController.swift
//  TwitterClone
//
//  Created by Muhammad Adam on 10/14/20.
//  Copyright © 2020 MA. All rights reserved.
//

import UIKit

class UploadTweetViewController: UIViewController {
    // MARK:-  Constants

    // MARK:-  Properties
    private let user: User
    
    private lazy var tweetBtn : UIButton = {
       let btn = UIButton()
        btn.backgroundColor = .twitterBlue
        btn.setTitle("Tweet", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setDimensions(width: 64, height: 32)        
        btn.layer.cornerRadius = 32 / 2
        btn.addTarget(self, action: #selector(handleTweetBtnTapped), for: .touchUpInside)
        return btn
    }()
    
    private let profileImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.setDimensions(width: 48, height: 48)
        imageView.layer.cornerRadius = 48/2
        imageView.backgroundColor = .twitterBlue
        return imageView
    }()
    
    private let captionTextView: CaptionTextView = {
       let captionTxtView = CaptionTextView()
        captionTxtView.placeholderText = "What's happening"
        captionTxtView.setDimensions(height: 300)
        return captionTxtView
    }()
    // MARK:- Lifecycle
    init(user: User){
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK:- Helpers

    
    func configureUI(){
        view.backgroundColor = .white
        configureNaviagationBarItems()
        
        let stack = UIStackView(arrangedSubviews: [profileImageView, captionTextView])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .top
        stack.distribution = .fill
        
        
        view.addSubview(stack)
        stack.anchor(top: view.layoutMarginsGuide.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 8, paddingLeft: 8, paddingRight: 8)
        profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
    }
    
    
    fileprivate func configureNaviagationBarItems() {
        let buttonItem =  UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        buttonItem.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)], for: .normal)
        navigationItem.leftBarButtonItem = buttonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: tweetBtn)
    }
    
    
    // MARK:- Selectors
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    @objc func handleTweetBtnTapped(){
        print("12343421")
    }

}
