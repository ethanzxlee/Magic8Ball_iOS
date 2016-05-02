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
        (text: NSLocalizedString("It is certain", comment:""), audioFilename: "it_is_certain", fileType: "m4a"),
        (text: NSLocalizedString("It is decidedly so", comment:""), audioFilename: "it_is_decidedly_so", fileType: "m4a"),
        (text: NSLocalizedString("Without a doubt", comment:""), audioFilename: "without_a_doubt", fileType: "m4a"),
        (text: NSLocalizedString("Yes, definitely", comment:""), audioFilename: "yes_definitely", fileType: "m4a"),
        (text: NSLocalizedString("You may rely on it", comment:""), audioFilename: "you_may_rely_on_it", fileType: "m4a"),
        (text: NSLocalizedString("As I see it, yes", comment:""), audioFilename: "as_i_see_it", fileType: "m4a"),
        (text: NSLocalizedString("Most likely", comment:""), audioFilename: "most_likely", fileType: "m4a"),
        (text: NSLocalizedString("Outlook good", comment:""), audioFilename: "outlook_good", fileType: "m4a"),
        (text: NSLocalizedString("Yes", comment:""), audioFilename: "yes", fileType: "m4a"),
        (text: NSLocalizedString("Signs point to yes", comment:""), audioFilename: "signs_point_to_yes", fileType: "m4a"),
        (text: NSLocalizedString("Reply hazy try again", comment:""), audioFilename: "reply_hazy_try_again", fileType: "m4a"),
        (text: NSLocalizedString("Ask again later", comment:""), audioFilename: "ask_again_later", fileType: "m4a"),
        (text: NSLocalizedString("Better not tell you now", comment:""), audioFilename: "better_not_tell_you_now", fileType: "m4a"),
        (text: NSLocalizedString("Cannot predict now", comment:""), audioFilename: "cannot_predict_now", fileType: "m4a"),
        (text: NSLocalizedString("Concentrate and ask again", comment:""), audioFilename: "concentrate_and_ask_again", fileType: "m4a"),
        (text: NSLocalizedString("Don't count on it", comment:""), audioFilename: "dont_count_on_it", fileType: "m4a"),
        (text: NSLocalizedString("My reply is no", comment:""), audioFilename: "my_reply_is_no", fileType: "m4a"),
        (text: NSLocalizedString("My sources say no", comment:""), audioFilename: "my_sources_say_no", fileType: "m4a"),
        (text: NSLocalizedString("Outlook not so good", comment:""), audioFilename: "outlook_not_so_good", fileType: "m4a"),
        (text: NSLocalizedString("Very doubtful", comment:""), audioFilename: "very_doubtful", fileType: "m4a"),
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