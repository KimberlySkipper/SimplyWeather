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
    var delegate: DarkSkyAPIControllerProtocol
    init(delegate: DarkSkyAPIControllerProtocol)
    {
        self.delegate = delegate
    }
    
    //creating a function to search DarkSky for weather data in the form of a dictionary.
    func searchDarkSkyFor(aCity: City)
    {
        var weather = [Weather]()
        
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

                if let moreWeatherInfo = mainDictionary["daily"] as? [String:Any]
                {
                    if let secondictionary = moreWeatherInfo["data"] as? [Any]
                    {
                        for dailyData in secondictionary
                        {
                            if let dailyDataAsDictionary = dailyData as? [String: Any]
                            {
                                let icon = dailyDataAsDictionary["icon"] as? String
                                let precipProb = dailyDataAsDictionary["precipProbability"] as? Double
                                let minTemp = dailyDataAsDictionary["temperatureMin"] as? Double
                                let maxTemp = dailyDataAsDictionary["temperatureMax"] as? Double
                                weather.append(Weather(0, 0, maxTemp!, minTemp!, icon!, precipProb!))
                            }
                        }
                    }
                
                
                }
                if let weatherInfo = mainDictionary["currently"] as? [String: Any]
                {
                    let currentTemp = weatherInfo["temperature"] as? Double
                    let apparentTemp = weatherInfo["apparentTemperature"] as? Double
                    //set these properties as the first element of the weather array
                    weather[0].apparentTemp = apparentTemp!
                    weather[0].currentTemp = currentTemp!
                    //weather.append(Weather(currentTemp!, apparentTemp!, 80, 80, "", 80))
                                    
                                }
              self.delegate.didRecieveWeatherData(weatherData: weather)
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
