//
//  NetworkHandler.swift
//  Meteo
//
//  Created by Mário Silva on 12/12/14.
//  Copyright (c) 2014 Mário Silva. All rights reserved.
//

import Foundation

/* Class variables are not supported yet */
private let apiURL = "https://api.forecast.io/forecast"
private let apiKey = "6b97539665ae44664487823d01995d86"

class NetworkHandler {
    
    class func getWeatherReport(#latitude: String, longitude: String, completion:(data: NSData?, error: NSError?) -> Void) {
        let url = NSURL(string: "\(apiURL)/\(apiKey)/\(latitude),\(longitude)?units=si")

        var session = NSURLSession.sharedSession()
        
        let dataTask = session.dataTaskWithURL(url!, completionHandler: { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            if let responseError = error {
                var statusError = NSError(domain: apiURL, code: responseError.code, userInfo: [NSLocalizedDescriptionKey: "The operation couldn’t be completed"])
                completion(data: nil, error: statusError)
            } else if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    var statusError = NSError(domain: "api.forecast.io", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "HTTP status code has unexpected value"])
                    completion(data: nil, error: statusError)
                } else {
                    completion(data: data, error: nil)
                }
            }
        })
        
        dataTask.resume()
    
    }
}