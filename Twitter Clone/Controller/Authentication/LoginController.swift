//
//  LoginController.swift
//  TwitterClone
//
//  Created by Muhammad Adam on 9/22/20.
//  Copyright © 2020 MA. All rights reserved.
//

import UIKit
import Firebase
class LoginController: UIViewController, RegistrationDelegate {
    
    // MARK: Properties
    private var logoImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "TwitterLogo")
        return iv
    }()
    
    
    private lazy var emailContainerView : UIView = {
        let emailImage = #imageLiteral(resourceName: "ic_mail_outline_white_2x-1")
        let v = Utilities.inputContainerView(image: emailImage, textField: emailTxtField)
        return v
    }()
    
    private let emailTxtField: UITextField = {
        let txtField = Utilities.textFieldWithPlaceholder(placeholder: "Email")
        txtField.setupForEmail()
        return txtField
    }()
    
    private lazy var passwordContainerView : UIView = {
        let image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        let v = Utilities.inputContainerView(image: image, textField: passwordTxtField)
        return v
    }()
    
    private let passwordTxtField: UITextField = {
        let txtField = Utilities.textFieldWithPlaceholder(placeholder: "Password")
        txtField.setupForPassword()
        return txtField
    }()
    
    private let loginBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Log In", for: .normal)
        btn.layer.cornerRadius = 5
        btn.setTitleColor(UIColor.twitterBlue, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.backgroundColor = .white
        NSLayoutConstraint.activate([
            btn.heightAnchor.constraint(equalToConstant: 50)
        ])
        btn.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return btn
    }()
    
    private let dontHaveAccountBtn: UIButton = {
        let button = Utilities.attributedButton(plainTitlePart: "Don't have an account? ", BoldTitlePart: "Sign Up")
        button.setTitleColor(UIColor.twitterBlue, for: .normal)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
//        handleLogout()
    }
    
    // MARK: Selectors    
    @objc func handleLogin(){
        debugLog("handle login")
        guard let email = emailTxtField.text else {return}
        guard let password = passwordTxtField.text else {return}
        AuthService.shared.logUserIn(email: email, password: password){ [weak self] (error) in
            
            if let error = error {
                errorLog("login: \(error)")
                return
            }
            
            debugLog("login succeeds. e:\(email) p:\(password)")
            
//            guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else { return }
//
//            guard let tab = window.rootViewController as? MainTabController else {return}
//
//            tab.authenticateUserAndConfigureUI()
//
//            self?.dismiss(animated: true, completion: nil)
            self?.didCompleteRegistartionSuccessfully()
        }
    }
    
    
//    @objc func handleLogout(){
//        debugLog("handle logout")
//        guard let email = emailTxtField.text else {return}
//        guard let password = passwordTxtField.text else {return}
//
//        do{
//            try Auth.auth().signOut()
//        }catch{
//            errorLog("failed to logout:\(error.localizedDescription)")
//        }
//
//    }
    
    
    @objc func handleSignUp(){
        debugLog("handle sign up")
        let registrationVC = RegistrationController()
        navigationController?.pushViewController(registrationVC, animated: true)
    }
    
    // MARK:- Methods
    
    
    // MARK: Helpers
    func configureUI(){
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black // black BG with light content
        
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        logoImageView.setDimensions(width: 150, height: 150)
        
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                                   passwordContainerView,
                                                   loginBtn])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: logoImageView.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor,paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(dontHaveAccountBtn)
        dontHaveAccountBtn.anchor(leading:nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 16, height: 32)
        dontHaveAccountBtn.centerX(inView: view)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}




