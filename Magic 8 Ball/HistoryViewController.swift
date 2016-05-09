//
//  HistoryViewController.swift
//  Magic 8 Ball
//
//  Created by Zhe Xian Lee on 4/04/2016.
//  Copyright © 2016 Zhe Xian Lee. All rights reserved.
//

import UIKit

class HistoryViewController: UITableViewController {

    var questionResponseArray : [QuestionResponseModel] = []
    var task: NSURLSessionDataTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let session = NSURLSession.sharedSession()
        
        let url = NSURLComponents(string: "http://li859-75.members.linode.com/retrieveAllEntries.php")?.URL
        
        task = session.dataTaskWithRequest(NSURLRequest(URL: url!), completionHandler: { (data, response, error) -> Void in
            guard let _data = data , let _response = response where error == nil else {
                print(error)
                return
            }
            
            guard let dataString = NSString(data: _data, encoding: NSUTF8StringEncoding) else {
                return
            }
            
            
            do {
                let parsedObjects = try NSJSONSerialization.JSONObjectWithData(_data, options: NSJSONReadingOptions.MutableContainers) as! [[String: String]]
                print(parsedObjects)
            }
            catch {
                print(error)
            }
            
        })
        
        task?.resume()
        

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
            let cell = tableView.dequeueReusableCellWithIdentifier("HistoryCell", forIndexPath: indexPath)
            
            cell.textLabel?.text = questionResponseArray[indexPath.row].question
            cell.detailTextLabel?.text = questionResponseArray[indexPath.row].response
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

}
