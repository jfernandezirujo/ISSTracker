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

// MARK: - ISSPositionViewModel
class ISSPositionViewModel: ObservableObject {
  
  // MARK: - Properties
  typealias constants = PresentationConstants
  
  @Published var currentPosition: CLLocationCoordinate2D?
  @Published var lastPositionData: ISSPositionDTO?
  @Published var lastPositionCoreData: LastPosition?
  @Published var isOnline: Bool
  @Published var mapRegion: MKCoordinateRegion?
  @Published var zoomLevel: Double
  var coordinates: CoordinatesDTO
  
  
  private let useCaseProvider: ISSPositionUseCaseProviderProtocol
  private var timer: Timer?
  var cancellables = Set<AnyCancellable>()
  
  let currentPositionSubject: CurrentValueSubject = CurrentValueSubject<MKCoordinateRegion?, Never>(nil)
  var currentPositionPublisher: AnyPublisher<MKCoordinateRegion?, Never> {
    return currentPositionSubject.eraseToAnyPublisher()
  }
  
  // MARK: - Publishers
  var longitudePublisher: AnyPublisher<String, Never> {
    $lastPositionData.combineLatest($lastPositionCoreData)
      .map { (positionData, coreDataPosition) in
        let longitude: String = positionData?.issPosition.longitude ?? coreDataPosition?.longitude ?? ""
        return "\(constants.longitude) \(longitude)"
      }
      .eraseToAnyPublisher()
  }
  
  var latitudePublisher: AnyPublisher<String, Never> {
    $lastPositionData.combineLatest($lastPositionCoreData)
      .map { (positionData, coreDataPosition) in
        let latitude: String = positionData?.issPosition.latitude ?? coreDataPosition?.latitude ?? ""
        return "\(constants.latitude) \(latitude)"
      }
      .eraseToAnyPublisher()
  }
  
  // MARK: - init
  init(useCaseProvider: ISSPositionUseCaseProviderProtocol) {
    self.useCaseProvider = useCaseProvider
    self.isOnline = false
    self.zoomLevel = constants.zoomLevel
    self.coordinates = CoordinatesDTO()
    initPublishers()
  }
  
  // MARK: - Methods
  func setButtonsView() -> some View {
    return ButtonsView(viewModel: self)
  }
  
  func setLabelsView() -> some View {
    return LabelsView(viewModel: self)
  }
  
  func setMapview() -> some View {
    updateCurrentPosition()
    return MapView(viewModel: self)
  }
  
  func initPublishers() {
    latitudePublisher.receive(on: RunLoop.main)
      .assign(to: \.coordinates.latitude,
              on: self)
      .store(in: &cancellables)
    
    longitudePublisher.receive(on: RunLoop.main)
      .assign(to: \.coordinates.longitude,
              on: self)
      .store(in: &cancellables)
  }
  
  func refreshPosition() {
    useCaseProvider.getPositionAPIClient.execute()
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .finished:
          break
        case .failure(let error):
          self.isOnline = false
          print("\(constants.errorString) \(error)")
        }
      }, receiveValue: { [weak self] positionDataModel in
        self?.lastPositionData = positionDataModel
        self?.isOnline = true
      })
      .store(in: &cancellables)
  }
  
  func savePositionInCoreData() {
    guard let positionData: ISSPositionDTO = lastPositionData else { return }
    
    useCaseProvider.savePositionCoreData.execute(positionData: positionData)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .finished:
          break
        case .failure(let error):
          print("\(constants.errorString) \(error)")
        }
      }, receiveValue: {})
      .store(in: &cancellables)
  }
  
  func getPositionFromCoreData() {
    useCaseProvider.getPositionCoreData.execute()
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .finished:
          break
        case .failure(let error):
          print("\(constants.errorString) \(error)")
        }
      }, receiveValue: { [weak self] position in
        self?.lastPositionCoreData = position
        
      })
      .store(in: &cancellables)
  }
  
  func startUpdatingPosition() {
    Timer.publish(every: constants.time,
                  on: .main,
                  in: .common)
    .autoconnect()
    .sink { _ in
      withAnimation {
        if self.isOnline {
          self.refreshPosition()
        }
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
    guard let latitudeString: String = lastPositionData?.issPosition.latitude ?? lastPositionCoreData?.latitude,
          let longitudeString: String = lastPositionData?.issPosition.longitude ?? lastPositionCoreData?.longitude
    else {
      currentPositionSubject.send(nil)
      return
    }
    let latitudeMap: Double = Double(latitudeString) ?? .zero
    let longitudeMap: Double = Double(longitudeString) ?? .zero
    let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitudeMap,
                                                                    longitude: longitudeMap)
  
    let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: zoomLevel,
                                                  longitudeDelta: zoomLevel)
  
    let region: MKCoordinateRegion = MKCoordinateRegion(center: coordinate,
                                                        span: span)
    
    currentPositionSubject.send(region)
  }
}
