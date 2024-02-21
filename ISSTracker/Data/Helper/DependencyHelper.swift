//
//  DependencyHelper.swift
//  ISSTracker
//
//  Created by Julieta Fernandez Irujo on 18/02/2024.
//

class DependencyHelper {
  
  // MARK: - Methods
  static func getPositionAPIClientUseCase() -> GetPositionAPIClientUseCaseProtocol {
    let getPositionAPIClientRepository: GetPositionAPIClientRepositoryProtocol = GetPositionAPIClientRepository()
    return GetPositionAPIClientUseCase(repository: getPositionAPIClientRepository)
  }
  
  static func savePositionCoreDataUseCase() -> SavePositionCoreDataUseCaseProtocol {
    let savePositionCoreDataRepository: SavePositionCoreDataRepositoryProtocol = SavePositionCoreDataRepository()
    return SavePositionCoreDataUseCase(repository: savePositionCoreDataRepository)
  }
  
  static func getPositionCoreDataUseCase() -> GetPositionCoreDataUseCaseProtocol {
    let getPositionCoreDataRepository: GetPositionCoreDataRepositoryProtocol = GetPositionCoreDataRepository()
    return GetPositionCoreDataUseCase(repository: getPositionCoreDataRepository)
  }
}
