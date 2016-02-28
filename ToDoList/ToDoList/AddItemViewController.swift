//
//  AddItemViewController.swift
//  ToDoList
//
//  Created by Sam Khano on 2/27/16.
//  Copyright © 2016 samkhano. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {

    @IBOutlet weak var userInput: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    
    
    var delegate : ModelDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusLabel.text = "Enter a task"
        saveButton.setTitle("Save", forState: UIControlState.Normal)
    }
    
    
    @IBAction func DoneButton(sender: UIBarButtonItem) {
        if let text = userInput.text {
            if (text != "") {
                statusLabel.text = "Task Saved!"
                delegate?.updateModel(text)
            }
        }
    }
    
}
