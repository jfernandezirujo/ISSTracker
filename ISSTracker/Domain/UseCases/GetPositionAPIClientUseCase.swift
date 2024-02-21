//
//  GetPositionAPIClientUseCase.swift
//  ISSTracker
//
//  Created by Julieta Fernandez Irujo on 19/01/2024.
//

import Combine

// MARK: - protocol
protocol GetPositionAPIClientUseCaseProtocol {
  func execute() -> AnyPublisher<ISSPositionDTO, ISSPositionDomainError>
}

// MARK: - GetPositionAPIClientUseCase
class GetPositionAPIClientUseCase: GetPositionAPIClientUseCaseProtocol {
  
  // MARK: - Properties
  private let repository: GetPositionAPIClientRepositoryProtocol
  
  // MARK: - init
  init(repository: GetPositionAPIClientRepositoryProtocol) {
    self.repository = repository
  }
  
  // MARK: - Methods
  func execute() -> AnyPublisher<ISSPositionDTO, ISSPositionDomainError> {
    let result: AnyPublisher<ISSPositionDTO, ISSPositionDomainError> = repository.getPositionAPIClient()
        .mapError { _ in
          return ISSPositionDomainError.generic
        }
        .eraseToAnyPublisher()

    return result
  }
}
