//
//  GetPositionCoreDataRepository.swift
//  ISSTracker
//
//  Created by Julieta Fernandez Irujo on 16/02/2024.
//

import CoreData
import Combine

class GetPositionCoreDataRepository: GetPositionCoreDataRepositoryProtocol {

  // MARK: - Properties
  typealias constants = DataConstants

  // MARK: - Methods
  func getPositionFromCoreData() -> AnyPublisher<LastPositionModel?, ISSPositionDataError> {
    let context: NSManagedObjectContext = CoreDataManager.shared.context
    let request: NSFetchRequest<LastPositionModel> = LastPositionModel.fetchRequest()
    request.fetchLimit = constants.fetchLimit
    request.predicate = NSPredicate(format: DataConstants.requestPredicateFormat)

    return Future<LastPositionModel?, ISSPositionDataError> { promise in
      do {
        let lastPosition: LastPositionModel? = try context.fetch(request).first
        promise(.success(lastPosition))
      } catch {
        promise(.failure(.coreDataFetchError))
      }
    }
    .eraseToAnyPublisher()
  }
}

// MARK: - protocol
protocol GetPositionCoreDataRepositoryProtocol {
  func getPositionFromCoreData() -> AnyPublisher<LastPositionModel?, ISSPositionDataError>
}
