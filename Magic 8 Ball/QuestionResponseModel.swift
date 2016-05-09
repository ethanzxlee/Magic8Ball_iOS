//
//  QuestionResponseModel.swift
//  Magic 8 Ball
//
//  Created by Zhe Xian Lee on 4/04/2016.
//  Copyright © 2016 Zhe Xian Lee. All rights reserved.
//

import UIKit

class QuestionResponseModel : NSObject, NSCoding {
    
    // MARK: Properties
    
    var question : String
    var response : String
    var username : String
    var imageURL : String 
    
    struct PropertyKey {
        static let questionKey = "question"
        static let responseKey = "response"
        static let usernameKey = "username"
        static let imageURLKey = "imageURL"
    }
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("questionResponseModel")
    
    
    // MARK: NSCoding
    
    init(question: String, response: String, username: String, imageURL: String) {
        self.question = question
        self.response = response
        self.username = username;
        self.imageURL = imageURL;
        super.init()
    }
    
    required convenience init? (coder aDecoder: NSCoder) {
        let question = aDecoder.decodeObjectForKey(PropertyKey.questionKey) as! String
        let response = aDecoder.decodeObjectForKey(PropertyKey.responseKey) as! String
        let username = aDecoder.decodeObjectForKey(PropertyKey.usernameKey) as! String
        let imageURL = aDecoder.decodeObjectForKey(PropertyKey.imageURLKey) as! String
        self.init(question: question, response: response, username: username, imageURL: imageURL)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(question, forKey: PropertyKey.questionKey)
        aCoder.encodeObject(response, forKey: PropertyKey.responseKey)
        aCoder.encodeObject(username, forKey: PropertyKey.usernameKey)
        aCoder.encodeObject(imageURL, forKey: PropertyKey.imageURLKey)
    }
    
    
}
