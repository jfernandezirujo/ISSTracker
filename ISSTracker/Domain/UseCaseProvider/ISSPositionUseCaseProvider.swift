//
//  ISSPositionUseCaseProvider.swift
//  ISSTracker
//
//  Created by Julieta Fernandez Irujo on 14/02/2024.
//

// MARK: - protocol
protocol ISSPositionUseCaseProviderProtocol {
  var getPositionAPIClient: GetPositionAPIClientUseCaseProtocol { get }
  var savePositionCoreData: SavePositionCoreDataUseCaseProtocol { get }
  var getPositionCoreData: GetPositionCoreDataUseCaseProtocol { get }
}

// MARK: - ISSPositionUseCaseProvider
final class ISSPositionUseCaseProvider: ISSPositionUseCaseProviderProtocol {

  // MARK: - Properties
  internal var getPositionAPIClient: GetPositionAPIClientUseCaseProtocol
  internal var savePositionCoreData: SavePositionCoreDataUseCaseProtocol
  internal var getPositionCoreData: GetPositionCoreDataUseCaseProtocol
  
  // MARK: - init
  init(getPositionAPIClient: GetPositionAPIClientUseCaseProtocol,
       savePositionCoreData: SavePositionCoreDataUseCaseProtocol,
       getPositionCoreData: GetPositionCoreDataUseCaseProtocol) {
    self.getPositionAPIClient = getPositionAPIClient
    self.savePositionCoreData = savePositionCoreData
    self.getPositionCoreData = getPositionCoreData
  }

  // MARK: - lazy properties
  lazy var getPositionAPIClientRepository: GetPositionAPIClientRepositoryProtocol = {
    return GetPositionAPIClientRepository()
  }()

  lazy var getPositionCoreDataRepository: GetPositionCoreDataRepositoryProtocol = {
    return GetPositionCoreDataRepository()
  }()

  lazy var savePositionCoreDataRepository: SavePositionCoreDataRepositoryProtocol = {
    return SavePositionCoreDataRepository()
  }()
  
  // MARK: - Methods
  func provideGetPositionAPIClientUseCase() -> GetPositionAPIClientUseCaseProtocol {
    return GetPositionAPIClientUseCase(repository: getPositionAPIClientRepository)
  }
  
  func provideSavePositionCoreDataUseCase() -> SavePositionCoreDataUseCaseProtocol {
    return SavePositionCoreDataUseCase(repository: savePositionCoreDataRepository)
  }
  
  func provideGetPositionCoreDataUseCase() ->  GetPositionCoreDataUseCaseProtocol {
    return GetPositionCoreDataUseCase(repository: getPositionCoreDataRepository)
  }
}
