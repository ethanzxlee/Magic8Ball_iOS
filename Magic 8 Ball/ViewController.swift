//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by Zhe Xian Lee on 06/03/2016.
//  Copyright © 2016 Zhe Xian Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let name = "Zhe Xian Lee"
    let age = 21.0
    
    var eightBall : EightBallModel?
    var questionArray: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Zhe Xian Lee")
        print(String(format: "%.2f", age))
        print("My name is \(name)")
        print("")
        
        questionArray = [
            "Will I get full marks for this lab?",
            "Will the Cronulla sharks receive a premiership this year?",
            "Will I end up becoming a cat person when I get old?"
        ]
        
        let myResponse😎 = [
            "Whatever",
            "💩"
        ]
        
        eightBall = EightBallModel(extraResponseArray: myResponse😎)
        
        if let questions = questionArray {
            for question in questions {
                print(question)
                print(eightBall?.tellForturtune())
                print("")
            }
        }
        
        print(eightBall?.description)
        debugPrint(eightBall?.debugDescription)
            
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

