//
//  ViewController.swift
//  SimplyWeather
//
//  Created by Kimberly Skipper on 12/14/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, DarkSkyAPIControllerProtocol
{

    var api: DarkSkyAPIController!
    
    @IBOutlet weak var currentTempLabel: UILabel!

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        api = DarkSkyAPIController(delegate: self)
        let locationManager = WeatherLocationManager()
        let city = locationManager.findCoordinates()
        api.searchDarkSkyFor(aCity: city)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didRecieveWeatherData(weatherData: [Weather])
    {
        currentTempLabel.text = weatherData[0].currentTempAsString()
    }


}

