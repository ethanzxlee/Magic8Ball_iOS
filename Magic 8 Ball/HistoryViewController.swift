//
//  HistoryViewController.swift
//  Magic 8 Ball
//
//  Created by Zhe Xian Lee on 4/04/2016.
//  Copyright © 2016 Zhe Xian Lee. All rights reserved.
//

import UIKit

class HistoryViewController: UITableViewController {

    let loadEntriesURL = NSURLComponents(string: "http://li859-75.members.linode.com/retrieveAllEntries.php")?.URL
    var loadEntriesTask: NSURLSessionDataTask?
    
    var questionResponseArray = [QuestionResponseModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create load entries task
        loadEntriesTask = NSURLSession.sharedSession().dataTaskWithRequest(NSURLRequest(URL: loadEntriesURL!), completionHandler:  {
          (data, response, error) -> Void in
            guard let _data = data, let _response = response as? NSHTTPURLResponse where error == nil else {
                print(error)
                return
            }
            
            if (_response.statusCode == 200) {
                do {
                    let objects = try NSJSONSerialization.JSONObjectWithData(_data, options: .MutableContainers)
                    
                    guard let arrayObjects = objects as? [[String : AnyObject]] else {
                        print("Failed to cast objects to an array")
                        return
                    }
                    
                    self.questionResponseArray.removeAll()
                    
                    // Create QuestionResponseModels
                    for item in arrayObjects {
                        guard let question = item["question"] as? String else {
                            continue
                        }
                        
                        guard let response = item["answer"] as? String else {
                            continue
                        }
                        
                        guard let username = item["username"] as? String else {
                            continue
                        }
                        
                        guard let imageURL = item["imageURL"] as? String else {
                            continue
                        }
                        
                        let questionResponseModel = QuestionResponseModel(question: question, response: response, username: username, imageURL: imageURL)
                        self.questionResponseArray.append(questionResponseModel)
                    }
                    
                    // Reload the table view in main thread
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
                    })
                    
                }
                catch {
                    print(error)
                }
            }
            else {
                print(_response)
            }
        })
        
        // Start the task
        loadEntriesTask?.resume()

    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return questionResponseArray.count
        }
        return 0
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch (indexPath.section) {
        case 0:
            guard let cell = tableView.dequeueReusableCellWithIdentifier("HistoryCell", forIndexPath: indexPath) as? HistoryTableViewCell else {
                return UITableViewCell()
            }
            
            cell.tag = indexPath.row
            cell.questionLabel?.text = questionResponseArray[indexPath.row].question
            cell.responseLabel?.text = questionResponseArray[indexPath.row].response
            cell.profileImageView.image = nil
            
            guard let pictureURL = NSURLComponents(string: questionResponseArray[indexPath.row].imageURL)?.URL else {
                return cell
            }

            // Create the load picture request
            let loadPictureRequest = NSURLRequest(URL: pictureURL)
            
            // Create a task to load the picture
            let loadPictureTask = NSURLSession.sharedSession().dataTaskWithRequest(loadPictureRequest, completionHandler: { (data, response, error) -> Void in
                // Check if there's any error
                guard let _data = data, let _response = response as? NSHTTPURLResponse where error == nil else {
                    print(error)
                    return
                }
                
                // Check if the response status code is OK before continuing
                if (_response.statusCode == 200) {
                    
                    // Update the cell image in main thread
                    if (indexPath.row == cell.tag) {
                        let profileImage = UIImage(data: _data)
                        
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            cell.profileImageView.image = profileImage
                        })
                    }
                }
                else {
                    print(_response)
                }
            })
            
            // Start the task
            loadPictureTask.resume()
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

}
