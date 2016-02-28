//
//  ViewController.swift
//  ToDoList
//
//  Created by Sam Khano on 2/27/16.
//  Copyright © 2016 samkhano. All rights reserved.
//

import UIKit

protocol ModelDelegate {
    func updateModel(str : String?)
    func returnDailyStats() -> ToDoListModel
}

class ToDoTableViewController: UITableViewController, ModelDelegate {

    var modelObj : ToDoListModel!
    var dailyStatsModel : ToDoListModel!
    var listOfCheckedEntries : [String]!
    var countDownDict :[String : CFAbsoluteTime]!
    var startTime: CFAbsoluteTime!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modelObj = ToDoListModel()
        dailyStatsModel = ToDoListModel()
        listOfCheckedEntries = [String]()
        countDownDict = [String : CFAbsoluteTime]()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func unwindToDoTableViewController(segue: UIStoryboardSegue) {
    
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ToDoCell", forIndexPath: indexPath) as! ToDoCellViewController
        let str = modelObj.getEntryAtIndex(indexPath.row)
        cell.toDoItemText.text = str
        if (listOfCheckedEntries.contains(str)) {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.None;
        }
        startTime = CFAbsoluteTimeGetCurrent()
        for(str,i) in countDownDict {
            if ((startTime - i) >= 3600) {
                listOfCheckedEntries = remove(listOfCheckedEntries, str: str)
                countDownDict.removeValueForKey(str)
            }
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelObj.getTableCount()
    }
    
    func returnDailyStats() -> ToDoListModel {
        return dailyStatsModel
    }
    
    func updateModel(str : String?) {
        if let string = str {
            modelObj.addEntryToEndOfTable(string)
        }
        self.tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "AddItem") {
            let nav = segue.destinationViewController as! UINavigationController
            let vc = nav.viewControllers.first as! AddItemViewController
            vc.delegate = self
        }
        if (segue.identifier == "DailyStats") {
            let nav = segue.destinationViewController as! UINavigationController
            let vc = nav.viewControllers.first as! DailyStatsViewController
            vc.delegate = self
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            let cell = tableView.dequeueReusableCellWithIdentifier("ToDoCell", forIndexPath: indexPath) as! ToDoCellViewController
            cell.toDoItemText.text = ""
            cell.accessoryType = UITableViewCellAccessoryType.None
            modelObj.removeEntryAtIndex(indexPath.row)
            self.tableView.reloadData()
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let string = modelObj.getEntryAtIndex(indexPath.row) {
            if (string != "") {
                if (!listOfCheckedEntries.contains(string)) {
                    listOfCheckedEntries.append(string)
                    startTime = CFAbsoluteTimeGetCurrent()
                    countDownDict[string] = startTime
                    if (!dailyStatsModel.contains(string)) {
                        dailyStatsModel.addEntryToEndOfTable(string)
                    }
                } else {
                    listOfCheckedEntries = remove(listOfCheckedEntries, str: string)
                    countDownDict.removeValueForKey(string)
                    if (dailyStatsModel.contains(string)) {
                        dailyStatsModel.remove(string)
                    }
                }
                self.tableView.reloadData()
            }
        }
    }
    
    func remove(var arr : [String], str : String) ->[String] {
        for (var i = 0; i < arr.count; i++) {
            if (arr[i] == str) {
                arr.removeAtIndex(i)
                continue
            }
        }
        return arr
    }
}

