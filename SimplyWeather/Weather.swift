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
    var currentTemp: Double
    var apparentTemp: Double
    let tempMax: Double
    let tempMin: Double
    let iconString: String
    let precipProb: Double
    let iconType: Skycons
        
    init(_ temp: Double, _ apparentTemp: Double, _ maxTemp: Double, _ minTemp: Double, _ iconString: String, _ chanceOfRain: Double)
    {
        self.currentTemp = temp
        self.apparentTemp = apparentTemp
        self.tempMax = maxTemp
        self.tempMin = minTemp
        self.iconString = iconString
        self.precipProb = chanceOfRain
      
        switch iconString
        {
        case "clearDay":
            self.iconType = Skycons.clearDay
        case "clearNight":
            self.iconType = Skycons.clearNight
        case "cloudy":
           self.iconType = Skycons.cloudy
        case "fog":
            self.iconType = Skycons.fog
        case "partlyCloudyDay":
            self.iconType = Skycons.partlyCloudyDay
        case "partlyCloudydyNight":
            self.iconType = Skycons.partlyCloudyNight
        case "rain":
            self.iconType = Skycons.rain
        case "sleet":
            self.iconType = Skycons.sleet
        case "snow":
            self.iconType = Skycons.snow
        case "wind":
            self.iconType = Skycons.wind
        default:
            self.iconType = Skycons.clearDay
        }
    }
    
    
    func currentTempAsString() -> String
    {
        //shift option 8 to add degree symbol
        return String(format: "%.0f°", currentTemp)
    }
    
    func apparentTempAsString() -> String
    {
        return String(format: "%.0f°", apparentTemp)
    }
    
    func minTempAsString() -> String
    {
        return String(format: "%.0f°", tempMin)
    }
    
    func maxTempAsString() -> String
    {
        return String(format: "%.0f°", tempMax)
    }
    
    func precipProbAsString() -> String
    {
        let percentPrecip = precipProb * 100
        return String(format: "%.0f%%", percentPrecip)
    }
    
}
