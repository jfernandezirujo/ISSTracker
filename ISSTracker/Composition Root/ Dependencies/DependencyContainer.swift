//
//  DependencyHelper.swift
//  ISSTracker
//
//  Created by Julieta Fernandez Irujo on 18/02/2024.
//

class DependencyContainer {

  // MARK: - Methods
  static func makeGetPositionAPIClientUseCase() -> GetPositionAPIClientUseCaseProtocol {
    let getPositionAPIClientRepository: GetPositionAPIClientRepositoryProtocol = GetPositionAPIClientRepository()
    return GetPositionAPIClientUseCase(repository: getPositionAPIClientRepository)
  }

  static func makeSavePositionCoreDataUseCase() -> SavePositionCoreDataUseCaseProtocol {
    let savePositionCoreDataRepository: SavePositionCoreDataRepositoryProtocol = SavePositionCoreDataRepository()
    return SavePositionCoreDataUseCase(repository: savePositionCoreDataRepository)
  }

  static func makeGetPositionCoreDataUseCase() -> GetPositionCoreDataUseCaseProtocol {
    let getPositionCoreDataRepository: GetPositionCoreDataRepositoryProtocol = GetPositionCoreDataRepository()
    return GetPositionCoreDataUseCase(repository: getPositionCoreDataRepository)
  }
}
