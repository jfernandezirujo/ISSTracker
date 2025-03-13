//
//  GetPositionAPIClientRepository.swift
//  ISSTracker
//
//  Created by Julieta Fernandez Irujo on 23/01/2024.
//

import Combine
import Foundation

class GetPositionAPIClientRepository: GetPositionAPIClientRepositoryProtocol {

  // MARK: - Properties
  typealias constants = DataConstants

  // MARK: - Methods
  func getPositionAPIClient() -> AnyPublisher<ISSPositionDTO, ISSPositionDataError> {
    guard let url: URL = URL(string: constants.urlString) else {
      return Fail(error: ISSPositionDataError.invalidURL)
        .eraseToAnyPublisher()
    }

    return URLSession.shared.dataTaskPublisher(for: url)
      .map { $0.data }
      .decode(
        type: ISSPositionDTO.self,
        decoder: JSONDecoder()
      )
      .receive(on: RunLoop.main)
      .mapError { _ in ISSPositionDataError.decodingError }
      .eraseToAnyPublisher()
  }
}

// MARK: - protocol
protocol GetPositionAPIClientRepositoryProtocol {
  func getPositionAPIClient() -> AnyPublisher<ISSPositionDTO, ISSPositionDataError>
}
