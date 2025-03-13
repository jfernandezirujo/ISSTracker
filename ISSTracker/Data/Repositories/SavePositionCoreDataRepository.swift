//
//  SavePositionCoreDataRepository.swift
//  ISSTracker
//
//  Created by Julieta Fernandez Irujo on 16/02/2024.
//

import Combine
import CoreData

class SavePositionCoreDataRepository: SavePositionCoreDataRepositoryProtocol {

  // MARK: - Methods
  func savePositionInCoreData(positionData: ISSPositionDTO) -> AnyPublisher<Void, ISSPositionDataError> {
    return Future<Void, ISSPositionDataError> { promise in
      let context: NSManagedObjectContext = CoreDataManager.shared.context
      let request: NSFetchRequest<LastPositionModel> = LastPositionModel.fetchRequest()
      request.fetchLimit = DataConstants.fetchLimit
      do {
        let existingPosition: [LastPositionModel] = try context.fetch(request)

        existingPosition.forEach { position in
          position.isCurrent = false
        }

        let issPosition: LastPositionModel

        if let lastPosition: LastPositionModel = existingPosition.first {
          issPosition = lastPosition
        } else {
          issPosition = LastPositionModel(context: context)
        }

        issPosition.latitude = positionData.issPosition.latitude
        issPosition.longitude = positionData.issPosition.longitude
        issPosition.isCurrent = true

        try context.save()
        promise(.success(()))
      } catch {
        promise(.failure(.coreDataSaveError))
      }
    }
    .eraseToAnyPublisher()
  }
}

// MARK: - protocol
protocol SavePositionCoreDataRepositoryProtocol {
  func savePositionInCoreData(positionData: ISSPositionDTO) -> AnyPublisher<Void, ISSPositionDataError>
}
