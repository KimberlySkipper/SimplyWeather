//
//  Weather.swift
//  SimplyWeather
//
//  Created by Kimberly Skipper on 12/14/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

import Foundation

struct Weather
{
    let currentTemp: Double
    let apparentTemp: Double
    let tempMax: Double
    let tempMin: Double
    let icon: String
    let precipProb: Double
    
    init(_ temp: Double, _ apparentTemp: Double, _ maxTemp: Double, _ minTemp: Double, _ icon: String, _ chanceOfRain: Double)
    {
        self.currentTemp = temp
        self.apparentTemp = apparentTemp
        self.tempMax = maxTemp
        self.tempMin = minTemp
        self.icon = icon
        self.precipProb = chanceOfRain
    }
}
