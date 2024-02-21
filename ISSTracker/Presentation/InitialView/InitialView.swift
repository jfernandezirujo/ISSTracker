//
//  InitialView.swift
//  ISSTracker
//
//  Created by Julieta Fernandez Irujo on 05/02/2024.
//

import SwiftUI
import Combine

struct InitialView: View {
  
  //MARK: - Properties
  typealias constants = PresentationConstants
  @State private var isSplashFinished: Bool = false
  @EnvironmentObject private var viewModel: ISSPositionViewModel
  
  //MARK: - body
  var body: some View {
    ZStack {
      if isSplashFinished {
        ISSPositionView()
      } else {
        SplashView()
      }
    }
    .onAppear {
      Timer.publish(every: constants.time,
                    on: .main,
                    in: .common)
        .autoconnect()
        .sink { _ in
          withAnimation {
            self.isSplashFinished = true
          }
        }
        .store(in: &viewModel.cancellables)
    }
  }
}
