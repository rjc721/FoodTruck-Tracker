//
//  FoodTruck.swift
//  FoodTruck Tracker
//
//  Created by Ryan Chingway on 8/3/18.
//  Copyright © 2018 Ryan Chingway. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class FoodTruck: NSObject, MKAnnotation, Decodable {
    
    var id = ""
    var name = ""
    var foodType = ""
    var avgCost = 0.0
    var geomType = "Point"
    var lat = 0.0
    var long = 0.0
    
    var title: String?
    var subtitle: String?
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.lat, longitude: self.long)
    }
    
    static func parseFoodTruckJSONData(data: Data) -> [FoodTruck] {
        
        var foodtrucks = [FoodTruck]()
        
//        do {
//            let trucks = try JSONDecoder().decode([FoodTruck].self, from: data)
//
//
//
//        } catch let jsonErr {
//            fatalError("FoodTruck JSON Decode Error: \(jsonErr)")
//        }
        
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            //Parse JSON data
            if let trucks = jsonResult as? [Dictionary<String, AnyObject>] {
                for truck in trucks {
                    
                    let newTruck = FoodTruck()
                    newTruck.id = truck["id"] as! String
                    newTruck.name = truck["name"] as! String
                    newTruck.foodType = truck["foodtype"] as! String
                    newTruck.avgCost = truck["avgcost"] as! Double
                    
                    let geometry = truck["geometry"] as! Dictionary<String, AnyObject>
                    newTruck.geomType = geometry["type"] as! String
                    
                    let coords = geometry["coordinates"] as! Dictionary<String, AnyObject>
                    newTruck.lat = coords["lat"] as! Double
                    newTruck.long = coords["long"] as! Double
                    
                    newTruck.title = newTruck.name
                    newTruck.subtitle = newTruck.foodType
                    
                    foodtrucks.append(newTruck)
                }
            }
            
        } catch let err {
            print(err)
        }
        
        return foodtrucks
    }
}
