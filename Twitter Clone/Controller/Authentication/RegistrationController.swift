//
//  RegistrationController.swift
//  TwitterClone
//
//  Created by Muhammad Adam on 9/22/20.
//  Copyright © 2020 MA. All rights reserved.
//

import UIKit
import Firebase
class RegistrationController: UIViewController, RegistrationDelegate {
    // MARK: Properties
    private let addPhotoBtnImageLength : CGFloat = 128
    private var profileImage: UIImage? = nil
    private var addPhotoBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(handleAddPhoto), for: .touchUpInside)
        return btn
    }()
    
    private let emailTxtField: UITextField = {
        let txtField = Utilities.textFieldWithPlaceholder(placeholder: "Email")
        txtField.setupForEmail()
        return txtField
    }()

    private lazy var emailContainerView : UIView = {
        let emailImage = #imageLiteral(resourceName: "ic_mail_outline_white_2x-1")
        let v = Utilities.inputContainerView(image: emailImage, textField: emailTxtField)
        return v
    }()
    
        
    private let passwordTxtField: UITextField = {
        let txtField = Utilities.textFieldWithPlaceholder(placeholder: "Password")
        txtField.setupForPassword()
        return txtField
    }()
    
    private lazy var passwordContainerView : UIView = {
        let image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        let v = Utilities.inputContainerView(image: image, textField: passwordTxtField)
        return v
    }()
    
    private let fullNameTxtField: UITextField = {
        let txtField = Utilities.textFieldWithPlaceholder(placeholder: "Full Name")
        return txtField
    }()

    
    private lazy var fullNameContainerView : UIView = {
        let emailImage = #imageLiteral(resourceName: "ic_person_outline_white_2x")
        let v = Utilities.inputContainerView(image: emailImage, textField: fullNameTxtField)
        return v
    }()
    
    private let userNameTxtField: UITextField = {
        let txtField = Utilities.textFieldWithPlaceholder(placeholder: "User Name")
        txtField.setupForUsername()
        return txtField
    }()
    
    private lazy var userNameContainerView : UIView = {
        let image = #imageLiteral(resourceName: "ic_person_outline_white_2x")
        let v = Utilities.inputContainerView(image: image, textField: userNameTxtField)
        return v
    }()
    
    let photoPicker =  UIImagePickerController()
    
    private let signUpBtn: UIButton = {
       let btn = UIButton()
        btn.setTitle("Sign Up", for: .normal)
        btn.layer.cornerRadius = 5
        btn.setTitleColor(UIColor.twitterBlue, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.backgroundColor = .white
        NSLayoutConstraint.activate([
            btn.heightAnchor.constraint(equalToConstant: 50)
        ])
        btn.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return btn
    }()
    
    private let alreadyHaveAccountBtn: UIButton = {
        let button = Utilities.attributedButton(plainTitlePart: "Aleady have an account? ", BoldTitlePart: "Sign In")
        button.setTitleColor(UIColor.twitterBlue, for: .normal)
        button.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        return button
    }()
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
        
    // MARK: Selectors
    
    @objc func handleAddPhoto(){
        debugLog("handle add photo")
        present(photoPicker, animated: true, completion: nil)
    }
    @objc func handleSignUp(){
        debugLog("handle sign up")
        
        guard let profileImage = profileImage else {
            debugLog("Profile image can't be empty. Please select an image")
            return
        }
        guard let email = emailTxtField.text else { return }
        guard let password = passwordTxtField.text else { return }
        guard let fullname = fullNameTxtField.text else {return}
        guard let username = userNameTxtField.text else {return}
        
        let authCredential = AuthCredentials(email: email, password: password, fullname: fullname, username: username, profileImage: profileImage)
        AuthService.shared.registerUser(credentials: authCredential) { [unowned self] error in
            if let error = error{
                errorLog(error.localizedDescription)
                return
            }
            
            self.didCompleteRegistartionSuccessfully()
            
        }
    }
    
    @objc func handleSignIn(){
        debugLog("handle sign in")
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: Methods

    // MARK: Helpers
    func configureUI(){
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black // black BG with light content

        if let safeSelf = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate {
            photoPicker.delegate = safeSelf
            photoPicker.allowsEditing = true
        }
        
        
        
        view.addSubview(addPhotoBtn)
        addPhotoBtn.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 16)
        addPhotoBtn.setDimensions(width: addPhotoBtnImageLength, height: addPhotoBtnImageLength)
        
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                                   passwordContainerView,
                                                   fullNameContainerView,
                                                   userNameContainerView,
                                                   signUpBtn])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: addPhotoBtn.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor,paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(alreadyHaveAccountBtn)
        alreadyHaveAccountBtn.anchor(leading:nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 16, height: 32)
        alreadyHaveAccountBtn.centerX(inView: view)
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


extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else {return}
        self.profileImage = profileImage
        addPhotoBtn.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        addPhotoBtn.imageView?.contentMode = .scaleAspectFill
        addPhotoBtn.imageView?.clipsToBounds = true
        addPhotoBtn.layer.cornerRadius = addPhotoBtnImageLength / 2
        addPhotoBtn.layer.masksToBounds = true
        addPhotoBtn.layer.borderWidth = 3
        addPhotoBtn.layer.borderColor = UIColor.white.cgColor
        picker.dismiss(animated: true, completion: nil)
    }
}


