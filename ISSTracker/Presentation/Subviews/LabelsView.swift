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
  @State private var latitude: String = ""
  @State private var longitude: String = ""

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
        Text(latitude)
        Divider()
        Text(longitude)
      }
    }
    .onReceive(viewModel.longitudePublisher) { longitude = $0 }
    .onReceive(viewModel.latitudePublisher) { latitude = $0 }
  }
}
