//
//  DailyStatsViewController.swift
//  ToDoList
//
//  Created by Sam Khano on 2/27/16.
//  Copyright © 2016 samkhano. All rights reserved.
//

import UIKit

class DailyStatsViewController: UITableViewController {

    var delegate : ModelDelegate?
    var stats : ToDoListModel!
    
    @IBOutlet weak var taskCount: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stats = delegate?.returnDailyStats()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        stats = delegate?.returnDailyStats()
        let cell = tableView.dequeueReusableCellWithIdentifier("statsCell", forIndexPath: indexPath) as! ToDoCellViewController
        print(stats.getEntryAtIndex(indexPath.row))
        cell.toDoItemText.text = stats.getEntryAtIndex(indexPath.row)
        print(stats.getEntryAtIndex(indexPath.row))
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stats = delegate?.returnDailyStats()
        if let statsUnwrapped = stats {
            taskCount.title = "\(statsUnwrapped.getTableCount()) Tasks Completed!"
            return statsUnwrapped.getTableCount()
        }
        return 0
    }

    
    

}
