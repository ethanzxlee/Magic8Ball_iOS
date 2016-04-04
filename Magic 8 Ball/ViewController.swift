//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by Zhe Xian Lee on 06/03/2016.
//  Copyright © 2016 Zhe Xian Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    var eightBall : EightBallModel?
    var questionResponseArray : [QuestionResponseModel]?
    
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var magicEightBallImageView: UIImageView!
    @IBOutlet weak var responseLabel: UILabel!
    @IBOutlet weak var shakeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        questionResponseArray = NSKeyedUnarchiver.unarchiveObjectWithFile(QuestionResponseModel.ArchiveURL.path!) as? [QuestionResponseModel]
        if (questionResponseArray == nil) {
            questionResponseArray = [QuestionResponseModel]()
        }
        
        eightBall = EightBallModel()
        questionTextField?.delegate = self
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "didDetectTapGesture:"))
    }
    

    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {

        if (textField == questionTextField) {
            shakeMagicEightBall(textField)
            return true
        }
        
        return false
    }
    
    
    // MARK: - IBAction
    
//    @IBAction func historyButtonPressed(sender: AnyObject) {
//        shakeMagicEightBall(sender)
//    }
    
    
    // MARK: - Functions
    
    func shakeMagicEightBall(sender: AnyObject?) {
        
        // Display an alert if the text field is empty
        if (questionTextField.text?.characters.count == 0) {
            let alert = UIAlertController(title: "No question asked", message: "Please ask a question before shaking the magic eight ball.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        let textField = sender as? UITextField
        let button = sender as? UIButton
        
        // Hides the keyboard if the sender is questionTextField
        if (textField == questionTextField) {
            questionTextField.resignFirstResponder()
        }
        
        if (button == shakeButton || textField == questionTextField) {
            // Pick a eight ball image randomly
            let randomNumber = Int(arc4random_uniform(UInt32(5))) + 1
            let magicEightBallImage = UIImage(named: "circle\(randomNumber)")
            
            // Fade out animation and then fade in
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.responseLabel.alpha = 0
                self.magicEightBallImageView.alpha = 0
                
                }, completion: { (_) -> Void in
                    self.magicEightBallImageView.image = magicEightBallImage
                    self.responseLabel.text = self.eightBall?.tellForturtune()
                    
                    // Append the question and response to the array
                    self.questionResponseArray?.append(QuestionResponseModel(question: self.questionTextField.text!, response: self.responseLabel.text!))
                    
                    // Try to save the array to file
                    if let _questionResponseArray = self.questionResponseArray {
                        let isSaveQuestionResponseSuccessful = NSKeyedArchiver.archiveRootObject(_questionResponseArray, toFile: QuestionResponseModel.ArchiveURL.path!)
                        
                        if (isSaveQuestionResponseSuccessful) {
                            print("yes")
                        }
                        else {
                            print("no :(");
                        }
                    }
                    
                    
                    
                    
                    UIView.animateWithDuration(0.5, animations: { () -> Void in
                        self.responseLabel.alpha = 1
                        self.magicEightBallImageView.alpha = 1
                    })
            })
        }
        
    }
    
    func didDetectTapGesture(gestureRecognizer: UITapGestureRecognizer) {
        if (questionTextField.isFirstResponder()) {
            questionTextField.resignFirstResponder()
        }
    }


}

