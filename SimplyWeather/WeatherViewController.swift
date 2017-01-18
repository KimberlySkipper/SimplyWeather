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

protocol CityInNavBarDelegate
{
    func cityNameWasAssigned(aCity: City)
}

class WeatherViewController: UIViewController, DarkSkyAPIControllerProtocol, CLLocationManagerDelegate, CityInNavBarDelegate
{
    @IBOutlet weak var icon1: SKYIconView!
    @IBOutlet weak var icon2: SKYIconView!
    @IBOutlet weak var icon3: SKYIconView!
    @IBOutlet weak var icon4: SKYIconView!
    @IBOutlet weak var icon5: SKYIconView!
    
    var api: DarkSkyAPIController!
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
   // let iconView1 = SKYIconView(frame: CGRect(x: 8, y: 515, width: 60, height: 60))
   // let iconView2 = SKYIconView(frame: CGRect(x: 86, y: 515, width: 60, height: 60))
    //let iconView3 = SKYIconView(frame: CGRect(x: 161, y: 515, width: 60, height: 60))
    //let iconView4 = SKYIconView(frame: CGRect(x: 237, y: 515, width: 60, height: 60))
    //let iconView5 = SKYIconView(frame: CGRect(x: 306, y: 515, width: 60, height: 60))
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
       // self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(goToSearchPage)), animated: true)
        
        icon1.setColor = UIColor.black
        icon1.backgroundColor = UIColor.white
        icon1.play()
        icon2.setColor = UIColor.black
        icon2.backgroundColor = UIColor.white
        icon2.play()
        icon3.setColor = UIColor.black
        icon3.backgroundColor = UIColor.white
        icon3.play()
        icon4.setColor = UIColor.black
        icon4.backgroundColor = UIColor.white
        icon4.play()
        icon5.setColor = UIColor.black
        icon5.backgroundColor = UIColor.white
        icon5.play()
        //self.view.addSubview(icon1)
        //self.view.addSubview(iconView2)
        //self.view.addSubview(iconView3)
        //self.view.addSubview(iconView4)
        //self.view.addSubview(iconView5)

        configureLocationManager()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    

    override func didReceiveMemoryWarning()
    {
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
            self.icon1.setType = weatherData[1].iconType
            self.icon2.setType = weatherData[2].iconType
            self.icon3.setType = weatherData[3].iconType
            self.icon4.setType = weatherData[4].iconType
            self.icon5.setType = weatherData[5].iconType
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
//    @IBAction func goToSearchPage (_ sender: UIBarButtonItem)
//    {
//        let nameVC = nameViewController()
//
//        newVC.delegate = self
//
//        self.navigationController?.pushViewController(nameFriendVC, animated: true)
//    }
    
    func cityNameWasAssigned(aCity: City)
    {
        self.title = "\(aCity.cityName), \(aCity.stateName)"
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
        
        let city = City(latitude: Double((locations.last?.coordinate.latitude)!) , longitude: Double((locations.last?.coordinate.longitude)!),
                        cityName: "", stateName: "", zipCode: "")
        api.searchDarkSkyFor(aCity: city)
        locationManager.stopUpdatingLocation()
        
        CLGeocoder().reverseGeocodeLocation((locations.last)!,  completionHandler: {
        placemark, error in
            
            if error != nil
            {
                print(error?.localizedDescription ?? "Could not reverse geocode location.")
            }
            else
            {
                city.stateName = (placemark?.last?.administrativeArea)!
                city.cityName = (placemark?.last?.locality)!
                self.cityNameWasAssigned(aCity: city)
                
            }
                
                

        })
    }
    
}//end class
