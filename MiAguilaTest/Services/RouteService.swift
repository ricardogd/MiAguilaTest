//
//  RouteService.swift
//  MiAguilaTest
//
//  Created by Ricardo Grajales Duque on 8/30/19.
//  Copyright © 2019 Ricardo Grajales Duque. All rights reserved.
//

import Foundation

public class RouteService {
    
    public func loadRoute(urlString: String, completion: @escaping (String) -> ()) {
        
        guard let routeURL = URL(string: urlString) else {
            print("Error URL")
            return
        }
        let sessionConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: sessionConfiguration)
        
        let task = urlSession.dataTask(with: routeURL) { (data, respons, error) in
            
            do {
                guard let data = data,
                    let jsonData =  try JSONSerialization.jsonObject(with: data, options: []) as? [AnyHashable: Any] else {
                        print("Error JSON")
                        return
                }
                
                guard let routesArray = jsonData["routes"] as? [Any],
                    let routeDictionary = routesArray[0] as? [AnyHashable: Any],
                    let polyLineDictionary = routeDictionary["overview_polyline"] as? [AnyHashable: Any],
                    let points = polyLineDictionary["points"] as? String
                    else {
                        print("Error Routes")
                        return
                }
                
                DispatchQueue.main.async {
                    completion(points)
                }
            }
            catch {
                print("Request Error")
                return
            }
        }
        task.resume()
    }
}
