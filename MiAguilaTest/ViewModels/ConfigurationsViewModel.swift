//
//  ConfigurationsViewModel.swift
//  MiAguilaTest
//
//  Created by Ricardo Grajales Duque on 8/30/19.
//  Copyright © 2019 Ricardo Grajales Duque. All rights reserved.
//

import Foundation
import CoreLocation

public class ConfigurationsViewModel {
    
    private var configurations = Configurations.shared
    public var initialLogitudeString: String?
    public var initialLatitudeString: String?
    public var finalLogitudeString: String?
    public var finalLatitudeString: String?
    public var distanceStepsString: String?
    
    //MARK: - Constructor
    public init() {
        initialLogitudeString = getInitialLogitudeString()
        initialLatitudeString = getInitialLatitudeString()
        finalLogitudeString = getFinalLogitudeString()
        finalLatitudeString = getFinalLatitudeString()
        distanceStepsString = getDistanceStepsString()
    }

    //MARK: - Utility Functions
    private func getInitialLogitudeString() -> String {
        var initialLogitudeString = ""
        guard let longitude = configurations.initialLocation?.coordinate.longitude else {
            return initialLogitudeString
        }
        initialLogitudeString = String(longitude)
        return initialLogitudeString
    }
    
    private func getInitialLatitudeString() -> String {
        var initialLatitudeString = ""
        guard let latitude = configurations.initialLocation?.coordinate.latitude else {
            return initialLatitudeString
        }
        initialLatitudeString = String(latitude)
        return initialLatitudeString
    }
    
    private func getFinalLogitudeString() -> String {
        var finalLogitudeString = ""
        guard let longitude = configurations.finalLocation?.coordinate.longitude else {
            return finalLogitudeString
        }
        finalLogitudeString = String(longitude)
        return finalLogitudeString
    }
    
    private func getFinalLatitudeString() -> String {
        var finalLatitudeString = ""
        guard let latitude = configurations.finalLocation?.coordinate.latitude else {
            return finalLatitudeString
        }
        finalLatitudeString = String(latitude)
        return finalLatitudeString
    }
    
    private func getDistanceStepsString() -> String {
        var distanceStepsString = ""
        guard let distance = configurations.distanceSteps else {
            return distanceStepsString
        }
        distanceStepsString = String(distance) + " m"
        return distanceStepsString
    }
    
    //MARK: - Updating Configurations
    func updateConfigurations(data: [AnyHashable: String]) throws {
        guard let initialLongitudeString = data[DictionaryKeys.initialLongitude],
            let initialLatitudeString = data[DictionaryKeys.initialLatitude],
            let finalLongitudeString = data[DictionaryKeys.finalLongitude],
            let finalLatitudeString = data[DictionaryKeys.finalLatitude],
            let distanceStepsString = data[DictionaryKeys.distanceSteps] else {
            throw ConfigurationsError.UpdatingError
        }
        
        let initialLocation = getInitialLocation(latitudeString: initialLatitudeString, longitudeString: initialLongitudeString)
        let finalLocation = getFinalLocation(latitudeString: finalLatitudeString, longitudeString: finalLongitudeString)
        let distanceSteps = getDistanceSteps(distanceString: distanceStepsString)
        setConfigurationValues(initialLocation: initialLocation, finalLocation: finalLocation, distanceSteps: distanceSteps)
    }
    
    private func setConfigurationValues(initialLocation: CLLocation, finalLocation: CLLocation, distanceSteps: Double) {
        configurations.initialLocation = initialLocation
        configurations.finalLocation = finalLocation
        configurations.distanceSteps = distanceSteps
        saveConfigurationDataInCache(initialLocation: initialLocation, finalLocation: finalLocation, distanceSteps: distanceSteps)
    }
    
    private func saveConfigurationDataInCache(initialLocation: CLLocation, finalLocation: CLLocation, distanceSteps: Double) {
        UserDefaults.standard.set(initialLocation.coordinate.latitude, forKey: DictionaryKeys.initialLatitude)
        UserDefaults.standard.set(initialLocation.coordinate.longitude, forKey: DictionaryKeys.initialLongitude)
        UserDefaults.standard.set(finalLocation.coordinate.latitude, forKey: DictionaryKeys.finalLatitude)
        UserDefaults.standard.set(finalLocation.coordinate.longitude, forKey: DictionaryKeys.finalLongitude)
        UserDefaults.standard.set(distanceSteps, forKey: DictionaryKeys.distanceSteps)
        UserDefaults.standard.set(nil, forKey: DictionaryKeys.route)
        UserDefaults.standard.synchronize()
    }
    
    private func getInitialLocation(latitudeString: String, longitudeString: String) -> CLLocation {
        var initialLocation = CLLocation()
        let latitudeDegrees = CLLocationDegrees(floatLiteral: Double(latitudeString) ?? 0.0)
        let longitudeDegrees = CLLocationDegrees(floatLiteral: Double(longitudeString) ?? 0.0)
        initialLocation = CLLocation(latitude: latitudeDegrees, longitude: longitudeDegrees)
        
        return initialLocation
    }
    
    private func getFinalLocation(latitudeString: String, longitudeString: String) -> CLLocation {
        var finalLocation = CLLocation()
        let latitudeDegrees = CLLocationDegrees(floatLiteral: Double(latitudeString) ?? 0.0)
        let longitudeDegrees = CLLocationDegrees(floatLiteral: Double(longitudeString) ?? 0.0)
        finalLocation = CLLocation(latitude: latitudeDegrees, longitude: longitudeDegrees)
        
        return finalLocation
    }
    
    private func getDistanceSteps(distanceString: String) -> Double {
        var distanceSteps = 0.0
        distanceSteps = Double(distanceString) ?? 0.0
        return distanceSteps
    }
}

private extension ConfigurationsViewModel {
    struct DictionaryKeys {
        static let initialLongitude = "initialLongitude"
        static let initialLatitude = "initialLatitude"
        static let finalLongitude = "finalLongitude"
        static let finalLatitude = "finalLatitude"
        static let distanceSteps = "distanceSteps"
        static let route = "route"
    }
    
    enum ConfigurationsError: Error {
        case UpdatingError
        case unknown
    }
}
