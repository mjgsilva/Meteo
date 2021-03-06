//
//  ViewController.swift
//  Meteo
//
//  Created by Mário Silva on 12/12/14.
//  Copyright (c) 2014 Mário Silva. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var updateActivityIndicator: UIActivityIndicatorView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startUpdateAnimation()
        getMyLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func update() {
        startUpdateAnimation()
        getMyLocation()
    }
    
    func getMyLocation() -> Void {
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        } else {
            showErrorNotification("Location service disabled")
            stopUpdateAnimation()
        }
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) -> Void {
        showErrorNotification("Error retrieving your location")
        locationManager.stopUpdatingLocation()
        stopUpdateAnimation()
    }
    
   func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) -> Void {
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error)->Void in
            
            if error != nil {
                self.showErrorNotification("Error retrieving GPS coordinates")
            } else {
                if placemarks.count > 0 {
                    let pm = placemarks[0] as CLPlacemark
                    self.assignLocationToLabel(pm.locality)
                    self.networkRequest(manager.location.coordinate.latitude.description,longitude: manager.location.coordinate.longitude.description)
                } else {
                    self.showErrorNotification("GPS data corrupted")
                }
            }
            
            self.locationManager.stopUpdatingLocation()
            self.stopUpdateAnimation()
        })
    }
    
    func networkRequest(latitude: String, longitude: String) -> Void {
        NetworkHandler.getWeatherReport(latitude: latitude, longitude: longitude,completion: { (data: NSData?, error: NSError?) -> Void in
            if error != nil {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.showErrorNotification(error!.localizedDescription)
                    self.stopUpdateAnimation()
                })
            } else {
                let currentWeather = self.jsonToObject(data!)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.assignDataToLabels(currentWeather)
                    self.stopUpdateAnimation()
                })
            }
        })
    }
    
    func assignLocationToLabel(location: String) -> Void {
        locationLabel.text = location
    }
    
    func assignDataToLabels(currentWeather: CurrentWeather) -> Void {
        iconView.image = currentWeather.getIcon()
        currentTimeLabel.text = currentWeather.getDate()
        temperatureLabel.text = "\(currentWeather.temperature)"
        humidityLabel.text = "\(currentWeather.humidity)"
        windLabel.text = "\(currentWeather.windSpeed)"
        summaryLabel.text = currentWeather.summary
    }
    
    func jsonToObject(weatherData: NSData) -> CurrentWeather {
        let json = JSON(data: weatherData)

        let weather = json["currently"]
        let time: Int = weather["time"].intValue
        let temperature: Int = weather["temperature"].intValue
        let humidity: Double = weather["humidity"].doubleValue
        let windSpeed: Double = weather["windSpeed"].doubleValue
        let summary: String = weather["summary"].stringValue
        let icon: String = weather["icon"].stringValue

        return CurrentWeather(time: time, temperature: temperature, humidity: humidity, windSpeed: windSpeed, summary: summary, icon: icon)
    }

    func showErrorNotification(errorMessage: String) -> Void {
        let notification = CWStatusBarNotification()
        notification.notificationLabelBackgroundColor = UIColor.redColor()
        notification.notificationLabelTextColor = UIColor.whiteColor()
        notification.notificationStyle = .NavigationBarNotification
        notification.displayNotificationWithMessage(errorMessage, duration: 2.0)
    }
    
    func startUpdateAnimation() -> Void {
        updateButton.hidden = true
        updateActivityIndicator.hidden = false
        updateActivityIndicator.startAnimating()
    }
    
    func stopUpdateAnimation() -> Void {
        updateButton.hidden = false
        updateActivityIndicator.hidden = true
        updateActivityIndicator.stopAnimating()
    }
    
}

