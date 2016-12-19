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
        //referencing the delegate
        self.delegate = delegate
    }
    
    //creating a function to search DarkSky for weather data in the form of a dictionary.
    func searchDarkSkyFor(aCity: City)
    {
        var weather = [Weather]()
        
        let urlPath = "https://api.darksky.net/forecast/(add-Dark-Sky-API-Key-here)/\(aCity.latitude),\(aCity.longitude)"
        let url = URL(string: urlPath)
        let session = URLSession.shared
        let task = session.dataTask(with: url!, completionHandler: {data, response, error -> Void in
            print("Task completed")
            if error != nil
            {
                // will print error based on language most commomly spoken in that area.
                print(error!.localizedDescription)
            }
            if let mainDictionary = self.parseJSON(data!)
            {

                if let moreWeatherInfo = mainDictionary["daily"] as? [String:Any]
                {
                    if let secondictionary = moreWeatherInfo["data"] as? [Any]
                    {
                        //build my arrays of weather data
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
                //set these properties as the first element of the weather array.  because that are not part of the weather array for the dailys
                if let weatherInfo = mainDictionary["currently"] as? [String: Any]
                {
                    let currentTemp = weatherInfo["temperature"] as? Double
                    let apparentTemp = weatherInfo["apparentTemperature"] as? Double
                    weather[0].apparentTemp = apparentTemp!
                    weather[0].currentTemp = currentTemp!
                    
                                    
                }
                // this is where we are telling the UI that the weather data was recieved.
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
