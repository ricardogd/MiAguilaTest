//
//  MapViewController.swift
//  MiAguilaTest
//
//  Created by Ricardo Grajales Duque on 8/30/19.
//  Copyright © 2019 Ricardo Grajales Duque. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps

class MapViewController: UIViewController {

    let locationManager = CLLocationManager()
    @IBOutlet weak var mapView: GMSMapView!
    var routePoints = [RoutePointModel]()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        configureLocationManager()
        setUpSpeedView(speedString: "0 Km/h")
        resetMarkers()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        locationManager.stopUpdatingLocation()
    }
    
    //MARK: - SetUp Views
    private func setUpNavigationBar() {
        navigationItem.title = "Google Map View"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(finishAction))
    }
    
    private func setUpSpeedView(speedString: String) {
        let speedView = SpeedView(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
        speedView.setSpeedText(speedString: speedString)
        mapView.addSubview(speedView)
    }
    
    func resetMarkers() {
        mapView?.clear()
        
        let initialMarker = GMSMarker()
        initialMarker.position = Configurations.shared.initialLocation?.coordinate ?? CLLocationCoordinate2D()
        initialMarker.title = "Start"
        initialMarker.icon = UIImage(named: "Initial_Marker")
        initialMarker.map = mapView
        
        let finalMarker = GMSMarker()
        finalMarker.title = "Finish Line"
        finalMarker.position = Configurations.shared.finalLocation?.coordinate ?? CLLocationCoordinate2D()
        finalMarker.icon = UIImage(named: "Final_Marker")
        finalMarker.map = mapView
        
        let routeViewModel = RouteViewModel()
        routeViewModel.polyline.map = mapView
    }
    
    //MARK: - Configure Location Manager
    func configureLocationManager() {
        let authorizationStatus = CLLocationManager.authorizationStatus()
        if authorizationStatus != .authorizedWhenInUse && authorizationStatus != .authorizedAlways {
            locationManager.requestAlwaysAuthorization()
        }
        if !CLLocationManager.locationServicesEnabled() {
            return
        }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.distanceFilter = CLLocationDistance(Configurations.shared.distanceSteps ?? 0.0) // In meters.
        locationManager.delegate = self
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    //MARK: - Actions
    @objc func finishAction() {
        locationManager.stopUpdatingLocation()
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - Location Delegate
extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager,  didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else {
            return
        }
        
        let camera = GMSCameraPosition.camera(withLatitude: (lastLocation.coordinate.latitude), longitude: (lastLocation.coordinate.longitude), zoom: 14.0)
        self.mapView?.animate(to: camera)
        
        let newPoint = RoutePointModel(location: lastLocation)
        routePoints.append(newPoint)
        drawingRoutePoints(routePoints: routePoints)
    }
    
    func drawingRoutePoints(routePoints: [RoutePointModel]) {
        resetMarkers()
        routePoints.forEach { (routePoint) in
            if routePoint.time != routePoints.last?.time {
                let routePointViewModel = RoutePointViewModel(routeModel: routePoint)
                let marker = GMSMarker()
                marker.position = routePointViewModel.coodinate ?? CLLocationCoordinate2D()
                marker.title = routePointViewModel.timeString
                marker.snippet = routePointViewModel.snippetString
                marker.icon = routePointViewModel.icon
                marker.map = mapView
            }
            else {
                let routePointViewModel = RoutePointViewModel(routeModel: routePoint)
                let marker = GMSMarker()
                marker.position = routePointViewModel.coodinate ?? CLLocationCoordinate2D()
                marker.title = routePointViewModel.timeString
                marker.snippet = routePointViewModel.snippetString
                marker.icon = nil
                marker.map = mapView
                setUpSpeedView(speedString: routePointViewModel.speedString)
                return
            }
        }
    }
}
