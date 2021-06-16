//
//  List+CoreDataProperties.swift
//  ReminderApp
//
//  Created by Semih Özsoy on 20.05.2021.
//
//

import Foundation
import CoreData


extension List {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<List> {
        return NSFetchRequest<List>(entityName: "List")
    }

    @NSManaged public var image: Data?
    @NSManaged public var listText: String?
    @NSManaged public var reminders: NSSet?

}

// MARK: Generated accessors for reminders
extension List {

    @objc(addRemindersObject:)
    @NSManaged public func addToReminders(_ value: Reminder)

    @objc(removeRemindersObject:)
    @NSManaged public func removeFromReminders(_ value: Reminder)

    @objc(addReminders:)
    @NSManaged public func addToReminders(_ values: NSSet)

    @objc(removeReminders:)
    @NSManaged public func removeFromReminders(_ values: NSSet)

}

extension List : Identifiable {

}
