//
//  Weather Data.swift
//  IOSWeatherApp
//
//  Created by Miranda Jessie on 11/16/18.
//  Copyright © 2018 Miranda Jessie. All rights reserved.
//

import Foundation
import SwiftyJSON

class WeatherData {
    enum Condition: String {
        case clearDay = "clear-day"
        case clearNight = "clear-night"
        case rain = "rain"
        case thunderStorm = "thunder-storm"
        case snow = "snow"
        case sleet = "sleet"
        case wind = "wind"
        case fog = "fog"
        case cloudy = "cloudy"
        case partlyCloudyDay = "partly-cloudy-day"
        case partlyCloudyNight = "partly-cloudy-night"
        case tornado = "tornado"
        case lightning = "lightning"
        case wildfire = "wildfire"
        
        //Computed property that selects a emoji based on the value of our condition
        var icon: String {
            switch self {
            case .clearDay:
                return "☀️"
            case .clearNight:
                return "✨"
            case .rain:
                return "☔️"
            case .thunderStorm:
                return "⛈"
            case .snow:
                return "☃️"
            case .sleet:
                return "🌧"
            case .wind:
                return "💨"
            case .fog:
                return "🌫"
            case .cloudy:
                return "🌥"
            case .partlyCloudyDay:
                return "⛅️"
            case .partlyCloudyNight:
                return "🌓"
            case .tornado:
                return "🌪"
            case .wildfire:
                return "🔥"
            case .lightning:
                return "⚡️"
            }
        }
    }
    enum weatherDataKeys: String {
        case currently = "currently"
        case temperature = "temperature"
        case icon = "icon"
        case daily = "daily"
        case temperatureHigh = "temperatureHigh"
        case temperatureLow = "temperatureLow"
        case data = "data"
    }
    let temperature: Double
    let highTemperature: Double
    let lowTemperature: Double
    let condition: Condition
    
    //designated initializer
    init(temperature: Double, highTemperature: Double, lowTemperature: Double, condition: Condition) {
        self.temperature = temperature
        self.highTemperature = highTemperature
        self.lowTemperature = lowTemperature
        self.condition = condition
    }
    convenience init?(json: JSON) {
        guard let temperature = json[weatherDataKeys.currently.rawValue][weatherDataKeys.temperature.rawValue].double else {
            print("Could not find temperature")
            return nil
        }
        guard let highTemperature = json[weatherDataKeys.daily.rawValue][weatherDataKeys.data.rawValue][0][weatherDataKeys.temperatureHigh.rawValue].double else {
            print("Could not get high temperature")
            return nil
        }
        guard let lowTemperature = json[weatherDataKeys.daily.rawValue][weatherDataKeys.data.rawValue][0][weatherDataKeys.temperatureLow.rawValue].double else {
            print("Could not get low temperature")
            return nil
        }
        guard let conditionString = json[weatherDataKeys.currently.rawValue][weatherDataKeys.icon.rawValue].string else {
            print("Could not get condition")
            return nil
        }
        print(conditionString)
        
        guard let condition = Condition(rawValue: conditionString) else {
            print("Could not init condition")
            return nil
        }
        self.init(temperature: temperature, highTemperature: highTemperature, lowTemperature: lowTemperature, condition: condition)
    }
}
