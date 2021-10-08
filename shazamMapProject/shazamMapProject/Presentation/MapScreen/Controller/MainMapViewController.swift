//
//  MainMapViewController.swift
//  shazamMapProject
//
//  Created by Dmitriy Marchenkov on 08.10.2021.
//

import UIKit
import MapKit

enum MainScreenState {
    case main
    case loading
    case result
}

final class MainMapViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let mainView = MainMapView()
    private let model = MainMapModel()
    
    private let mainScreenVC = BottomInfoScreenViewController()
    private let loadingScreen = LoadingScreenViewController()
    
    private var mapView: MKMapView {
        mainView.mapView
    }
    
    private let locationService = ServiceLayer.locationService
    
    private var currentLocation: CLLocation? = CLLocation(latitude: 0, longitude: 0) {
        didSet {
            searchInMap()
        }
    }
    
    private let searchRadius: CLLocationDistance = 2000
    private let shazamService = ShazamService()
    private var screenState = MainScreenState.main {
        didSet {
            
        }
    }
    
    private let minHight: CGFloat = 216
    private let maxHeight: CGFloat = UIScreen.main.bounds.height - 144
    
    // MARK: - UIViewController
    
    override func loadView() {
        view = mainView
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentLocation = touch.location(in: view)
            let previousLocation = touch.previousLocation(in: view)
            
            let heightDelta = currentLocation.y - previousLocation.y
            let widthDelta = currentLocation.x - previousLocation.x
            
            if touch.view == mainView.diskView {
                let diskLeftPosition = abs(mainView.centerXDiskViewConstraint.constant)
                let maxDeltaAffine: CGFloat = 0.5
                let delta = 1 - abs(diskLeftPosition - view.frame.midX) / (view.frame.width * 0.5)
                let deltaAffine = 1 + (maxDeltaAffine * delta)
                let animationPercent = deltaAffine - 0.5
                
                mainView.centerXDiskViewConstraint.constant += widthDelta
                mainView.diskView.transform = CGAffineTransform(scaleX: deltaAffine, y: deltaAffine)
                let middleSize = (maxHeight) * (deltaAffine - 0.5)
                mainView.topContentViewConstraint.constant = view.frame.height - middleSize
                
                let newDiskYPosition: CGFloat = 380 * animationPercent
                
                mainView.centerYDiskViewConstraint.constant = newDiskYPosition
                
                if animationPercent >= 0.99 {
                    guard !shazamService.isRecording else { return }
                    screenState = .loading
                    startShazamming()
                }
                
                if animationPercent < 25 {
                    mainScreenVC.view.alpha = 1 - animationPercent * 1.5
                }
                
                if animationPercent > 25 {
                    loadingScreen.view.alpha = 1.0
                }
            }
            
            guard touch.view == mainView.bottomInfoContainerView else { return }
            mainView.topContentViewConstraint.constant += heightDelta
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard screenState == .main else { return }
                
        if let touch = touches.first {
            
            if touch.view == mainView.diskView {
                mainView.centerXDiskViewConstraint.constant = 0
                mainView.diskView.transform = .identity
                mainScreenVC.view.alpha = 1.0
            } else {
                guard touch.view == mainView.bottomInfoContainerView else { return }
            }
            
            var newHeight = CGFloat()
            
            if mainView.topContentViewConstraint.constant < minHight {
                newHeight = minHight
            } else if mainView.topContentViewConstraint.constant < maxHeight && mainView.topContentViewConstraint.constant > minHight  {
                newHeight = maxHeight
            } else {
                newHeight = maxHeight
            }
            
            let diskAlpha = newHeight == maxHeight ? 1.0 : 0.0
            mainView.topContentViewConstraint.constant = newHeight
            
            UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.76, initialSpringVelocity: 2.5, options: .curveEaseInOut) {
                self.view.layoutIfNeeded()
                self.mainView.diskView.alpha = diskAlpha
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.setContraints()
        getUserLocation()
        addChild(controller: mainScreenVC, rootView: mainView.bottomInfoContainerView)
        addChild(controller: loadingScreen, rootView: mainView.bottomInfoContainerView)
//        loadingScreen.view.alpha = 0.0
        shazamService.recordingStateChanged = { [weak self] isRecording in
            let title = isRecording ? "RECORDING" : "NOT RECORDING"
            print(title)
        }
    }
    
    
    func startShazamming() {
        guard !shazamService.isRecording else {
            shazamService.cancelDetection()
            return
        }
        
        shazamService.detect { [weak self] result in
            switch result {
            case .success(let content):
                let resultScreen = ResultScreenViewController(shazamMedia: content)
                self?.present(resultScreen, animated: true)
            case .failure(let error):
                break
            }
            
            print(result)
        }
        
    }
    
    // MARK: - Private Methods
    
    private func getUserLocation() {
        locationService.run { [weak self] localLocation in
            guard let self = self, let localLocation = localLocation else { return }
            self.currentLocation = localLocation
            self.setupMap()
        }
    }
    
    private func setupMap() {
        currentLocation = CLLocation(latitude: 0, longitude: 0)
        mapView.delegate = self
        
        let coordinateRegion = MKCoordinateRegion.init(
            center: currentLocation!.coordinate,
            latitudinalMeters: searchRadius * 2.0,
            longitudinalMeters: searchRadius * 2.0
        )
        
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    private func searchInMap() {
        model.searchBars(in: currentLocation!) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                for item in response!.mapItems {
                    let coordinate = item.placemark.location!.coordinate
                    //                    self.addPinToMapView(title: item.name, location: coordinate)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func addPinToMapView(title: String?, location: CLLocationCoordinate2D) {
        if let title = title {
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = title
            mapView.addAnnotation(annotation)
        }
    }
}

// MARK: - MKMapViewDelegate

extension MainMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        currentLocation = CLLocation(
            latitude: mapView.centerCoordinate.latitude,
            longitude: mapView.centerCoordinate.longitude
        )
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "something")
        annotationView.markerTintColor = .green
        return annotationView
    }
}
