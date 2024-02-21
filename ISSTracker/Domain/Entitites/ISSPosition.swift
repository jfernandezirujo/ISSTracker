//
//  ISSPosition.swift
//  ISSTracker
//
//  Created by Julieta Fernandez Irujo on 19/01/2024.
//

//struct ISSPosition: Decodable {
//}

struct ISSPositionDTO: Codable {
  let issPosition: ISSPositionCoordinates

  private enum CodingKeys: String, CodingKey {
    case issPosition = "iss_position"
  }
}

struct ISSPositionCoordinates: Codable {
  let latitude: String
  let longitude: String

  private enum CodingKeys: String, CodingKey {
    case latitude
    case longitude
  }
}
