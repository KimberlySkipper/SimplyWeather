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
//        weather.append(Weather(77.7, 80, 82, 72,"rain",0.87))
//        weather.append(Weather(81.7, 80, 82, 72,"rain",0.87))
//        weather.append(Weather(90, 80, 82, 72,"rain",0.87))
//        weather.append(Weather(85, 80, 82, 72,"rain",0.87))
//        weather.append(Weather(60, 80, 82, 72,"rain",0.87))
//        weather.append(Weather(82, 80, 82, 72,"rain",0.87))
        let urlPath = "https://api.darksky.net/forecast/132557b00bf842d1a4174ede7cc30437/\(aCity.latitude),\(aCity.longitude)"
        let url = URL(string: urlPath)
        let session = URLSession.shared
        let task = session.dataTask(with: url!, completionHandler: {data, response, error -> Void in
            print("Task completed")
            if error != nil
            {
                // will print erroe based on language most commomly spoken in that area.
                print(error!.localizedDescription)
            }
            if let mainDictionary = self.parseJSON(data!)
            {
                if let weatherInfo = mainDictionary["currently"] as? [String: Any]
                {
                    if let currentTemp = weatherInfo["temperature"] as? Double
                    {
                    weather.append(Weather(currentTemp, 80, 80, 80, "", 80))
                    self.delegate.didRecieveWeatherData(weatherData: weather)
                    }
                }
            }
        })
        task.resume()
        
    }
    
    
    func parseJSON(_ data: Data) -> [String: Any]?
    {
        do
        {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let dictionary = json as? [String: Any]
            {
                return dictionary
            }
            else
            {
                return nil
            }
        }
        catch let error as NSError
        {
            print(error)
            return nil
        }
    }

}//end class
