//
//  User.swift
//  TwitterClone
//
//  Created by Muhammad Adam on 10/5/20.
//  Copyright © 2020 MA. All rights reserved.
//

import Foundation


class User{
    let email:String
    var password:String?
    let fullname:String
    let username:String
    var profileImageUrl:URL?
    var uid:String?
    
    private static let emailKey = "email"
    private static let passwordKey = "password"
    private static let fullnameKey = "fullname"
    private static let usernameKey = "username"
    private static let profileImageUrlKey = "profileImageUrl"
    
    init(uid:String? = nil, email: String, password: String? = nil, fullname: String, username: String, profileImageUrl: String) {
        
        if let uid = uid{
            self.uid = uid
        }
        
        self.email = email
        
        if let password = password{
            self.password = password
        }
        
        self.fullname = fullname
        self.username = username
        self.profileImageUrl = URL(string: profileImageUrl)
    }
    
    func toDict() -> [String:String]{
        return [
            User.emailKey : email,
            User.fullnameKey : fullname,
            User.usernameKey : username,
            User.profileImageUrlKey : profileImageUrl?.absoluteString ?? "",
        ]
    }
    
    static func fromDict(uid: String, _ dict:[String:Any]) -> User?{

        guard let email = dict[User.emailKey] as? String,
              let fullname = dict[User.fullnameKey] as? String,
              let username = dict[User.usernameKey] as? String,
              let profileImageUrlString = dict[User.profileImageUrlKey] as? String
              else {return nil}
        
        let password = dict[User.passwordKey] as? String
        
        return User(uid: uid,
                    email: email,
                    password: password,
                    fullname: fullname,
                    username: username,
                    profileImageUrl: profileImageUrlString)
    }
    
    
}

extension User: CustomStringConvertible{
    var description: String {
        return "FN:\(fullname) U:\(username)"
    }
}
