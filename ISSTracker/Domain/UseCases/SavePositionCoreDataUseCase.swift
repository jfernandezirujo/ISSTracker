//
//  SavePositionCoreDataUseCase.swift
//  ISSTracker
//
//  Created by Julieta Fernandez Irujo on 19/01/2024.
//

import CoreData
import Combine

struct SavePositionCoreDataUseCase: SavePositionCoreDataUseCaseProtocol {

  // MARK: - Properties
  var repository: SavePositionCoreDataRepositoryProtocol

  // MARK: - init
  init(repository: SavePositionCoreDataRepositoryProtocol) {
    self.repository = repository
  }

  // MARK: - Methods
  func execute(positionData: ISSPositionModel) -> AnyPublisher<Void, ISSPositionDataError> {
    let dto: ISSPositionDTO = ISSPositionMapper.map(model: positionData)
    return self.repository.savePositionInCoreData(positionData: dto)
  }
}

// MARK: - protocol
protocol SavePositionCoreDataUseCaseProtocol {
  func execute(positionData: ISSPositionModel) -> AnyPublisher<Void, ISSPositionDataError>
}
