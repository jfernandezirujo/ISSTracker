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
        refreshPosition()
        startUpdatingPosition()
      }
      .navigationBarTitle(constants.title, displayMode: .inline)
    }
  }
  
  //MARK: - Methods
  private func setButtonsView() -> some View {
    viewModel.setButtonsView()
  }
  
  private func setLabelsView() -> some View {
    viewModel.setLabelsView()
  }
  
  private func setMapView() -> some View {
    viewModel.setMapview()
  }
  
  private func startUpdatingPosition() {
    DispatchQueue.main.async {
      viewModel.startUpdatingPosition()
    }
  }
  
  private func refreshPosition() {
    DispatchQueue.main.async {
      viewModel.refreshPosition()
    }
  }
}
