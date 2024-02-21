//
//  GetPositionCoreDataUseCase.swift
//  ISSTracker
//
//  Created by Julieta Fernandez Irujo on 19/01/2024.
//

import Combine

// MARK: - protocol
protocol GetPositionCoreDataUseCaseProtocol {
  func execute() -> AnyPublisher<LastPosition?, ISSPositionDomainError>
}

// MARK: - GetPositionCoreDataUseCase
struct GetPositionCoreDataUseCase: GetPositionCoreDataUseCaseProtocol {
  
  // MARK: - Properties
  var repository: GetPositionCoreDataRepositoryProtocol
  
  // MARK: - init
  init(repository: GetPositionCoreDataRepositoryProtocol) {
    self.repository = repository
  }
  
  // MARK: - Methods
  func execute() -> AnyPublisher<LastPosition?, ISSPositionDomainError> {
    return repository.getPositionFromCoreData()
  }
}
