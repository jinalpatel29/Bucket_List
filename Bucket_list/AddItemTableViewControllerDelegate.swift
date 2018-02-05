//
//  AddItemTableViewController.swift
//  Bucket_list
//
//  Created by Dojo on 1/16/18.
//  Copyright © 2018 Dojo. All rights reserved.
//

import Foundation
import UIKit

protocol AddItemTableViewControllerDelegate: class {
    func itemSaved(by controller: AddItemTableViewController, with text: String, at indexPath: NSIndexPath? )
    func cancelButtonPressed(by controller: AddItemTableViewController)
}
