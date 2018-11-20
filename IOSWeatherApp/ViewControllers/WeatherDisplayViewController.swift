//
//  WeatherDisplayViewController.swift
//  IOSWeatherApp
//
//  Created by Miranda Jessie on 11/14/18.
//  Copyright © 2018 Miranda Jessie. All rights reserved.
//

import UIKit
import SwiftyJSON

class WeatherDisplayViewController: UIViewController {
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    
    var displayWeatherData: WeatherData! {
        didSet {
            iconLabel.text = displayWeatherData.condition.icon
            currentTempLabel.text = "\(displayWeatherData.temperature)°"
            highTempLabel.text = "\(displayWeatherData.highTemperature)°"
            lowTempLabel.text = "\(displayWeatherData.lowTemperature)°"
            
        }
    }
    var displayGeocodingData: geocodingData! {
        didSet {
            locationLabel.text = displayGeocodingData.formattedAddress 
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    func setupDefaultUI() {
        locationLabel.text = ""
        iconLabel.text = "👍🏻"
        currentTempLabel.text = "Enter a location"
        highTempLabel.text = "-"
        lowTempLabel.text = "-"
    }
    
    @IBAction func unwindToWeatherSegue(segue: UIStoryboardSegue) {}
    
}
