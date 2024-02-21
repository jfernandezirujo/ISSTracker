//
//  DataConstants.swift
//  ISSTracker
//
//  Created by Julieta Fernandez Irujo on 19/01/2024.
//

struct DataConstants {
  static let urlString: String = "http://api.open-notify.org/iss-now.json"
  static let successStatusCode: Int = 200

  // Core Data
  static let container: String = "CoreDataModel"
  static let fetchLimit: Int = 1
  static let coreDataEntityName: String = "LastPosition"
}
