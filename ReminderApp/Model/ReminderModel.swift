//
//  ReminderModel.swift
//  ReminderApp
//
//  Created by Semih Özsoy on 20.05.2021.
//

import UIKit
import CoreData
public class ReminderModel:NSObject{
    var title: String?
    var notes: String?
    var flag: Bool?
    var priority: String?
    var list: List?
   
}

extension Reminder {
    
      func configured(title _title: String?,
                      notes _notes: String?,
                      flag _flag: Bool?,
                      priority _priority:String?,
                      list _list: List?) -> Self {
        title = _title
        notes =  _notes
        flag = _flag ?? false
        priority = _priority
        list = _list
        return self
      }
    
}

