//
//  DataConstants.swift
//  ISSTracker
//
//  Created by Julieta Fernandez Irujo on 19/01/2024.
//

struct DataConstants {
  static let urlString: String = "http://api.open-notify.org/iss-now.json"
  static let container: String = "LastPositionModel"
  static let fetchLimit: Int = 1
  static let coreDataEntityName: String = "LastPositionModel"
  static let requestPredicateFormat: String = "isCurrent == true"
}
