//
//  LabelsView.swift
//  ISSTracker
//
//  Created by Julieta Fernandez Irujo on 16/02/2024.
//

import SwiftUI

struct LabelsView: View {
  
  // MARK: - Properties
  @ObservedObject var viewModel: ISSPositionViewModel
  typealias constants = PresentationConstants
  
  // MARK: - body
  var body: some View {
    ZStack {
      Rectangle()
        .fill(.clear)
        .overlay(
          RoundedRectangle(cornerRadius: constants.cornerRadius)
            .stroke(.black, lineWidth: constants.one)
        )
        .frame(height: constants.rectangleFrame)
      VStack(spacing: constants.one) {
        Text(viewModel.coordinates.latitude)
        Divider()
        Text(viewModel.coordinates.longitude)
      }
    }
  }
}
