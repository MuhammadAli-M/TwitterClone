//
//  Constants.swift
//  TwitterClone
//
//  Created by Muhammad Adam on 10/2/20.
//  Copyright © 2020 MA. All rights reserved.
//

import Firebase

struct SG {
    static let ref = Storage.storage().reference()
    static let profileImagesRef = ref.child("profile_images")
}

struct DB{
    static let ref = Database.database().reference()
    static let usersRef = ref.child("users")
    static let tweetsRef = ref.child("tweets")
}
