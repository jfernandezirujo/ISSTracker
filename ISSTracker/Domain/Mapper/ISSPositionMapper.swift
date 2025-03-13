//
//  ISSPositionMapper.swift
//  ISSTracker
//
//  Created by Julieta Fernandez Irujo on 12/03/2025.
//

class ISSPositionMapper {

  // MARK: - Methods
  static func map(dto: ISSPositionDTO) -> ISSPositionModel {
    return ISSPositionModel(
      latitude: dto.issPosition.latitude,
      longitude: dto.issPosition.longitude
    )
  }

  static func map(model: ISSPositionModel) -> ISSPositionDTO {
    let coordinates: ISSPositionsCoordinates = ISSPositionsCoordinates(
      latitude: model.latitude,
      longitude: model.longitude
    )
    return ISSPositionDTO(issPosition: coordinates)
  }
}
