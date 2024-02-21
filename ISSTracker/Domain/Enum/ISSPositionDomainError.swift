//
//  ISSPositionDomainError.swift
//  ISSTracker
//
//  Created by Julieta Fernandez Irujo on 19/01/2024.
//

enum ISSPositionDomainError: Error {
  case generic
  case invalidURL
  case invalidResponse
  case decodingError
}
