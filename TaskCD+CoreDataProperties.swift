//
//  Task+CoreDataProperties.swift
//  Skillbox-14-CoreData
//
//  Created by Антон Тимоненков on 13.07.2020.
//  Copyright © 2020 Антон Тимоненков. All rights reserved.
//
//

import Foundation
import CoreData


extension TaskCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskCD> {
        return NSFetchRequest<TaskCD>(entityName: "TaskCD")
    }

    @NSManaged public var text: String?

}
