//
//  ISSPositionViewModel.swift
//  ISSTracker
//
//  Created by Julieta Fernandez Irujo on 05/02/2024.
//

import Combine
import CoreData
import MapKit
import SwiftUI

class ISSPositionViewModel: ObservableObject {
  
  // MARK: - Properties
  typealias constants = PresentationConstants
  var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
  @Published private var isOnline: Bool
  @Published private var lastPositionData: ISSPositionModel?
  @Published private var lastPositionCoreData: LastPositionModel?
  @Published private var zoomLevel: Double

  private let useCaseProvider: ISSPositionUseCaseProviderProtocol
  private var timer: Timer?

  let currentPositionSubject: CurrentValueSubject = CurrentValueSubject<MKCoordinateRegion?, Never>(nil)
  var currentPositionPublisher: AnyPublisher<MKCoordinateRegion?, Never> {
    return currentPositionSubject.eraseToAnyPublisher()
  }

  // MARK: - Publishers
  var longitudePublisher: AnyPublisher<String, Never> {
    $lastPositionData.combineLatest($lastPositionCoreData)
      .map { (positionData, coreDataPosition) in
        let longitude: String = positionData?.longitude ?? coreDataPosition?.longitude ?? ""
        return "\(constants.longitude) \(longitude)"
      }
      .eraseToAnyPublisher()
  }

  var latitudePublisher: AnyPublisher<String, Never> {
    $lastPositionData.combineLatest($lastPositionCoreData)
      .map { (positionData, coreDataPosition) in
        let latitude: String = positionData?.latitude ?? coreDataPosition?.latitude ?? ""
        return "\(constants.latitude) \(latitude)"
      }
      .eraseToAnyPublisher()
  }

  // MARK: - init
  init(useCaseProvider: ISSPositionUseCaseProviderProtocol) {
    self.useCaseProvider = useCaseProvider
    self.isOnline = false
    self.zoomLevel = constants.zoomLevel
  }

  // MARK: - Methods
  func refreshPosition() {
    useCaseProvider.getPositionAPIClient.execute()
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { [weak self] completion in
        switch completion {
        case .finished:
          break
        case .failure:
          self?.isOnline = false
        }
      }, receiveValue: { [weak self] positionDataModel in
        self?.isOnline = true
        self?.lastPositionData = positionDataModel
        self.self?.savePositionInCoreData()
      })
      .store(in: &cancellables)
  }

  func savePositionInCoreData() {
    guard let positionData: ISSPositionModel = lastPositionData else { return }
    useCaseProvider.savePositionCoreData.execute(positionData: positionData)
      .sink(
        receiveCompletion: { _ in },
        receiveValue: {}
      )
      .store(in: &cancellables)
  }

  func getPositionFromCoreData() {
    useCaseProvider.getPositionCoreData.execute()
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: { _ in },
        receiveValue: { [weak self] position in
          self?.lastPositionCoreData = position
        })
      .store(in: &cancellables)
  }

  func startUpdatingPosition() {
    Timer.publish(
      every: constants.timeRefresh,
      on: .main,
      in: .common
    )
    .autoconnect()
    .sink { [weak self] _ in
      guard let self: ISSPositionViewModel = self else { return }
      withAnimation {
        if self.isOnline {
          self.refreshPosition()
        }
        self.updateCurrentPosition()
      }
    }
    .store(in: &cancellables)
  }

  func zoomOutMap() {
    guard zoomLevel < constants.maxZoomDelta else { return }
    zoomLevel += constants.zoomDelta
  }

  func zoomInMap() {
    guard zoomLevel > constants.minZoomDelta else { return }
    zoomLevel -= constants.zoomDelta
  }

  func updateCurrentPosition() {
    guard let latitudeString: String = lastPositionData?.latitude ?? lastPositionCoreData?.latitude,
          let longitudeString: String = lastPositionData?.longitude ?? lastPositionCoreData?.longitude
    else {
      currentPositionSubject.send(nil)
      return
    }
    let latitudeMap: Double = Double(latitudeString) ?? .zero
    let longitudeMap: Double = Double(longitudeString) ?? .zero
    let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(
      latitude: latitudeMap,
      longitude: longitudeMap
    )

    let span: MKCoordinateSpan = MKCoordinateSpan(
      latitudeDelta: zoomLevel,
      longitudeDelta: zoomLevel
    )

    let region: MKCoordinateRegion = MKCoordinateRegion(
      center: coordinate,
      span: span
    )

    currentPositionSubject.send(region)
  }
}
