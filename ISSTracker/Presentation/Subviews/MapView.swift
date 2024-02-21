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
  
  private let pinOffset: CGSize = .zero
  @ObservedObject var viewModel: ISSPositionViewModel
  @State private var mapRegion: MKCoordinateRegion?
  
  // MARK: - init
  init(viewModel: ISSPositionViewModel) {
    self.viewModel = viewModel
    viewModel.currentPositionSubject
      .sink(receiveValue: { [self] region in
        self.mapRegion = region
      })
      .store(in: &viewModel.cancellables)
  }
  
  
  // MARK: - body
  var body: some View {
    Group {
      if let mapRegion: MKCoordinateRegion = mapRegion {
        Map(coordinateRegion: .constant(mapRegion))
          .gesture(
            MagnificationGesture()
              .onChanged { scale in
                if scale > constants.one {
                  viewModel.zoomOutMap()
                } else {
                  viewModel.zoomInMap()
                }
              }
          )
          .cornerRadius(constants.cornerRadius)
          .overlay(
            Image(constants.pin)
              .resizable()
              .frame(width: constants.pinFrame,
                     height: constants.pinFrame)
              .offset(pinOffset)
          )
      }
    }
    .onReceive(viewModel.currentPositionPublisher) { receivedMapRegion in
      self.mapRegion = receivedMapRegion
    }
  }
}
