//
//  ViewController.swift
//  Checklists
//
//  Created by armno on 12/8/2558 BE.
//  Copyright © 2558 armno. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
  
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
  
  func configureCheckmarkForCell(cell: UITableViewCell, withChecklistItem item: ChecklistItem) {
    
    if item.checked {
      cell.accessoryType = .Checkmark
    } else {
      cell.accessoryType = .None
    }
    
  }
  
  func configureTextForCell(cell: UITableViewCell, withChecklistItem item: ChecklistItem) {
    let label = cell.viewWithTag(1000) as! UILabel
    label.text = item.text
  }

}

