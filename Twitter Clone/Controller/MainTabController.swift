//
//  MainTabController.swift
//  Twitter Clone
//
//  Created by Muhammad Adam on 7/2/20.
//  Copyright © 2020 MA. All rights reserved.
//

import UIKit
import Firebase
class MainTabController: UITabBarController {

    // MARK:-  Constants
    
    private let feedControllerIndexInTabs = 0
    
    // MARK:-  Properties
    let button:UIButton = {
        let btn = UIButton()
        btn.tintColor = .white
        btn.backgroundColor = .twitterBlue
        btn.setImage(UIImage(named: "new_tweet"), for: .normal)
        btn.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    var user: User?{
        didSet{
//            typealias targetController = FeedController
//            guard let feedControllerNav = viewControllers?.first(where: { (controller) -> Bool in
//                if let nav2 = controller as? UINavigationController{
//                    return nav2.viewControllers.first is targetController
//                }
//                return false
//            }) as? UINavigationController else { return }
            
            guard let feedControllerNav = viewControllers?[feedControllerIndexInTabs] as? UINavigationController else {return}
            guard let vc = feedControllerNav.viewControllers.first as? FeedController else { return }
            vc.user = user
        }
    }
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .twitterBlue
        authenticateUserAndConfigureUI()
//        logOut()
    }
    
    // MARK:- Helpers
    func configureUI(){
        view.addSubview(button)
        let buttonLength:CGFloat = 56.0
//        button.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            button.widthAnchor.constraint(equalToConstant: buttonLength),
//            button.heightAnchor.constraint(equalToConstant: buttonLength),
//            button.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -64),
//            button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
//        ])
        
        button.anchor(bottom: view.layoutMarginsGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 64, paddingRight: 16, width: buttonLength, height: buttonLength)
        button.layer.cornerRadius = buttonLength/2
    }
    
    func conifgureViewControllers() {
     
        let feed = FeedController()
        let feedNav = templateNavigationController( imageName: "home_unselected", rootVC: feed)
        
        let explore = ExploreController()
        let exploreNav = templateNavigationController( imageName: "search_unselected", rootVC: explore)


        let notifications = NotificationsController()
        let notificationsNav = templateNavigationController( imageName: "like_unselected", rootVC: notifications)

        let conversations = ConversationsController()
        let conversationsNav = templateNavigationController( imageName: "ic_mail_outline_white_2x-1", rootVC: conversations)
        
        
        viewControllers = [exploreNav,notificationsNav,conversationsNav]
        viewControllers?.insert(feedNav, at: feedControllerIndexInTabs) // done to access it from somewhere else
        selectedIndex = feedControllerIndexInTabs
    }
    
    func templateNavigationController(imageName: String, rootVC: UIViewController) -> UINavigationController{
        let nav = UINavigationController(rootViewController: rootVC)
        nav.tabBarItem.image = UIImage(named: imageName)
        nav.navigationBar.barTintColor = .white
        return nav
    }
    
    func authenticateUserAndConfigureUI(){
        if (Auth.auth().currentUser != nil){
            debugLog("Found signed-in user")
            conifgureViewControllers()
            configureUI()
            fetchUser()
        }else{
            debugLog("No signed-in user")
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }
    }
    
    func fetchUser(){
        UserService.shared.fetchUser { (user) in
            guard let user = user else { return }
            
            self.user = user
        }
    }
    func logOut(){
        do{
            try Auth.auth().signOut()
        }catch{
            errorLog("failed to logout:\(error.localizedDescription)")
        }

    }
    
    // MARK:- Selectors
    @objc func actionButtonTapped(){
        debugLog("action btn tapped")
        guard let user = user else {return}
        let controller = UploadTweetViewController(user: user)
        let uploadNavController = UINavigationController(rootViewController: controller)
//        uploadNavController.modalPresentationStyle = .fullScreen
        self.present(uploadNavController, animated: true, completion: nil)
        
//        logOut()
    }
}
