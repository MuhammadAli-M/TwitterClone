//
//  UserService.swift
//  TwitterClone
//
//  Created by Muhammad Adam on 10/5/20.
//  Copyright © 2020 MA. All rights reserved.
//

import Firebase


struct UserService{
    static let shared = UserService()
    
    
    func fetchUser(completion: @escaping (User?) -> Void){
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        
        DB.usersRef.child(userUid).observeSingleEvent(of: .value) { (snapshot) in
            
            guard let userDict = snapshot.value as? [String:Any] else { return }
            
            debugLog("userDict: \(userDict)")
            
            let user = User.fromDict(uid: userUid, userDict)
            completion(user)
            
            
        }
    }
}
