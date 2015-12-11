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
    
    let row0item = ChecklistItem()
    row0item.text = "Walk the dog"
    row0item.checked = false
    items.append(row0item)
    
    let row1item = ChecklistItem()
    row1item.text = "Brush my teeth"
    row1item.checked = true
    items.append(row1item)
    
    let row2item = ChecklistItem()
    row2item.text = "Learn iOS development"
    row2item.checked = false
    items.append(row2item)
    
    let row3item = ChecklistItem()
    row3item.text = "Soccer practice"
    row3item.checked = false
    items.append(row3item)
    
    let row4item = ChecklistItem()
    row4item.text = "Eat ice-cream"
    row4item.checked = false
    items.append(row4item)
    
    let row5item = ChecklistItem()
    row5item.text = "Go to Rim Ping"
    row5item.checked = true
    items.append(row5item)
    
    super.init(coder: aDecoder)
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
  }
  
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    items.removeAtIndex(indexPath.row)
    
    let indexPaths = [indexPath]
    tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
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
  }
  
  func itemDetailViewController(controller: ItemDeailViewController, didFinishEditingItem item: ChecklistItem) {
    if let index = items.indexOf(item) {
      let indexPath = NSIndexPath(forRow: index, inSection: 0)
      if let cell = tableView.cellForRowAtIndexPath(indexPath) {
        configureTextForCell(cell, withChecklistItem: item)
      }
    }
    
    dismissViewControllerAnimated(true, completion: nil)
  }

}

