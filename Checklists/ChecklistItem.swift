//
//  ChecklistItem.swift
//  Checklists
//
//  Created by armno on 12/9/2558 BE.
//  Copyright © 2558 armno. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject {
  var text = ""
  var checked = false
  
  func toggleChecked() {
    checked = !checked
  }
}
