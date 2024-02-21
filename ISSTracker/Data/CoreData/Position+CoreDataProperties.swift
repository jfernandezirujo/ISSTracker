//
//  Position+CoreDataProperties.swift
//  ISSTracker
//
//  Created by Julieta Fernandez Irujo on 17/02/2024.
//

import Foundation
import CoreData

public class LastPosition: NSManagedObject {
  
  typealias constants = DataConstants
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<LastPosition> {
    return NSFetchRequest<LastPosition>(entityName: constants.coreDataEntityName)
  }
  
  @NSManaged public var latitude: String?
  @NSManaged public var longitude: String?
  
}
