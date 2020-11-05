//
//  AuthService.swift
//  TwitterClone
//
//  Created by Muhammad Adam on 10/2/20.
//  Copyright © 2020 MA. All rights reserved.
//

import UIKit
import Firebase

struct AuthCredentials{
    let email:String
    let password:String
    let fullname:String
    let username:String
    let profileImage:UIImage
}
class AuthService{
    
    static let shared = AuthService()
    
    func logUserIn(email: String, password: String, completion: ((Error?)->Void)? = nil) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { (result, error) in
            completion?(error)
        })
    }

    func registerUser(credentials: AuthCredentials, completion: @escaping (Error?)->Void){
        
        let email = credentials.email
        let password = credentials.password
        let fullname = credentials.fullname
        let username = credentials.username
        let profileImage = credentials.profileImage
        
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
            if let error = error {
                errorLog("sign up: \(error.localizedDescription)")
                return
            }
            guard let lowProfileImageData = profileImage.jpegData(compressionQuality: 0.3) else { return}
            
            
            let fileName = UUID().uuidString
            let imageRef = SG.profileImagesRef.child(fileName)
            
            imageRef.putData(lowProfileImageData, metadata: nil) { (meta, error) in
                
                guard let meta = meta else{
                    if error != nil {
                        errorLog("profile image upload of email \(email) failed with error:\(error?.localizedDescription)")
                    }
                    return
                }
                
                debugLog("path: \(meta.path)")
                
                imageRef.downloadURL { (url, error) in
                    guard let urlString = url?.absoluteString else {return}
                    
                    
                    guard let uid = result?.user.uid else { return }
                    
                    let userDict = User(email: email, fullname: fullname, username: username, profileImageUrl: urlString).toDict()
                    DB.usersRef.child(uid).updateChildValues(userDict, withCompletionBlock: { (error, databaseRef) in
                        completion(error)
                    })
                }
            }
            
            debugLog("registration succeeds for e:\(email), p:\(password)")
        }
    }
}
