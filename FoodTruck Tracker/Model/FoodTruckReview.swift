//
//  FoodTruckReview.swift
//  FoodTruck Tracker
//
//  Created by Ryan Chingway on 8/3/18.
//  Copyright © 2018 Ryan Chingway. All rights reserved.
//

import Foundation

struct FoodTruckReview {
    
    var id = ""
    var title = ""
    var text = ""
    
    static func parseReviewJSONData(data: Data) -> [FoodTruckReview] {
        
        var foodTruckReviews = [FoodTruckReview]()
        
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            //Parse JSON
            
            if let reviews = jsonResult as? [Dictionary<String, AnyObject>] {
                
                for review in reviews {
                    
                    var newReview = FoodTruckReview()
                    
                    newReview.id = review["_id"] as! String
                    newReview.title = review["title"] as! String
                    newReview.text = review["text"] as! String
                    
                    foodTruckReviews.append(newReview)
                }
            }
        } catch let err {
            print(err)
        }
        
        return foodTruckReviews
    }
}
