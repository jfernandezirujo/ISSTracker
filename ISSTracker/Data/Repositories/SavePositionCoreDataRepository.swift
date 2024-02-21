//
//  SavePositionCoreDataRepository.swift
//  ISSTracker
//
//  Created by Julieta Fernandez Irujo on 16/02/2024.
//

import Combine
import CoreData

// MARK: - protocol
protocol SavePositionCoreDataRepositoryProtocol {
  func savePositionInCoreData(positionData: ISSPositionDTO) -> AnyPublisher<Void, ISSPositionDomainError>
}

// MARK: - SavePositionCoreDataRepository
class SavePositionCoreDataRepository: SavePositionCoreDataRepositoryProtocol {
  
  // MARK: - Methods
  func savePositionInCoreData(positionData: ISSPositionDTO) -> AnyPublisher<Void, ISSPositionDomainError> {
    return Future<Void, ISSPositionDomainError> { promise in
      let context: NSManagedObjectContext = CoreDataManager.shared.mainContext
      let request: NSFetchRequest<LastPosition> = LastPosition.fetchRequest()
      
      do {
        let result: [LastPosition] = try context.fetch(request)
        if let lastPosition: LastPosition = result.first {
          lastPosition.latitude = positionData.issPosition.latitude
          lastPosition.longitude = positionData.issPosition.longitude
        } else {
          let issPosition: LastPosition = LastPosition(context: context)
          issPosition.latitude = positionData.issPosition.latitude
          issPosition.longitude = positionData.issPosition.longitude
        }
        try context.save()
        promise(.success(()))
      } catch {
        promise(.failure(.generic))
      }
    }
    .eraseToAnyPublisher()
  }
}
