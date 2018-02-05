//
//  ViewController.swift
//  Bucket_list
//
//  Created by Dojo on 1/16/18.
//  Copyright © 2018 Dojo. All rights reserved.
//

import UIKit
import CoreData

class BucketListViewController: UITableViewController, AddItemTableViewControllerDelegate {
    var items = [BucketListItem]()
    
    let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchALLItems()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].text!
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected")
        //performSegue(withIdentifier: "EditItemSegue", sender: indexPath)
    }
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "ItemSegue", sender: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        managedObjectContext.delete(item)
        appDelegate.saveContext()
        
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if sender is UIBarButtonItem{
        //if(segue.identifier == "AddItemSegue"){
            let navigationController = segue.destination as! UINavigationController
            let addItemController = navigationController.topViewController as! AddItemTableViewController
            addItemController.delegate = self
        }else{
      //  }else if(segue.identifier == "EditItemSegue"){
            let navigationController = segue.destination as! UINavigationController
            let addItemController = navigationController.topViewController as! AddItemTableViewController
            addItemController.delegate = self
            
            let indexPath = sender as! NSIndexPath
            let item = items[indexPath.row]
            addItemController.item = item.text!
            addItemController.indexPath = indexPath
        }
    }
    
    func fetchALLItems(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BucketListItem")
        do{
            let result = try managedObjectContext.fetch(request)
            items = result as! [BucketListItem]
        }catch{
            print("\(error)")
        }
       
    }
    
    
    func cancelButtonPressed(by controller: AddItemTableViewController) {
        dismiss(animated: true, completion: nil)
        
    }
    
    func itemSaved(by controller: AddItemTableViewController, with text:String, at indexPath: NSIndexPath?) {
        print("Received Text from view: \(text)")
        if let ip = indexPath{
            let item = items[ip.row]
            item.text = text
        } else {
            let item = NSEntityDescription.insertNewObject(forEntityName: "BucketListItem", into: managedObjectContext) as! BucketListItem
            item.text = text
            items.append(item)
        }
       
        appDelegate.saveContext()
       
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
        
    }

}

