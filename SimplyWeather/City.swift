//
//  City.swift
//  SimplyWeather
//
//  Created by Kimberly Skipper on 12/14/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

import Foundation
import CoreLocation

class City
{
    let latitude: Double
    let longitude: Double
    var cityName: String
    var stateName: String
    let zipCode: String
    

    init(latitude: Double, longitude: Double, cityName: String, stateName: String, zipCode: String)
    {
        self.latitude = latitude
        self.longitude = longitude
        self.cityName = cityName
        self.stateName = stateName
        self.zipCode = zipCode
    }
    
}
