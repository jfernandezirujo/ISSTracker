//
//  CoreDataManager.swift
//  ISSTracker
//
//  Created by Julieta Fernandez Irujo on 13/03/2025.
//

import CoreData

class CoreDataManager {
  
  // MARK: - Properties
  static let shared = CoreDataManager()
  
  let persistentContainer: NSPersistentContainer
  
  var context: NSManagedObjectContext {
    return persistentContainer.viewContext
  }
  
  // MARK: - init
  private init() {
    persistentContainer = NSPersistentContainer(name: DataConstants.container)
    persistentContainer.loadPersistentStores { _, error in
      if let error: Error = error {
        fatalError("\(error)")
      }
    }
  }
  
}
