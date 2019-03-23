//
//  CityModel.swift
//  CoreDataTask
//
//  Created by Snehal Garbhe on 3/21/19.
//  Copyright © 2019 Snehal Garbhe. All rights reserved.
//

import Foundation

enum City {
    case sydney
    case melbourne
    case brisbane
}

struct  CityModel: RequestURN {
    
    var cityName : City = .sydney
    
    var urn: String {
        switch cityName {
        case .sydney:
            return APIConst.weatherKey+APIKeyConst.sydneyWeatherKey+APIConst.endPoint+APIKeyConst.apiKey
        case .melbourne:
            return APIConst.weatherKey+APIKeyConst.melbourneWeatherKey+APIConst.endPoint+APIKeyConst.apiKey
        case .brisbane:
            return APIConst.weatherKey+APIKeyConst.brisbaneWeatherKey+APIConst.endPoint+APIKeyConst.apiKey
        }
        
    }
    
}
//http://api.openweathermap.org/data/2.5/weather?q=Sydney&appid=a914cf760f1d8f89b23c86574256ac26

class CityModelResponse: Mappable {
    
    
    var name : String?
    var main : CityMainModelResponse?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        
        name <- map["name"]
        main <- map["main"]
        
    }
    
    
}


class CityMainModelResponse : Mappable {
    
    var temp : Int32?
    var pressure : Int32?
    var humidity : Int32?
    var temp_min : Int32?
    var temp_max : Int32?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        temp <- map["temp"]
        pressure <- map["pressure"]
        humidity <- map["humidity"]
        temp_min <- map["temp_min"]
        temp_max <- map["temp_max"]
    }
    
    
}

/*
{
    "coord": {
        "lon": -80.61,
        "lat": 28.08
    },
    "weather": [
    {
    "id": 804,
    "main": "Clouds",
    "description": "overcast clouds",
    "icon": "04n"
    }
    ],
    "base": "stations",
    "main": {
        "temp": 288.95,
        "pressure": 1017,
        "humidity": 68,
        "temp_min": 286.48,
        "temp_max": 291.48
    },
    "visibility": 16093,
    "wind": {
        "speed": 4.1,
        "deg": 350
    },
    "clouds": {
        "all": 90
    },
    "dt": 1553151981,
    "sys": {
        "type": 1,
        "id": 4922,
        "message": 0.0169,
        "country": "US",
        "sunrise": 1553167525,
        "sunset": 1553211232
    },
    "id": 4163971,
    "name": "Melbourne",
    "cod": 200
} */
