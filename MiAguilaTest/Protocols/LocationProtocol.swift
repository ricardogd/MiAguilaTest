//
//  LocationProtocol.swift
//  MiAguilaTest
//
//  Created by Ricardo Grajales Duque on 8/30/19.
//  Copyright © 2019 Ricardo Grajales Duque. All rights reserved.
//

import Foundation
import CoreLocation

public protocol LocationProtocol {
    var coodinate: CLLocationCoordinate2D? { get }
}
