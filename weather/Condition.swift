//
//  Condition.swift
//  weather
//
//  Created by muu van duy on 2017/01/13.
//  Copyright © 2017 muuvanduy. All rights reserved.
//

import Foundation

enum ConditionFields: String {
    case id = "id"
    case coordinates = "coord"
    case weather = "weather"
    case base = "base"
    case main = "main"
    case visibility = "visibility"
    case wind = "wind"
    case clouds = "clouds"
    case date = "dt"
    case sys = "sys"
    case name = "name"
    case code = "cod"
}

enum CoordinateFields: String {
    case latitude = "lat"
    case longitude = "lon"
}

enum MainWeatherFields: String {
    case temperature = "temp"
    case pressure = "pressure"
    case humidity = "humidity"
    case tempMin = "temp_min"
    case tempMax = "temp_max"
}

enum SysFields: String {
    case id = "id"
    case type = "type"
    case message = "message"
    case country = "country"
    case sunrise = "sunrise"
    case sunset = "sunset"
}

enum WeatherFields: String {
    case id = "id"
    case main = "main"
    case description = "description"
    case icon = "icon"
}

enum WindFields: String {
    case windBearing = "deg"
    case windSpeed = "speed"
}

struct Coordinate {
    let latitude: Double
    let longitude: Double
}

struct MainWeather {
    let temperature: Double
    let pressure: Int
    let humidity: Int
    let tempMin: Double
    let tempMax: Double
}

struct Sys {
    let message: Double
    let country: String
    let sunrise: Double
    let sunset: Double
}

struct Weather {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Wind {
    let windBearing: Double
    let windSpeed: Double
}

struct Cloud {
    let all: Int
}

struct Condition {
    
    let coordinates: Coordinate
    let weather: [Weather]
    let base: String
    let main: MainWeather
    let wind: Wind
    let clouds: Cloud
    let date: Double
    let sys: Sys
    let id: Int
    let name: String
    let code: Int
    
    init(json: [String: Any]) throws {
        
        guard let coordinatesJSON = json[ConditionFields.coordinates.rawValue] as? [String: Double],
            let latitude = coordinatesJSON[CoordinateFields.latitude.rawValue],
            let longitude = coordinatesJSON[CoordinateFields.longitude.rawValue]
        else {
            throw SerializationError.missing(ConditionFields.coordinates.rawValue)
        }
        
        let coordinates = Coordinate(latitude: latitude, longitude: longitude)
        
        guard let weatherArray = json[ConditionFields.weather.rawValue] as? NSArray else {
            throw SerializationError.missing(ConditionFields.weather.rawValue)
        }
        
        var weather: [Weather] = []
        
        for val in weatherArray {
            guard let weatherJSON = val as? [String: Any],
                let id = weatherJSON[WeatherFields.id.rawValue],
                let main = weatherJSON[WeatherFields.main.rawValue],
                let description = weatherJSON[WeatherFields.description.rawValue],
                let icon = weatherJSON[WeatherFields.icon.rawValue]
                else {
                    throw SerializationError.invalid(ConditionFields.weather.rawValue, weatherArray)
            }
            
            let wea = Weather(id: id as! Int, main: main as! String, description: description as! String, icon: icon as! String)
            weather.append(wea)
        }
        
        guard let base = json[ConditionFields.base.rawValue] as? String else {
            throw SerializationError.missing(ConditionFields.base.rawValue)
        }

        guard let mainJSON = json[ConditionFields.main.rawValue] as? [String: Any],
            let temperature = mainJSON[MainWeatherFields.temperature.rawValue] as? Double,
            let pressure = mainJSON[MainWeatherFields.pressure.rawValue] as? Int,
            let humidity = mainJSON[MainWeatherFields.humidity.rawValue] as? Int,
            let tempMin = mainJSON[MainWeatherFields.tempMin.rawValue] as?  Double,
            let tempMax = mainJSON[MainWeatherFields.tempMax.rawValue] as? Double
        else {
            throw SerializationError.missing(ConditionFields.main.rawValue)
        }
        
        let main = MainWeather(temperature: temperature, pressure: pressure, humidity: humidity, tempMin: tempMin, tempMax: tempMax)
        
        guard let windJSON = json[ConditionFields.wind.rawValue] as? [String: Double],
            let windBearing = windJSON[WindFields.windBearing.rawValue],
            let windSpeed = windJSON[WindFields.windSpeed.rawValue]
        else {
            throw SerializationError.missing(ConditionFields.wind.rawValue)
        }
        
        let wind = Wind(windBearing: windBearing, windSpeed: windSpeed)
        
        guard let cloudsJSON = json[ConditionFields.clouds.rawValue] as? [String: Int],
            let clouds = cloudsJSON["all"]
        else {
            throw SerializationError.missing(ConditionFields.clouds.rawValue)
        }
        
        guard let date = json[ConditionFields.date.rawValue] as? Double else {
            throw SerializationError.missing(ConditionFields.date.rawValue)
        }
        
        guard let sysJSON = json[ConditionFields.sys.rawValue] as? [String: Any],
            let message = sysJSON[SysFields.message.rawValue] as? Double,
            let country = sysJSON[SysFields.country.rawValue] as? String,
            let sunrise = sysJSON[SysFields.sunrise.rawValue] as? Double,
            let sunset = sysJSON[SysFields.sunset.rawValue] as? Double
        else {
                throw SerializationError.missing(ConditionFields.sys.rawValue)
        }
        
        let sys = Sys(message: message, country: country, sunrise: sunrise, sunset: sunset)

        guard let id = json[ConditionFields.id.rawValue] as? Int else {
            throw SerializationError.missing(ConditionFields.id.rawValue)
        }
        
        guard let name = json[ConditionFields.name.rawValue] as? String else {
            throw SerializationError.missing(ConditionFields.name.rawValue)
        }
        
        guard let code = json[ConditionFields.code.rawValue] as? Int else {
            throw SerializationError.missing(ConditionFields.code.rawValue)
        }
        
        self.coordinates = coordinates
        self.weather = weather
        self.base = base
        self.main = main
        self.wind = wind
        self.clouds = Cloud(all: clouds)
        self.date = date
        self.sys = sys
        self.id = id
        self.name = name
        self.code = code
    }
}
