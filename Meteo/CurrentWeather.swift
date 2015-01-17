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
    var summary: String
    var icon: String
    
    init(time: Int, temperature: Int, humidity: Double, windSpeed: Double, summary: String, icon: String) {
        self.time = time
        self.temperature = temperature
        self.humidity = humidity
        self.windSpeed = windSpeed
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
        return UIImage(named: getIconFileName())!
    }
    
    private func getIconFileName() -> String {
        switch icon {
            case "clear-day":
                return "clear-day"
            case "clear-night":
                return "clear-night"
            case "rain":
                return "rain"
            case "snow":
                return "snow"
            case "sleet":
                return "sleet"
            case "wind":
                return "wind"
            case "fog":
                return "fog"
            case "cloudy":
                return "cloudy"
            case "partly-cloudy-day":
                return "partly-cloudy"
            case "partly-cloudy-night":
                return "cloudy-night"
            default:
                return "default"
        }
    }
}