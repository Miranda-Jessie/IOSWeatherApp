//
//  geocodingData.swift
//  IOSWeatherApp
//
//  Created by Miranda Jessie on 11/19/18.
//  Copyright © 2018 Miranda Jessie. All rights reserved.
//

import Foundation
import SwiftyJSON

class geocodingData {
    enum geocodingKeys: String {
        case results = "results"
        case formattedAddress = "formatted_address"
        case geometry = "geometry"
        case location = "location"
        case latitude = "lat"
        case longitude = "lng"
    }
    var formattedAddress: String
    var latitude: Double
    var longitude: Double
    
    init(formattedAddress: String, latitude: Double, longitude: Double) {
        self.formattedAddress = formattedAddress
        self.latitude = latitude
        self.longitude = longitude
    }
    convenience init?(json: JSON) {
        guard let results = json[geocodingKeys.results.rawValue].array,
            results.count > 0 else {
                print("Can not get results")
                return nil
        }
        guard let formattedAddress = results[0][geocodingKeys.formattedAddress.rawValue].string
            else {
                print("Can not get address")
                return nil
        }
        guard let latitude = results[0][geocodingKeys.geometry.rawValue][geocodingKeys.location.rawValue][geocodingKeys.latitude.rawValue].double
            else {
                print("Can not get latitude")
                return nil
        }
        guard let longitude = results[0][geocodingKeys.geometry.rawValue][geocodingKeys.location.rawValue][geocodingKeys.longitude.rawValue].double
            else {
                print("Can not get longitude")
                return nil
        }
        self.init(formattedAddress: formattedAddress, latitude: latitude, longitude: longitude)
    }
}
