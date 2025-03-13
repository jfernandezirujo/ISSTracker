//
//  MapView.swift
//  ISSTracker
//
//  Created by Julieta Fernandez Irujo on 05/02/2024.
//

import Combine
import MapKit
import SwiftUI

struct MapView: View {

  // MARK: - Properties
  typealias constants = PresentationConstants
  @ObservedObject var viewModel: ISSPositionViewModel
  @State private var mapRegion: MKCoordinateRegion?

  // MARK: - body
  var body: some View {
    Group {
      if let mapRegion: MKCoordinateRegion = mapRegion {
        Map(coordinateRegion: .constant(mapRegion))
          .gesture(
            MagnificationGesture()
              .onEnded { scale in
                if scale > constants.one {
                  viewModel.zoomOutMap()
                } else {
                  viewModel.zoomInMap()
                }
                viewModel.updateCurrentPosition()
              }
          )
          .cornerRadius(constants.cornerRadius)
          .overlay(
            Image(constants.pin)
              .resizable()
              .frame(
                width: constants.pinFrame,
                height: constants.pinFrame
              )
          )
      } else {
        ProgressView()
      }
    }
    .onAppear {
      viewModel.updateCurrentPosition()
    }
    .onReceive(viewModel.currentPositionPublisher) { receivedMapRegion in
      self.mapRegion = receivedMapRegion
    }
  }
}
