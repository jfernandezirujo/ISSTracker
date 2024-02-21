//
//  GetPositionAPIClientRepository.swift
//  ISSTracker
//
//  Created by Julieta Fernandez Irujo on 23/01/2024.
//

import Combine
import Foundation

// MARK: - protocol
protocol GetPositionAPIClientRepositoryProtocol {
  func getPositionAPIClient() -> AnyPublisher<ISSPositionDTO, ISSPositionDomainError>
}

// MARK: - GetPositionAPIClientRepository
class GetPositionAPIClientRepository: GetPositionAPIClientRepositoryProtocol {
  
  // MARK: - Properties
  typealias constants = DataConstants
  
  // MARK: - Methods
  func getPositionAPIClient() -> AnyPublisher<ISSPositionDTO, ISSPositionDomainError> {
    guard let url: URL = URL(string: constants.urlString) else {
      return Fail(error: ISSPositionDomainError.invalidURL)
        .eraseToAnyPublisher()
    }

    return URLSession.shared.dataTaskPublisher(for: url)
      .tryMap { data, response -> Data in
        guard let httpResponse: HTTPURLResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == constants.successStatusCode else {
          throw ISSPositionDomainError.invalidResponse
        }
        return data
      }
      .decode(type: ISSPositionDTO.self,
              decoder: JSONDecoder())
      .receive(on: RunLoop.main)
      .mapError { error in
        if let error: ISSPositionDomainError = error as? ISSPositionDomainError {
          return error
        } else {
          return ISSPositionDomainError.decodingError
        }
      }
      .eraseToAnyPublisher()
  }
}
