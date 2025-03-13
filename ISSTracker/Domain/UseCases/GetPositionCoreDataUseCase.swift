//
//  GetPositionCoreDataUseCase.swift
//  ISSTracker
//
//  Created by Julieta Fernandez Irujo on 19/01/2024.
//

import Combine

struct GetPositionCoreDataUseCase: GetPositionCoreDataUseCaseProtocol {

  // MARK: - Properties
  var repository: GetPositionCoreDataRepositoryProtocol

  // MARK: - init
  init(repository: GetPositionCoreDataRepositoryProtocol) {
    self.repository = repository
  }

  // MARK: - Methods
  func execute() -> AnyPublisher<LastPositionModel?, ISSPositionDataError> {
    return repository.getPositionFromCoreData()
  }
}

// MARK: - protocol
protocol GetPositionCoreDataUseCaseProtocol {
  func execute() -> AnyPublisher<LastPositionModel?, ISSPositionDataError>
}
