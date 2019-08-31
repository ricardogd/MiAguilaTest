//
//  Configurations.swift
//  MiAguilaTest
//
//  Created by Ricardo Grajales Duque on 8/30/19.
//  Copyright © 2019 Ricardo Grajales Duque. All rights reserved.
//

import Foundation
import CoreLocation

public class Configurations {
    
    public static let shared = Configurations()
    var initialLocation: CLLocation?
    var finalLocation: CLLocation?
    var distanceSteps: Double?
    
    //MARK: - Constructores
    private init() {
        if self.isCacheAvailable() {
            self.initFromCache()
        }
        else {
            self.initWithDefaultConfiguration()
        }
    }
    
    private func initFromCache() {
        guard let initialLongitude = UserDefaults.standard.object(forKey: DictionaryKeys.initialLongitude) as? CLLocationDegrees,
            let initialLatitude = UserDefaults.standard.object(forKey: DictionaryKeys.initialLatitude) as? CLLocationDegrees,
            let finalLongitude = UserDefaults.standard.object(forKey: DictionaryKeys.finalLongitude) as? CLLocationDegrees,
            let finalLatitude = UserDefaults.standard.object(forKey: DictionaryKeys.finalLatitude) as? CLLocationDegrees,
            let distanceSteps = UserDefaults.standard.object(forKey: DictionaryKeys.distanceSteps) as? Double else {
                return
        }
        self.initialLocation = CLLocation(latitude: initialLatitude, longitude: initialLongitude)
        self.finalLocation = CLLocation(latitude: finalLatitude, longitude: finalLongitude)
        self.distanceSteps = distanceSteps
    }
    
    private func initWithDefaultConfiguration() {
        initialLocation = CLLocation(latitude: Constants.originLatitud, longitude: Constants.originLongitud)
        finalLocation = CLLocation(latitude: Constants.destinationLatitud, longitude: Constants.destinationLongitud)
        distanceSteps = Constants.defaulDistanceSteps
    }
    
    //MARK: - Utility Functions
    private func isCacheAvailable() -> Bool {
        if UserDefaults.standard.object(forKey: DictionaryKeys.initialLongitude) != nil &&
            UserDefaults.standard.object(forKey: DictionaryKeys.initialLatitude) != nil &&
            UserDefaults.standard.object(forKey: DictionaryKeys.finalLongitude) != nil &&
            UserDefaults.standard.object(forKey: DictionaryKeys.finalLatitude) != nil &&
            UserDefaults.standard.object(forKey: DictionaryKeys.distanceSteps) != nil {
            return true
        }
        
        return false
    }
}

private extension Configurations {
    struct Constants {
        static let originLatitud = CLLocationDegrees(floatLiteral: 4.667426)
        static let originLongitud = CLLocationDegrees(floatLiteral: -74.056624)
        static let destinationLatitud = CLLocationDegrees(floatLiteral: 4.672655)
        static let destinationLongitud = CLLocationDegrees(floatLiteral: -74.054071)
        static let defaulDistanceSteps = 52.0
    }
    
    struct DictionaryKeys {
        static let initialLongitude = "initialLongitude"
        static let initialLatitude = "initialLatitude"
        static let finalLongitude = "finalLongitude"
        static let finalLatitude = "finalLatitude"
        static let distanceSteps = "distanceSteps"
    }
}
