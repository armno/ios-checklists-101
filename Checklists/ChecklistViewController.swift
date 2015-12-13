//
//  ViewController.swift
//  Checklists
//
//  Created by armno on 12/8/2558 BE.
//  Copyright © 2558 armno. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, ItemDeailViewControllerDelegate {
  
  var items: [ChecklistItem]
  
  required init?(coder aDecoder: NSCoder) {
    items = [ChecklistItem]()
    
    super.init(coder: aDecoder)
    loadChecklistItems()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
    
    
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
    
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      
    // get an active/current cell from the prototype cell
    let cell = tableView.dequeueReusableCellWithIdentifier("ChecklistItem", forIndexPath: indexPath)
    
    let item = items[indexPath.row]
    
    // we added the tag `1000` to the label.
    // this gets a reference to a UILabel with the tag `1000`
    configureTextForCell(cell, withChecklistItem: item)
    configureCheckmarkForCell(cell, withChecklistItem: item)
      
    return cell
  }
    
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      
    if let cell = tableView.cellForRowAtIndexPath(indexPath) {
      
      let item = items[indexPath.row]
      item.toggleChecked()
      configureCheckmarkForCell(cell, withChecklistItem: item)
        
    }
      
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
    saveChecklistItem()
  }
  
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    items.removeAtIndex(indexPath.row)
    
    let indexPaths = [indexPath]
    tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    
    saveChecklistItem()
  }
  
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "AddItem" {
      
      let navigationController = segue.destinationViewController as! UINavigationController
      let controller = navigationController.topViewController as! ItemDeailViewController
      
      controller.delegate = self
    } else if segue.identifier == "EditItem" {
      
      let navigationController = segue.destinationViewController as! UINavigationController
      let controller = navigationController.topViewController as! ItemDeailViewController
      
      controller.delegate = self
      
      if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
        controller.itemToEdit = items[indexPath.row]
      }
      
    }
  }
  
  func configureCheckmarkForCell(cell: UITableViewCell, withChecklistItem item: ChecklistItem) {
    
    let label = cell.viewWithTag(1001) as! UILabel
    
    if item.checked {
      label.text = "✔︎"
    } else {
      label.text = ""
    }
    
  }
  
  func configureTextForCell(cell: UITableViewCell, withChecklistItem item: ChecklistItem) {
    let label = cell.viewWithTag(1000) as! UILabel
    label.text = item.text
  }
  
  func itemDetailViewControllerDidCancel(controller: ItemDeailViewController) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func itemDetailViewController(controller: ItemDeailViewController, didFinishAddingItem item: ChecklistItem) {
    
    let newRowIndex = items.count
    
    items.append(item)
    
    let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
    let indexPaths = [indexPath]
    tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    
    dismissViewControllerAnimated(true, completion: nil)
    
    saveChecklistItem()
  }
  
  func itemDetailViewController(controller: ItemDeailViewController, didFinishEditingItem item: ChecklistItem) {
    if let index = items.indexOf(item) {
      let indexPath = NSIndexPath(forRow: index, inSection: 0)
      if let cell = tableView.cellForRowAtIndexPath(indexPath) {
        configureTextForCell(cell, withChecklistItem: item)
      }
    }
    
    dismissViewControllerAnimated(true, completion: nil)
    
    saveChecklistItem()
  }
  
  
  // files
  
  func documentDirectory() -> String {
    let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
    return paths[0]
  }
  
  
  func dataFilePath() -> String {
    return (documentDirectory() as NSString).stringByAppendingPathComponent("Checklists.plist")
  }
  
  // save checklist item
  func saveChecklistItem() {
    let data = NSMutableData()
    let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
    archiver.encodeObject(items, forKey: "ChecklistItems")
    archiver.finishEncoding()
    data.writeToFile(dataFilePath(), atomically: true)
  }
  
  func loadChecklistItems() {
    let path = dataFilePath()
    if NSFileManager.defaultManager().fileExistsAtPath(path) {
      if let data = NSData(contentsOfFile: path) {
        let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
        items = unarchiver.decodeObjectForKey("ChecklistItems") as! [ChecklistItem]
        unarchiver.finishDecoding()
      }
    }
  }
  
  

}

