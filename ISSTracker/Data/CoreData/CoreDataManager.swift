//
//  CoreDataManager.swift
//  ISSTracker
//
//  Created by Julieta Fernandez Irujo on 16/02/2024.
//

import Foundation
import CoreData

class CoreDataManager {

  // MARK: - Properties
  static let shared: CoreDataManager = CoreDataManager()
  typealias constants = DataConstants

  lazy var persistentContainer: NSPersistentContainer = {
    let container: NSPersistentContainer = NSPersistentContainer(name: constants.container)
    container.loadPersistentStores { _, error in
      if let error: Error = error {
        fatalError("\(error)")
      }
    }
    return container
  }()
  
  var mainContext: NSManagedObjectContext {
    return persistentContainer.viewContext
  }
  
  // MARK: - Methods
  func saveContext() {
    guard mainContext.hasChanges else { return }
    do {
      try mainContext.save()
    } catch {
      fatalError("\(error)")
    }
  }
}
