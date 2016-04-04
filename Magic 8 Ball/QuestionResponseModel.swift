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
    
    struct PropertyKey {
        static let questionKey = "question"
        static let responseKey = "response"
    }
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("questionResponseModel")
    
    
    // MARK: NSCoding
    
    init(question: String, response: String) {
        self.question = question
        self.response = response
        super.init()
    }
    
    required convenience init? (coder aDecoder: NSCoder) {
        let question = aDecoder.decodeObjectForKey(PropertyKey.questionKey) as! String
        let response = aDecoder.decodeObjectForKey(PropertyKey.responseKey) as! String
        self.init(question: question, response: response)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(question, forKey: PropertyKey.questionKey)
        aCoder.encodeObject(response, forKey: PropertyKey.responseKey)
    }
    
    
}
