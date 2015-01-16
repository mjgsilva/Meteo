//
//  CurrentWeather.swift
//  Meteo
//
//  Created by Mário Silva on 12/12/14.
//  Copyright (c) 2014 Mário Silva. All rights reserved.
//

import Foundation
import UIKit

struct CurrentWeather {
    var time: Int
    var temperature: Int
    var humidity: Double
    var windSpeed: Double
    var precipProbability: Double
    var summary: String
    var icon: String
    
    init(time: Int, temperature: Int, humidity: Double, windSpeed: Double, precipProbability: Double, summary: String, icon: String) {
        self.time = time
        self.temperature = temperature
        self.humidity = humidity
        self.windSpeed = windSpeed
        self.precipProbability = precipProbability
        self.summary = summary
        self.icon = icon
    }
    
    func getDate() -> String {
        let unixtime = NSTimeInterval(time)
        let date = NSDate(timeIntervalSince1970: unixtime)
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .MediumStyle
        return dateFormatter.stringFromDate(date)
    }
    
    func getIcon() -> UIImage {
        return UIImage(named: icon)!
    }
}