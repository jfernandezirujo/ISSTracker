//
//  ISSPositionDataError.swift
//  ISSTracker
//
//  Created by Julieta Fernandez Irujo on 19/01/2024.
//

enum ISSPositionDataError: Error {
  case invalidURL
  case decodingError
  case coreDataSaveError
  case coreDataFetchError
}
