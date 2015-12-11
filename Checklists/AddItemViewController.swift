//
//  AddItemViewController.swift
//  Checklists
//
//  Created by armno on 12/11/2558 BE.
//  Copyright © 2558 armno. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate: class {
  func addItemViewControllerDidCancel(controller: AddItemViewController)
  func addItemViewController(controller: AddItemViewController, didFinishAddingItem item: ChecklistItem)
}

class AddItemViewController: UITableViewController, UITextFieldDelegate {
  
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var doneBarButton: UIBarButtonItem!
  
  weak var delegate: AddItemViewControllerDelegate?
  
  @IBAction func cancel() {
    delegate?.addItemViewControllerDidCancel(self)
  }
  
  @IBAction func done() {
    
    let item = ChecklistItem()
    item.text = textField.text!
    item.checked = false
    
    delegate?.addItemViewController(self, didFinishAddingItem: item)
    
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