//
//  GetPositionAPIClientUseCase.swift
//  ISSTracker
//
//  Created by Julieta Fernandez Irujo on 19/01/2024.
//

import Combine

class GetPositionAPIClientUseCase: GetPositionAPIClientUseCaseProtocol {

  // MARK: - Properties
  private let repository: GetPositionAPIClientRepositoryProtocol

  // MARK: - init
  init(repository: GetPositionAPIClientRepositoryProtocol) {
    self.repository = repository
  }

  // MARK: - Methods
  func execute() -> AnyPublisher<ISSPositionModel, ISSPositionDomainError> {
    let result: AnyPublisher<ISSPositionModel, ISSPositionDomainError> = repository.getPositionAPIClient()
      .map { value in
        return ISSPositionMapper.map(dto: value)
      }
      .mapError { _ in
        return ISSPositionDomainError.unknown
      }
      .eraseToAnyPublisher()

    return result
  }
}

// MARK: - protocol
protocol GetPositionAPIClientUseCaseProtocol {
  func execute() -> AnyPublisher<ISSPositionModel, ISSPositionDomainError>
}
