//
//  File.swift
//  SimplyWeather
//
//  Created by Kimberly Skipper on 12/14/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherLocationManager
{
    
    //takes in nothing and returns a city object.
    func findCoordinates() -> City
    {
        //fake city need to get correct corrdinated for location
        let city = City(latitude: 27.770068, longitude: -82.63642)
        return city
    }
    
}
