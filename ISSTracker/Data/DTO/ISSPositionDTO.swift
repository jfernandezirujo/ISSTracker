//
//  ISSPositionDTO.swift
//  ISSTracker
//
//  Created by Julieta Fernandez Irujo on 19/02/2024.
//

struct ISSPositionDTO: Decodable {
  let issPosition: ISSPositionsCoordinates

  private enum CodingKeys: String, CodingKey {
    case issPosition = "iss_position"
  }
}

struct ISSPositionsCoordinates: Decodable {
  let latitude: String
  let longitude: String
}
