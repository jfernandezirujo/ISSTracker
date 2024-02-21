//
//  GetPositionCoreDataRepository.swift
//  ISSTracker
//
//  Created by Julieta Fernandez Irujo on 16/02/2024.
//

import CoreData
import Combine

// MARK: - protocol
protocol GetPositionCoreDataRepositoryProtocol {
  func getPositionFromCoreData() -> AnyPublisher<LastPosition?, ISSPositionDomainError>
}

// MARK: - GetPositionCoreDataRepository
class GetPositionCoreDataRepository: GetPositionCoreDataRepositoryProtocol {
  
  // MARK: - Properties
  typealias constants = DataConstants
  
  // MARK: - Methods
  func getPositionFromCoreData() -> AnyPublisher<LastPosition?, ISSPositionDomainError> {
    let context: NSManagedObjectContext = CoreDataManager.shared.mainContext
    let request: NSFetchRequest<LastPosition> = LastPosition.fetchRequest()
    request.fetchLimit = constants.fetchLimit
    
    return Future<LastPosition?, ISSPositionDomainError> { promise in
      do {
        let result: [LastPosition] = try context.fetch(request)
        if let lastPosition: LastPosition = result.first {
          promise(.success(lastPosition))
        } else {
          promise(.success(nil))
        }
      } catch {
        promise(.failure(.generic))
      }
    }
    .eraseToAnyPublisher()
  }
}
