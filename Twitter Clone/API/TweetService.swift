//
//  TweetService.swift
//  TwitterClone
//
//  Created by Muhammad Adam on 11/5/20.
//  Copyright © 2020 MA. All rights reserved.
//

import Firebase


struct TweetService {
    
    static let shared = TweetService()
    
    
    func uploadTweet(caption: String, completion: @escaping (Error? , DatabaseReference) -> Void){
        
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let tweetpath = DB.tweetsRef.childByAutoId()
        
    }
    
}
