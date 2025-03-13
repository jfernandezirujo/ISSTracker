//
//  PresentationConstants.swift
//  ISSTracker
//
//  Created by Julieta Fernandez Irujo on 19/01/2024.
//

import Foundation

struct PresentationConstants {
  
  // MARK: - Splash
  static let logo: String = "iss-logo"

  // MARK: - View
  static let title: String = "ISS Tracker"
  static let latitude: String = "Latitude: "
  static let longitude: String = "Longitude: "
  static let refresh: String = "arrow.triangle.2.circlepath"
  static let zoomIn: String = "plus.circle"
  static let zoomOut: String = "minus.circle"
  static let timeRefresh: TimeInterval = 1.0
  static let buttonFrame: CGFloat = 44
  static let buttonPadding: CGFloat = 8
  static let rectangleFrame: CGFloat = 60
  static let padding: CGFloat = 20
  static let cornerRadius: CGFloat = 12
  static let one: CGFloat = 1
  static let timeSplash: TimeInterval = 2.0
  
  // MARK: - Map
  static let zoomLevel: Double = 10.0
  static let zoomDelta: Double = 2.0
  static let minZoomDelta: Double = 2.0
  static let maxZoomDelta: Double = 20.0
  static let pin: String = "iss-pin"
  static let pinFrame: CGFloat = 50
}
