//
//  AddItemTableViewController.swift
//  Bucket_list
//
//  Created by Dojo on 1/16/18.
//  Copyright © 2018 Dojo. All rights reserved.
//

import UIKit

class AddItemTableViewController: UITableViewController {
    weak var delegate: AddItemTableViewControllerDelegate?
    
    var item: String?
    var indexPath: NSIndexPath?
    
    @IBOutlet weak var itemTextField: UITextField!
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        let text = itemTextField.text!
        delegate?.itemSaved(by: self, with: text, at: indexPath)
    }
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem)
    {
        delegate?.cancelButtonPressed(by: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemTextField.text = item
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
