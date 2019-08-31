//
//  RoutePointViewModel.swift
//  MiAguilaTest
//
//  Created by Ricardo Grajales Duque on 8/30/19.
//  Copyright © 2019 Ricardo Grajales Duque. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

public class RoutePointViewModel {
    var speedString = ""
    var timeString = ""
    var distanceString = ""
    var coodinate = Configurations.shared.initialLocation?.coordinate
    var icon = UIImage()
    var snippetString = ""
    
    public init(routeModel: RoutePointModel) {
        speedString = getSpeedString(speed: routeModel.speed)
        timeString = getTimeString(date: routeModel.time)
        distanceString = getDistance(distance: routeModel.distance)
        coodinate = routeModel.coodinate ?? Configurations.shared.initialLocation?.coordinate
        icon = getIcon(routeModel: routeModel)
        snippetString = getSnippetString(firstInfo: distanceString, secondInfo: speedString)
    }
    
    private func getSpeedString(speed: Double?) -> String {
        var speedString = ""
        guard let speed = speed else {
            return speedString
        }
        
        if speed <= 0.0 {
            speedString = "0 Km/h"
        }
        else {
            speedString = String(format: "%.2f", speed) + " Km/h"
        }
        
        return speedString
    }
    
    private func getTimeString(date: Date?) -> String {
        var timeString = ""
        guard let date = date else {
            return timeString
        }
        
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        timeString = String(hour) + ":" + String(minutes) + ":" + String(seconds)
        
        return timeString
    }
    
    private func getDistance(distance: Double?) -> String {
        var distanceString = ""
        guard let distance = distance else {
            return distanceString
        }
        
        if distance >= 0.0 {
            distanceString = String(format: "%.2f", distance) + " m"
        }
        
        return distanceString
    }
    
    private func getIcon(routeModel: RoutePointModel) -> UIImage {
        var iconImage = UIImage()
        guard let initialDistance = routeModel.distance,
            let currentLatitud = routeModel.coodinate?.latitude,
            let currentLongitud = routeModel.coodinate?.longitude else {
                return iconImage
        }
        let currentLocation = CLLocation(latitude: currentLatitud, longitude: currentLongitud)
        let finalDistance = currentLocation.distance(from: Configurations.shared.finalLocation ?? CLLocation())
        
        if finalDistance <= 0.0 {
            iconImage = UIImage(named: "Final_Marker") ?? iconImage
        }
        else if initialDistance <= 0.0 {
            iconImage = UIImage(named: "Initial_Marker") ?? iconImage
        }
        else {
            iconImage = UIImage(named: "Route_Marker") ?? iconImage
        }
        
        return iconImage
    }
    
    private func getSnippetString(firstInfo: String, secondInfo: String) -> String {
        let snippetString = "\(firstInfo)\n\(secondInfo)"
        return snippetString
    }
}
