//
//  APIManager.swift
//  IOSWeatherApp
//
//  Created by Miranda Jessie on 11/14/18.
//  Copyright © 2018 Miranda Jessie. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

struct APIManager {
    
    enum APIErrors: Error {
        case noData
        case noResponse
        case invalidData
    }
    
    //Call darksky for weather at location
    static func getWeather(at location: Location, onComplete: @escaping (WeatherData?, Error?) -> Void) {
    let root = "https://api.darksky.net/forecast"
    let key = APIKeys.darkSkyAPI
    let url = "\(root)/\(key)/\(location.latitude),\(location.longitude)"
    
//    print(APIKeys.darkSkyAPI)
    
    Alamofire.request(url).responseJSON { response in
        switch response.result {
        case .success(let value):
           let json = JSON(value)
           if let weatherData = WeatherData(json: json){
            onComplete(weatherData, nil)
           } else {
                onComplete(nil, APIErrors.invalidData)
            }
        case .failure(let error):
            onComplete(nil, error)
            }
        }
    }
    func geocode(address: String, onCompletion: @escaping(geocodingData?, Error?) -> Void) {
        let googleURL = "https://maps.googleapis.com/maps/api/geocode/json?address="
        let url = googleURL + address + "&key=" + APIKeys.googlekey
        
        let request = Alamofire.request(url)
        
        request.responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let geocodingData = geocodingData(json: json) {
                    onCompletion(geocodingData, nil) }
                else {
                    onCompletion(nil, APIErrors.invalidData)
                }
                print(json)
            case .failure(let error):
                onCompletion(nil, error)
                
            }
        }
    }
    
    
}
