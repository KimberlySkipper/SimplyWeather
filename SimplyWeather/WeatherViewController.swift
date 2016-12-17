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
    let iconView1 = SKYIconView(frame: CGRect(x: 8, y: 522, width: 60, height: 60))
    let iconView2 = SKYIconView(frame: CGRect(x: 86, y: 522, width: 60, height: 60))
    let iconView3 = SKYIconView(frame: CGRect(x: 161, y: 522, width: 60, height: 60))
    let iconView4 = SKYIconView(frame: CGRect(x: 237, y: 522, width: 60, height: 60))
    let iconView5 = SKYIconView(frame: CGRect(x: 306, y: 522, width: 60, height: 60))
    
    
    
    
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var apparentTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var precipProbLabel: UILabel!
    @IBOutlet weak var day1MaxTempLabel: UILabel!
    @IBOutlet weak var day1MinTempLabel: UILabel!
    @IBOutlet weak var day2MaxTempLabel: UILabel!
    @IBOutlet weak var day2MinTempLabel: UILabel!
    @IBOutlet weak var day3MaxTempLabel: UILabel!
    @IBOutlet weak var day3MinTempLabel: UILabel!
    @IBOutlet weak var day4MaxTempLabel: UILabel!
    @IBOutlet weak var day4MinTempLabel: UILabel!
    @IBOutlet weak var day5MaxTempLabel: UILabel!
    @IBOutlet weak var day5MinTempLabel: UILabel!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        api = DarkSkyAPIController(delegate: self)
        configureLocationManager()
        
        iconView1.setColor = UIColor.black
        iconView1.backgroundColor = UIColor.white
        iconView2.setColor = UIColor.black
        iconView2.backgroundColor = UIColor.white
        iconView3.setColor = UIColor.black
        iconView3.backgroundColor = UIColor.white
        iconView4.setColor = UIColor.black
        iconView4.backgroundColor = UIColor.white
        iconView5.setColor = UIColor.black
        iconView5.backgroundColor = UIColor.white
        self.view.addSubview(iconView1)
        self.view.addSubview(iconView2)
        self.view.addSubview(iconView3)
        self.view.addSubview(iconView4)
        self.view.addSubview(iconView5)
        

        UIApplication.shared.isNetworkActivityIndicatorVisible = true
       
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func didRecieveWeatherData(weatherData: [Weather])
    {
        //loads data in labels faster.
        let queue = DispatchQueue.main
        queue.async
        {

            self.currentTempLabel.text = weatherData[0].currentTempAsString()
            self.apparentTempLabel.text = weatherData[0].apparentTempAsString()
            self.minTempLabel.text = weatherData[0].minTempAsString()
            self.maxTempLabel.text = weatherData[0].maxTempAsString()
            self.precipProbLabel.text = weatherData[0].precipProbAsString()
            self.day1MaxTempLabel.text = weatherData[1].maxTempAsString()
            self.day1MinTempLabel.text = weatherData[1].minTempAsString()
            self.day2MaxTempLabel.text = weatherData[2].maxTempAsString()
            self.day2MinTempLabel.text = weatherData[2].minTempAsString()
            self.day3MaxTempLabel.text = weatherData[3].maxTempAsString()
            self.day3MinTempLabel.text = weatherData[3].minTempAsString()
            self.day4MaxTempLabel.text = weatherData[4].maxTempAsString()
            self.day4MinTempLabel.text = weatherData[4].minTempAsString()
            self.day5MaxTempLabel.text = weatherData[5].maxTempAsString()
            self.day5MinTempLabel.text = weatherData[5].minTempAsString()

            self.iconView1.setType = weatherData[1].iconType
            self.iconView2.setType = weatherData[2].iconType
            self.iconView3.setType = weatherData[3].iconType
            self.iconView4.setType = weatherData[4].iconType
            self.iconView5.setType = weatherData[5].iconType
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }

        
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

