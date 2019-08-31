//
//  RouteViewModel.swift
//  MiAguilaTest
//
//  Created by Ricardo Grajales Duque on 8/30/19.
//  Copyright © 2019 Ricardo Grajales Duque. All rights reserved.
//

import Foundation
import GoogleMaps

public class RouteViewModel {
    
    public var polyline = GMSPolyline()
    private var routeService: RouteService?
    
    public init() {
        routeService = RouteService()
        let route = RouteModel()
        if !route.isCacheAvailable {
            updateRouteFromService(urlString: route.routeURLString)
        }
        else {
            initFromCachedRoute(route: route)
        }
    }
    
    private func initFromCachedRoute(route: RouteModel) {
        polyline = getPoylineFrom(pointsString: route.polylineString)
    }
    
    
    private func updateRouteFromService(urlString: String) {
        routeService?.loadRoute(urlString: urlString, completion: { (routeString) in
            DispatchQueue.main.async {
                self.polyline = self.getPoylineFrom(pointsString: routeString)
            }
            self.saveRouteInCache(routeString: routeString)
        })
    }
    
    private func saveRouteInCache(routeString: String) {
        UserDefaults.standard.set(routeString, forKey: DictionaryKeys.route)
        UserDefaults.standard.synchronize()
    }
    
    private func getPoylineFrom(pointsString: String) -> GMSPolyline {
        var polyline = GMSPolyline()
        let routePath = GMSPath(fromEncodedPath: pointsString)
        polyline = GMSPolyline(path: routePath)
        polyline.strokeWidth = 2
        polyline.strokeColor = .red
        
        return polyline
    }
}

private extension RouteViewModel {
    struct DictionaryKeys {
        static let route = "route"
    }
}
