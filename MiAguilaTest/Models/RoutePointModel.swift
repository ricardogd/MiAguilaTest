//
//  RouteModel.swift
//  MiAguilaTest
//
//  Created by Ricardo Grajales Duque on 8/30/19.
//  Copyright © 2019 Ricardo Grajales Duque. All rights reserved.
//

import Foundation
import CoreLocation

public class RoutePointModel: LocationProtocol, RouteProtocol {
    public var coodinate: CLLocationCoordinate2D?
    public var speed: Double?
    public var time: Date?
    public var distance: Double?
    
    public init(location: CLLocation) {
        coodinate = location.coordinate
        speed = location.speed
        time = Date()
        distance = location.distance(from: Configurations.shared.initialLocation ?? CLLocation())
    }
}
