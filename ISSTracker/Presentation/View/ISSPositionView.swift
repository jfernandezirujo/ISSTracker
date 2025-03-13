//
//  ISSPositionView.swift
//  ISSTracker
//
//  Created by Julieta Fernandez Irujo on 05/02/2024.
//

import SwiftUI

struct ISSPositionView: View {

  // MARK: - Properties
  typealias constants = PresentationConstants
  @EnvironmentObject private var viewModel: ISSPositionViewModel

  //MARK: - Body
  var body: some View {
    NavigationStack {
      VStack {
        setButtonsView()
        setMapView()
        setLabelsView()
      }
      .padding(.all, constants.padding)
      .onAppear {
        getPositionFromCoreData()
        refreshPosition()
        startUpdatingPosition()
      }
      .navigationBarTitle(constants.title, displayMode: .inline)
    }
  }

  //MARK: - Methods
  private func setButtonsView() -> some View {
    ButtonsView(viewModel: viewModel)
  }

  private func setLabelsView() -> some View {
    LabelsView(viewModel: viewModel)
  }

  private func setMapView() -> some View {
    viewModel.updateCurrentPosition()
    return MapView(viewModel: viewModel)
  }

  private func startUpdatingPosition() {
    viewModel.startUpdatingPosition()
  }

  private func refreshPosition() {
    viewModel.refreshPosition()
  }

  private func getPositionFromCoreData() {
    viewModel.getPositionFromCoreData()
  }
}
