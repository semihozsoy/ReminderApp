//
//  Reminder+CoreDataProperties.swift
//  ReminderApp
//
//  Created by Semih Özsoy on 20.05.2021.
//
//

import Foundation
import CoreData


extension Reminder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reminder> {
        return NSFetchRequest<Reminder>(entityName: "Reminder")
    }

    @NSManaged public var flag: Bool
    @NSManaged public var notes: String?
    @NSManaged public var priority: String?
    @NSManaged public var title: String?
    @NSManaged public var list: List?

}

extension Reminder : Identifiable {

}
