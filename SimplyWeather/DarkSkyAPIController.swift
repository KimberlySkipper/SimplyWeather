//
//  DarkSkyApiController.swift
//  SimplyWeather
//
//  Created by Kimberly Skipper on 12/14/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

import Foundation
protocol DarkSkyAPIControllerProtocol
{
    func didRecieveWeatherData(weatherData: [Weather])
}

class DarkSkyAPIController
{
    //how does this read?
    var delegate: DarkSkyAPIControllerProtocol
    
    init(delegate: DarkSkyAPIControllerProtocol)
    {
        self.delegate = delegate
    }
    //creating a function to search DarkSky for weather data in the form of a dictionary.
    func searchDarkSkyFor(aCity: City)
    {
        var weather = [Weather]()
        weather.append(Weather(77.7, 80, 82, 72,"rain",0.87))
        weather.append(Weather(81.7, 80, 82, 72,"rain",0.87))
        weather.append(Weather(90, 80, 82, 72,"rain",0.87))
        weather.append(Weather(85, 80, 82, 72,"rain",0.87))
        weather.append(Weather(60, 80, 82, 72,"rain",0.87))
        weather.append(Weather(82, 80, 82, 72,"rain",0.87))
        self.delegate.didRecieveWeatherData(weatherData: weather)
    }
}
