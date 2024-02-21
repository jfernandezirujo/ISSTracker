//
//  ButtonsView.swift
//  ISSTracker
//
//  Created by Julieta Fernandez Irujo on 16/02/2024.
//

import SwiftUI

struct ButtonsView: View {
  
  // MARK: - Properties
  @ObservedObject var viewModel: ISSPositionViewModel
  typealias constants = PresentationConstants
  
  // MARK: - body
  var body: some View {
    HStack {
      Spacer()
      setButton(imageName: constants.refresh,
                method: self.refreshPosition,
                paddingEdge: .bottom)

      setButton(imageName: constants.zoomIn,
                method: self.zoomInMap,
                paddingEdge: [.bottom, .leading, .trailing])

      setButton(imageName: constants.zoomOut,
                method: self.zoomOutMap,
                paddingEdge: .bottom)
    }
  }
  
  // MARK: - Methods
  private func setButton(imageName: String,
                         method: @escaping () -> Void,
                         paddingEdge: Edge.Set) -> some View {
    return Button(action: {
      method()
    })
    {
      Image(systemName: imageName)
        .font(.title2)
    }
    .frame(width: constants.buttonFrame,
           height: constants.buttonFrame)
    .foregroundColor(.black)
    .padding(paddingEdge, constants.buttonPadding)
  }
  
  private func refreshPosition() {
    viewModel.refreshPosition()
  }
  
  private func zoomInMap() {
    viewModel.zoomInMap()
  }
  
  private func zoomOutMap() {
    viewModel.zoomOutMap()
  }
}

