//
//  Child+CoreDataProperties.swift
//  Adding childrens
//
//  Created by Антон on 24.10.2022.
//
//

import Foundation
import CoreData


extension Child {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Child> {
        return NSFetchRequest<Child>(entityName: "Child")
    }

    @NSManaged public var age: Int16
    @NSManaged public var name: String?

}

extension Child : Identifiable {

}
