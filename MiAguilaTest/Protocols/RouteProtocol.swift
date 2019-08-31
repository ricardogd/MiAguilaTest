//
//  RouteProtocol.swift
//  MiAguilaTest
//
//  Created by Ricardo Grajales Duque on 8/30/19.
//  Copyright © 2019 Ricardo Grajales Duque. All rights reserved.
//

import Foundation

public protocol RouteProtocol {
    var speed: Double? { get }
    var time: Date? { get }
    var distance: Double? { get }
}
