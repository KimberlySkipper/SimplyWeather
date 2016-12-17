//
//  ViewController.swift
//  SimplyWeather
//
//  Created by Kimberly Skipper on 12/14/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

import UIKit
import CoreLocation
import Foundation

class WeatherViewController: UIViewController, DarkSkyAPIControllerProtocol, CLLocationManagerDelegate
{

    var api: DarkSkyAPIController!
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var apparentTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var precipProbLabel: UILabel!
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        api = DarkSkyAPIController(delegate: self)
        configureLocationManager()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didRecieveWeatherData(weatherData: [Weather])
    {
        currentTempLabel.text = weatherData[0].currentTempAsString()
        apparentTempLabel.text = weatherData[0].apparentTempAsString()
        minTempLabel.text = weatherData[0].minTempAsString()
        maxTempLabel.text = weatherData[0].maxTempAsString()
        precipProbLabel.text = weatherData[0].precipProbAsString()
    }
    func configureLocationManager()
    {
        let status = CLLocationManager.authorizationStatus()
        if status != .denied && status != .restricted
        {
            //we are conforming to the protocol.
            locationManager.delegate = self
            //least accuracte for least battery drain
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            //have not asked for permission yey
            if status == .notDetermined
            {
                // I only need info when the app is in the forground
                locationManager.requestWhenInUseAuthorization()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        if status == .authorizedWhenInUse
        {
            locationManager.startUpdatingLocation()
        }
        else
        {
            print("Location access denied")
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let city = City(latitude: Double((locations.last?.coordinate.latitude)!) , longitude: Double((locations.last?.coordinate.longitude)!))
        api.searchDarkSkyFor(aCity: city)
        locationManager.stopUpdatingLocation()
        
        
    }
    



}

