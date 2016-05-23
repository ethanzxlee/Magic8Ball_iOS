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

    let postEntryURLComponent = NSURLComponents(string: "http://li859-75.members.linode.com/addEntry.php")
    
    var eightBall : EightBallModel?
    var audioPlayer : AVAudioPlayer?
    var speechSynthersizer : AVSpeechSynthesizer?
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var magicEightBallImageView: UIImageView!
    @IBOutlet weak var responseLabel: UILabel!
    @IBOutlet weak var shakeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        speechSynthersizer = AVSpeechSynthesizer()
        
        eightBall = EightBallModel()
        questionTextField?.delegate = self
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.didDetectTapGesture(_:))))
    }
    
    
    // MARK: - Navigation
    
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
                    
                    // send the response to server
                    self.postResponseToServer(question: self.questionTextField.text!, response: self.responseLabel.text!);
                    
                    // Play response
                    self.playResponseWith(response!.text)
                    
                    
                    UIView.animateWithDuration(0.5, animations: { () -> Void in
                        self.responseLabel.alpha = 1
                        self.magicEightBallImageView.alpha = 1
                    })
            })
        }
        
    }
    
    
    func playResponseWith(response: String) {
        speechSynthersizer?.speakUtterance(AVSpeechUtterance(string: response));
    }
    
    
    func postResponseToServer(question question: String, response: String) {
        let bodyString = "question=\(question)&answer=\(response)&username=zxl653";
        
        let postResponseRequest = NSMutableURLRequest(URL: postEntryURLComponent!.URL!)
        postResponseRequest.HTTPMethod = "POST"
        postResponseRequest.HTTPBody = bodyString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let postResponseTask = NSURLSession.sharedSession().dataTaskWithRequest(postResponseRequest) { (data, response, error) -> Void in
            // Check if there's any error
            guard let _response = response as? NSHTTPURLResponse where error == nil else {
                print(error)
                return
            }
            
            // Check if the response status code is OK before continuing
            if (_response.statusCode == 200) {
               print("Entry added")
            }
            else {
                print(_response)
            }

        }
        
        postResponseTask.resume()
        
    }
    
    
    func didDetectTapGesture(gestureRecognizer: UITapGestureRecognizer) {
        if (questionTextField.isFirstResponder()) {
            questionTextField.resignFirstResponder()
        }
    }
    

}

