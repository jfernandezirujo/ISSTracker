//
//  ISSPositionDTO.swift
//  ISSTracker
//
//  Created by Julieta Fernandez Irujo on 19/02/2024.
//

import Foundation

struct ISSPositionsDTO: Codable {
  let issPosition: ISSPositionCoordinates

  private enum CodingKeys: String, CodingKey {
    case issPosition = "iss_position"
  }
}

struct ISSPositionsCoordinates: Codable {
  let latitude: String
  let longitude: String

  private enum CodingKeys: String, CodingKey {
    case latitude
    case longitude
  }
}
