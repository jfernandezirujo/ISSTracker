//
//  ISSPositionUseCaseProvider.swift
//  ISSTracker
//
//  Created by Julieta Fernandez Irujo on 14/02/2024.
//

final class ISSPositionUseCaseProvider: ISSPositionUseCaseProviderProtocol {

  // MARK: - Properties
  var getPositionAPIClient: GetPositionAPIClientUseCaseProtocol
  var savePositionCoreData: SavePositionCoreDataUseCaseProtocol
  var getPositionCoreData: GetPositionCoreDataUseCaseProtocol

  // MARK: - init
  init(
    getPositionAPIClient: GetPositionAPIClientUseCaseProtocol,
    savePositionCoreData: SavePositionCoreDataUseCaseProtocol,
    getPositionCoreData: GetPositionCoreDataUseCaseProtocol
  ) {
    self.getPositionAPIClient = getPositionAPIClient
    self.savePositionCoreData = savePositionCoreData
    self.getPositionCoreData = getPositionCoreData
  }
}

// MARK: - protocol
protocol ISSPositionUseCaseProviderProtocol {
  var getPositionAPIClient: GetPositionAPIClientUseCaseProtocol { get }
  var savePositionCoreData: SavePositionCoreDataUseCaseProtocol { get }
  var getPositionCoreData: GetPositionCoreDataUseCaseProtocol { get }
}
