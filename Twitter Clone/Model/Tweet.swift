//
//  Tweet.swift
//  TwitterClone
//
//  Created by Muhammad Adam on 11/5/20.
//  Copyright © 2020 MA. All rights reserved.
//

import Foundation


struct Tweet {
    private let uid: String
    private let timestamp: String
    private let likes: Int
    private let retweets: Int
    private let caption: String
    
    private let kUid = "uid"
    private let kTimestamp = "timestamp"
    private let kLikes = "likes"
    private let kRetweets = "retweets"
    private let kCaption = "caption"
    
    private lazy var propertiesKeys : [String] = {
        [kUid,
         kTimestamp,
         kLikes,
         kRetweets,
         kCaption,]
    }()
    
    func toDict() -> [String:Any]{
        let dict: [String : Any] = [
            kUid: uid,
            kTimestamp: timestamp,
            kLikes: likes,
            kRetweets: retweets,
            kCaption: caption,
        ]
        return dict
    }
    
//    init?(_ dict: [String:Any]){
        
//        propertiesKeys.forEach{
//            if (dict[$0] == nil){
//                return nil
//            }
//        }
//        for key in propertiesKeys{
//            if dict[key] == nil {
//                return nil;
//            }
//        }
//
//    }

}

struct JSON {
    static let encoder = JSONEncoder()
}
extension Encodable {
    subscript(key: String) -> Any? {
        return dictionary[key]
    }
    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSON.encoder.encode(self))) as? [String: Any] ?? [:]
    }
    
}

//extension Decodable {
//    // TODO: try to decode it to
//    init?(dict: [String:Any]) {
//
//        self.init(dict: dec)
//        let decoder = JSONDecoder()
//
//        try? decoder.decode(Self.self, from: Data())
//    }
//}
protocol Parasable: Decodable {
    init(dict: [String: Any]) throws
}
extension Parasable {
    init(dict: [String: Any]) throws {
        let jsonData = try JSONSerialization.data(withJSONObject: dict, options: [])
        let decoder = JSONDecoder()
        self = try decoder.decode(Self.self, from: jsonData)
    }
}
