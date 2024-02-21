//
//  SplashView.swift
//  ISSTracker
//
//  Created by Julieta Fernandez Irujo on 05/02/2024.
//

import SwiftUI

struct SplashView: View {

  //MARK: - Properties
  typealias constants = PresentationConstants

  // MARK: - body
  var body: some View {
    ZStack {
      Color.black
        .ignoresSafeArea()
      Image(constants.logo)
        .resizable()
        .scaledToFit()
    }
  }
}
