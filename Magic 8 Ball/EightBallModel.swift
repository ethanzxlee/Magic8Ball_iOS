//
//  EightBallModel.swift
//  Magic 8 Ball
//
//  Created by Zhe Xian Lee on 06/03/2016.
//  Copyright © 2016 Zhe Xian Lee. All rights reserved.
//

import Foundation

/// A model of magic eight ball 🎱
class EightBallModel : CustomStringConvertible, CustomDebugStringConvertible {
    
    let initialResponseArray = [
        (text: "It is certain", audioFilename: "it_is_certain", fileType: "m4a"),
        (text: "It is decidedly so", audioFilename: "it_is_decidedly_so", fileType: "m4a"),
        (text: "Without a doubt", audioFilename: "without_a_doubt", fileType: "m4a"),
        (text: "Yes, definitely", audioFilename: "yes_definitely", fileType: "m4a"),
        (text: "You may rely on it", audioFilename: "you_may_rely_on_it", fileType: "m4a"),
        (text: "As I see it, yes", audioFilename: "as_i_see_it", fileType: "m4a"),
        (text: "Most likely", audioFilename: "most_likely", fileType: "m4a"),
        (text: "Outlook good", audioFilename: "outlook_good", fileType: "m4a"),
        (text: "Yes", audioFilename: "yes", fileType: "m4a"),
        (text: "Signs point to yes", audioFilename: "signs_point_to_yes", fileType: "m4a"),
        (text: "Reply hazy try again", audioFilename: "reply_hazy_try_again", fileType: "m4a"),
        (text: "Ask again later", audioFilename: "ask_again_later", fileType: "m4a"),
        (text: "Better not tell you now", audioFilename: "better_not_tell_you_now", fileType: "m4a"),
        (text: "Cannot predict now", audioFilename: "cannot_predict_now", fileType: "m4a"),
        (text: "Concentrate and ask again", audioFilename: "concentrate_and_ask_again", fileType: "m4a"),
        (text: "Don't count on it", audioFilename: "dont_count_on_it", fileType: "m4a"),
        (text: "My reply is no", audioFilename: "my_reply_is_no", fileType: "m4a"),
        (text: "My sources say no", audioFilename: "my_sources_say_no", fileType: "m4a"),
        (text: "Outlook not so good", audioFilename: "outlook_not_so_good", fileType: "m4a"),
        (text: "Very doubtful", audioFilename: "very_doubtful", fileType: "m4a"),
    ]
    
    var responseArray: [(text: String, audioFilename: String, fileType: String)]?
    
    var description: String {
        get {
            var desc = ""
            if let responses = responseArray {
                for response in responses {
                    desc += response.text
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
        responseArray = [(text: String, audioFilename: String, fileType: String)]()
        responseArray? += initialResponseArray
    }
    
    /**
     Default Constructor. Sets the responseArray property with the initialResponseArray and
     combines it with the extraResponseArray
     */
    init(extraResponseArray: [(text: String, audioFilename: String, fileType: String)]) {
        responseArray = [(text: String, audioFilename: String, fileType: String)]()
        responseArray? += initialResponseArray
        responseArray? += extraResponseArray
    }
    
    /**
     Tells the fortune by selecting a string from the response array randomly
     
        - Returns : a random string from the response array
     */
    func tellForturtune() -> (text: String, audioFilename: String, fileType: String)? {
        if let responses = responseArray {
            return responses[Int(arc4random_uniform(UInt32(responses.count)))]
        }
        else {
            return nil
        }
    }
    
    
    
}