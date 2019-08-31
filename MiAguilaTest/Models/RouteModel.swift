//
//  RouteModel.swift
//  MiAguilaTest
//
//  Created by Ricardo Grajales Duque on 8/30/19.
//  Copyright © 2019 Ricardo Grajales Duque. All rights reserved.
//

import Foundation

public class RouteModel {
    public var polylineString = ""
    public var isCacheAvailable = false
    public var routeURLString = ""
    let configurations = Configurations.shared
    
    public init() {
        if isCacheAvailableForRoute() {
            initFromCache()
        }
        else {
            initWithDefaultConfiguration()
        }
    }
    
    private func initFromCache() {
        if let pointsString = UserDefaults.standard.object(forKey: DictionaryKeys.route) as? String {
            self.polylineString = pointsString
        }
        isCacheAvailable = true
        routeURLString = getRouteURLString()
    }
    
    private func initWithDefaultConfiguration() {
        polylineString = ""
        isCacheAvailable = false
        routeURLString = getRouteURLString()
    }
    
    private func getRouteURLString() -> String {
        var routeURLString = ""
        guard let initialLatitude = configurations.initialLocation?.coordinate.latitude,
            let initialLongitude = configurations.initialLocation?.coordinate.longitude,
            let finalLatitude = configurations.finalLocation?.coordinate.latitude,
            let finalLongitude = configurations.finalLocation?.coordinate.longitude else {
                return routeURLString
        }
        
        let originCoordinates = "\(String(initialLatitude)),\(String(initialLongitude))"
        let destinationCoordinates = "\(String(finalLatitude)),\(String(finalLongitude))"
        routeURLString = "\(Constants.directionsURLString)&origin=\(originCoordinates)&destination=\(destinationCoordinates)&sensor=false&key=\(Constants.apiKey)"
        
        return routeURLString
    }
    
    private func isCacheAvailableForRoute() -> Bool {
        if UserDefaults.standard.object(forKey: DictionaryKeys.route) != nil {
            return true
        }
        return false
    }
}

private extension RouteModel {
    struct Constants {
        static let apiKey = "AIzaSyCudjqGl0pcD944fjR11j0-xYEIa4YSJ5s"
        static let directionsURLString = "https://maps.googleapis.com/maps/api/directions/json?"
    }
    
    struct DictionaryKeys {
        static let route = "route"
    }
}
