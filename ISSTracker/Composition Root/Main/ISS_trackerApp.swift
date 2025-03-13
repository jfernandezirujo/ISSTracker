//
//  ISS_trackerApp.swift
//  ISSTracker
//
//  Created by Julieta Fernandez Irujo on 18/01/2024.
//

import SwiftUI
import CoreData

@main
struct ISS_trackerApp: App {

  // MARK: - Properties
  private let persistenceController: CoreDataManager
  private let viewModel: ISSPositionViewModel
  private let useCaseProvider: ISSPositionUseCaseProviderProtocol

  // MARK: - init
  init() {
    persistenceController = CoreDataManager.shared
    useCaseProvider = ISSPositionUseCaseProvider(
      getPositionAPIClient: DependencyContainer.makeGetPositionAPIClientUseCase(),
      savePositionCoreData: DependencyContainer.makeSavePositionCoreDataUseCase(),
      getPositionCoreData: DependencyContainer.makeGetPositionCoreDataUseCase()
    )
    viewModel = ISSPositionViewModel(useCaseProvider: useCaseProvider)
  }

  // MARK: - body
  var body: some Scene {
    WindowGroup {
      InitialView()
        .environmentObject(viewModel)
        .environment(\.managedObjectContext, persistenceController.context)
    }
  }
}
