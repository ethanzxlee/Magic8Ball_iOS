//
//  EightBallModel.swift
//  Magic 8 Ball
//
//  Created by Zhe Xian Lee on 06/03/2016.
//  Copyright © 2016 Zhe Xian Lee. All rights reserved.
//

import Foundation

class EightBallModel : CustomStringConvertible, CustomDebugStringConvertible {
    
    let initialResponseArray = [
        "It is certain",
        "It is decidedly so",
        "Without a doubt",
        "Yes, definitely",
        "You may rely on it",
        "As I see it, yes",
        "Most likely",
        "Outlook good",
        "Yes",
        "Signs point to yes",
        "Reply hazy try again",
        "Ask again later",
        "Better not tell you now",
        "Cannot predict now",
        "Concentrate and ask again",
        "Don't count on it",
        "My reply is no",
        "My sources say no",
        "Outlook not so good",
        "Very doubtful"
    ]
    
    var responseArray: [String]?
    
    var description: String {
        get {
            var desc = ""
            if let responses = responseArray {
                for response in responses {
                    desc += response
                    desc += ", "
                }
            }
            return desc
        }
    }
    
    var debugDescription: String {
        get {
            return "Debug: \(description)"
        }
    }
    
    /**
     Default Constructor. Sets the responseArray property with the initialResponseArray
     */
    init() {
        responseArray = [String]()
        responseArray? += initialResponseArray
    }
    
    /**
     Default Constructor. Sets the responseArray property with the initialResponseArray and
     combines it with the extraResponseArray
     */
    init(extraResponseArray: [String]) {
        responseArray = [String]()
        responseArray? += initialResponseArray
        responseArray? += extraResponseArray
    }
    
    /**
     
     */
    func tellForturtune() -> String? {
        if let responses = responseArray {
            return responses[Int(arc4random_uniform(UInt32(responses.count)))]
        }
        else {
            return nil
        }
    }
    
    
    
}