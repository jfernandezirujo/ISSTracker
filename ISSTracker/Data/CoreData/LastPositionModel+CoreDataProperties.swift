//
//  LastPositionModel+CoreDataProperties.swift
//  ISSTracker
//
//  Created by Julieta Fernandez Irujo on 13/03/2025.
//
//

import CoreData

extension LastPositionModel {
  
  // MARK: - Properties
  @NSManaged var latitude: String?
  @NSManaged var longitude: String?
  @NSManaged var isCurrent: Bool
  
  // MARK: - Methods
  @nonobjc class func fetchRequest() -> NSFetchRequest<LastPositionModel> {
    return NSFetchRequest<LastPositionModel>(entityName: DataConstants.coreDataEntityName)
  }
}

extension LastPositionModel : Identifiable {}
