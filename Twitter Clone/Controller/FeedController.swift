//
//  FeedController.swift
//  Twitter Clone
//
//  Created by Muhammad Adam on 7/20/20.
//  Copyright © 2020 MA. All rights reserved.
//

import UIKit
import SDWebImage

class FeedController: UIViewController {
    
    // MARK: Properties
    var user: User?{
        didSet{
            debugLog("user from feed: \(user)")
            updateleftBtnOfNavigationController()
        }
    }
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    // MARK: Helpers
    
    func configureUI(){
        view.backgroundColor = .systemRed
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        imageView.setDimensions(width: 44, height: 44)
        navigationItem.titleView = imageView
        
        configureleftBtnOfNavigationController()
    }
    
    fileprivate func configureleftBtnOfNavigationController() {
        let profileImageView = UIImageView()
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.setDimensions(width: 32, height: 32)
        profileImageView.layer.cornerRadius = 32 / 2
        profileImageView.layer.masksToBounds = true
        profileImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        if let view = profileImageView.sd_imageIndicator as? SDWebImageActivityIndicator{
            view.indicatorView.color = .twitterBlue
            view.indicatorView.startAnimating()
            view.indicatorView.hidesWhenStopped = true
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
    
    fileprivate func updateleftBtnOfNavigationController() {
        guard let profileImageView = navigationItem.leftBarButtonItem?.customView as? UIImageView else { return }
        profileImageView.sd_setImage(with: user?.profileImageUrl, completed: nil)
    }
    
    
}
