//
//  Weather.swift
//  weather
//
//  Created by muu van duy on 2017/01/17.
//  Copyright © 2017 muuvanduy. All rights reserved.
//

import Foundation

enum ForecastFields: String {
    case date = "dt"
    case temperature = "temp"
    case pressure = "pressure"
    case humidity = "humidity"
    case weather = "weather"
    case windBeering = "deg"
    case windSpeed = "speed"
    case clouds = "clouds"
}

enum ForecastWrapperFields: String {
    case code = "cod"
    case city = "city"
    case message = "message"
    case numberOfRowData = "cnt"
    case list = "list"
}

enum TemperatureFields: String {
    case day = "day"
    case min = "min"
    case max = "max"
    case night = "night"
    case evening = "eve"
    case morning = "morn"
}

enum CityFields: String {
    case id = "id"
    case name = "name"
    case coordinate = "coord"
    case country = "country"
    case population = "population"
}

struct City {
    let id: Int
    let name: String
    let coordinate: Coordinate
    let country: String
    let population: Double
}

struct Temperature {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve: Double
    let morn: Double
}

struct Forecast {
    
    let date: Double
    let temperature: Temperature
    let pressure: Double
    let humidity: Int
    let weather: [Weather]
    let speed: Double
    let deg: Double
    let clouds: Int
    
    init(json: [String: Any]) throws {
        
        guard let date = json[ForecastFields.date.rawValue] as? Double else {
            throw SerializationError.missing(ForecastFields.date.rawValue)
        }
        
        guard let temperatureJSON = json[ForecastFields.temperature.rawValue] as? [String: Double],
            let day = temperatureJSON[TemperatureFields.day.rawValue],
            let min = temperatureJSON[TemperatureFields.min.rawValue],
            let max = temperatureJSON[TemperatureFields.max.rawValue],
            let night = temperatureJSON[TemperatureFields.night.rawValue],
            let eve = temperatureJSON[TemperatureFields.evening.rawValue],
            let morn = temperatureJSON[TemperatureFields.morning.rawValue]
        else {
            throw SerializationError.missing(ForecastFields.temperature.rawValue)
        }
        
        let temperature = Temperature(day: day, min: min, max: max, night: night, eve: eve, morn: morn)
        
        guard let pressure = json[ForecastFields.pressure.rawValue] as? Double else {
            throw SerializationError.missing(ForecastFields.pressure.rawValue)
        }
        
        guard let humidity = json[ForecastFields.humidity.rawValue] as? Int else {
            throw SerializationError.missing(ForecastFields.humidity.rawValue)
        }
        
        guard let weatherArray = json[ForecastFields.weather.rawValue] as? NSArray else {
            throw SerializationError.missing(ForecastFields.weather.rawValue)
        }
        
        var weathers: [Weather] = []
        
        for value in weatherArray {
            guard let weatherJSON = value as? [String: Any],
                let id = weatherJSON[WeatherFields.id.rawValue],
                let main = weatherJSON[WeatherFields.main.rawValue],
                let description = weatherJSON[WeatherFields.description.rawValue],
                let icon = weatherJSON[WeatherFields.icon.rawValue]
            else {
                throw SerializationError.invalid(ForecastFields.weather.rawValue, weatherArray)
            }
            
            
            let weather = Weather(id: id as! Int, main: main as! String, description: description as! String, icon: icon as! String)
            weathers.append(weather)
        }
        
        guard let speed = json[ForecastFields.windSpeed.rawValue] as? Double else {
            throw SerializationError.missing(ForecastFields.windSpeed.rawValue)
        }
        
        guard let deg = json[ForecastFields.windBeering.rawValue] as? Double else {
            throw SerializationError.missing(ForecastFields.windBeering.rawValue)
        }
        
        guard let clouds = json[ForecastFields.clouds.rawValue] as? Int else {
            throw SerializationError.missing(ForecastFields.clouds.rawValue)
        }
        
        self.date = date
        self.temperature = temperature
        self.pressure = pressure
        self.humidity = humidity
        self.weather = weathers
        self.speed = speed
        self.deg = deg
        self.clouds = clouds
    }
}

struct ForecastWrapper {
    
    let city: City
    let code: String
    let message: Double
    let cnt: Int
    let list: [Forecast]
    
    init(json: [String: Any]) throws {
        
        guard let cityJSON = json[ForecastWrapperFields.city.rawValue] as? [String: Any],
            let id = cityJSON[CityFields.id.rawValue],
            let name = cityJSON[CityFields.name.rawValue],
            let coordinateJSON = cityJSON[CityFields.coordinate.rawValue] as? [String: Double],
            let country = cityJSON[CityFields.country.rawValue],
            let population = cityJSON[CityFields.population.rawValue]
        else {
            throw SerializationError.missing(ForecastWrapperFields.city.rawValue)
        }
        
        let coordinate = Coordinate(latitude: coordinateJSON[CoordinateFields.latitude.rawValue]!, longitude: coordinateJSON[CoordinateFields.longitude.rawValue]!)
        
        let city = City(id: id as! Int, name: name as! String, coordinate: coordinate, country: country as! String, population: population as! Double)
        
        guard let code = json[ForecastWrapperFields.code.rawValue] as? String else {
            throw SerializationError.missing(ForecastWrapperFields.code.rawValue)
        }

        guard let message = json[ForecastWrapperFields.message.rawValue] as? Double else {
            throw SerializationError.missing(ForecastWrapperFields.message.rawValue)
        }
        
        guard let cnt = json[ForecastWrapperFields.numberOfRowData.rawValue] as? Int else {
            throw SerializationError.missing(ForecastWrapperFields.numberOfRowData.rawValue)
        }
        
        guard let resultArray = json[ForecastWrapperFields.list.rawValue] as? NSArray else {
            throw SerializationError.missing(ForecastWrapperFields.list.rawValue)
        }
        
        var list: [Forecast] = []
        
        for forecastJSON in resultArray {
            do {
                let forecast = try Forecast(json: forecastJSON as! [String : Any])
                list.append(forecast)
            } catch {
                throw SerializationError.invalid(ForecastWrapperFields.list.rawValue, resultArray)
            }
        }
        
        self.city = city
        self.code = code
        self.message = message
        self.cnt = cnt
        self.list = list
        
    }

}
