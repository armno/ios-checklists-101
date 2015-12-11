//
//  ItemDeailViewController.swift
//  Checklists
//
//  Created by armno on 12/11/2558 BE.
//  Copyright © 2558 armno. All rights reserved.
//

import UIKit

protocol ItemDeailViewControllerDelegate: class {
  func itemDetailViewControllerDidCancel(controller: ItemDeailViewController)
  func itemDetailViewController(controller: ItemDeailViewController, didFinishAddingItem item: ChecklistItem)
  func itemDetailViewController(controller: ItemDeailViewController, didFinishEditingItem item: ChecklistItem)
}

class ItemDeailViewController: UITableViewController, UITextFieldDelegate {
  
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var doneBarButton: UIBarButtonItem!
  
  weak var delegate: ItemDeailViewControllerDelegate?
  
  var itemToEdit: ChecklistItem?
  
  @IBAction func cancel() {
    delegate?.itemDetailViewControllerDidCancel(self)
  }
  
  @IBAction func done() {
    
    if let item = itemToEdit {
      item.text = textField.text!
      delegate?.itemDetailViewController(self, didFinishEditingItem: item)
    } else {
    
      let item = ChecklistItem()
      item.text = textField.text!
      item.checked = false
      
      delegate?.itemDetailViewController(self, didFinishAddingItem: item)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let item = itemToEdit {
      title = "Edit Item"
      textField.text = item.text
      doneBarButton.enabled = true
    }
  }
  
  override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
    return nil
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    textField.becomeFirstResponder()
  }
  
  // delegate method
  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    let oldText: NSString = textField.text!
    let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
    
    doneBarButton.enabled = (newText.length > 0)
    
    return true
  }
  
}
