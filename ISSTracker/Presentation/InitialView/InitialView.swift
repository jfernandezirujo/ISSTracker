//
//  InitialView.swift
//  ISSTracker
//
//  Created by Julieta Fernandez Irujo on 05/02/2024.
//

import SwiftUI
import Combine

struct InitialView: View {

  // MARK: - Properties
  typealias constants = PresentationConstants
  @State private var isSplashFinished: Bool = false

  // MARK: - body
  var body: some View {
    Group {
      if isSplashFinished {
        ISSPositionView()
      } else {
        SplashView()
          .transition(.opacity)
      }
    }
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + constants.timeSplash) {
        withAnimation {
          isSplashFinished = true
        }
      }
    }
  }
}
