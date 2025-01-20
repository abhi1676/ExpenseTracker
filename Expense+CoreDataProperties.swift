//
//  Expense+CoreDataProperties.swift
//  ExpenseTrackerApp
//
//  Created by Apple on 1/20/25.
//
//

import Foundation
import CoreData


extension Expense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense")
    }

    @NSManaged public var title: String?
    @NSManaged public var price: Double
    @NSManaged public var date: Date?
    @NSManaged public var category: String?

}

extension Expense : Identifiable {

}
