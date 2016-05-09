//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by Zhe Xian Lee on 06/03/2016.
//  Copyright © 2016 Zhe Xian Lee. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITextFieldDelegate, AVAudioPlayerDelegate {

    var eightBall : EightBallModel?
    var questionResponseArray : [QuestionResponseModel]?
    var audioPlayer : AVAudioPlayer?
    var speechSynthersizer : AVSpeechSynthesizer?
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var magicEightBallImageView: UIImageView!
    @IBOutlet weak var responseLabel: UILabel!
    @IBOutlet weak var shakeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        speechSynthersizer = AVSpeechSynthesizer()
        
        questionResponseArray = NSKeyedUnarchiver.unarchiveObjectWithFile(QuestionResponseModel.ArchiveURL.path!) as? [QuestionResponseModel]
        if (questionResponseArray == nil) {
            questionResponseArray = [QuestionResponseModel]()
        }
        
        eightBall = EightBallModel()
        questionTextField?.delegate = self
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "didDetectTapGesture:"))
    }
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ShowHistoryViewController") {
            if let navigationController = segue.destinationViewController as? UINavigationController {
                if let historyViewController = navigationController.childViewControllers.first as? HistoryViewController {
                    historyViewController.questionResponseArray = self.questionResponseArray!
                }
            }
        }
    }
    
    @IBAction func doneButtonPressed(segue: UIStoryboardSegue) {
        
    }

    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {

        if (textField == questionTextField) {
            shakeMagicEightBall(textField)
            return true
        }
        
        return false
    }
    
    
    // MARK: - Functions
    
    func shakeMagicEightBall(sender: AnyObject?) {
        
        // Display an alert if the text field is empty
        if (questionTextField.text?.characters.count == 0) {
            let alert = UIAlertController(title: NSLocalizedString("No question asked", comment: ""), message: NSLocalizedString("Please ask a question before shaking the magic eight ball.", comment: ""), preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .Default, handler: nil))
            
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
                    
                    let response = self.eightBall?.tellForturtune()
                    self.responseLabel.text = response!.text
                    
                    // Append the question and response to the array
                    self.questionResponseArray?.append(QuestionResponseModel(question: self.questionTextField.text!, response: self.responseLabel.text!))
                    self.archiveResponseToFile()
                    
                    // playResponse
                    self.playResponseWith(response!.text)
                    
                    
                    UIView.animateWithDuration(0.5, animations: { () -> Void in
                        self.responseLabel.alpha = 1
                        self.magicEightBallImageView.alpha = 1
                    })
            })
        }
        
    }
    
    
    func archiveResponseToFile() {
        // Try to save the array to file
        if let _questionResponseArray = self.questionResponseArray {
            NSKeyedArchiver.archiveRootObject(_questionResponseArray, toFile: QuestionResponseModel.ArchiveURL.path!)
        }

    }
    
    
    func playResponseWith(response: String) {
        speechSynthersizer?.speakUtterance(AVSpeechUtterance(string: response));
        
    }
    
    
    func didDetectTapGesture(gestureRecognizer: UITapGestureRecognizer) {
        if (questionTextField.isFirstResponder()) {
            questionTextField.resignFirstResponder()
        }
    }
    
    



}

