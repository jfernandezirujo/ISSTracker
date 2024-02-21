//
//  SavePositionCoreDataUseCase.swift
//  ISSTracker
//
//  Created by Julieta Fernandez Irujo on 19/01/2024.
//

import CoreData
import Combine

// MARK: - protocol
protocol SavePositionCoreDataUseCaseProtocol {
  func execute(positionData: ISSPositionDTO) -> AnyPublisher<Void, ISSPositionDomainError>
}

// MARK: - SavePositionCoreDataUseCase
struct SavePositionCoreDataUseCase: SavePositionCoreDataUseCaseProtocol {

  // MARK: - Properties
  var repository: SavePositionCoreDataRepositoryProtocol
  
  // MARK: - init
  init(repository: SavePositionCoreDataRepositoryProtocol) {
    self.repository = repository
  }

  // MARK: - Methods
  func execute(positionData: ISSPositionDTO) -> AnyPublisher<Void, ISSPositionDomainError> {
    return self.repository.savePositionInCoreData(positionData: positionData)
  }
}

