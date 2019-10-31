//
//  GenerateWeatherListHelper.swift
//  weather
//
//  Created by muu van duy on 2017/01/17.
//  Copyright © 2017 muuvanduy. All rights reserved.
//


import Foundation
import UIKit

struct WeatherListViewModel {
    
    let icon: String
    let weekDay: String
    let temperature: String
    let nightTemp: String
    let mainWeather: String
    let humidity: String
    
}

struct GenerateWeatherListHelper {
    static let instance = GenerateWeatherListHelper()
    
    func generateView (_ forecast: Forecast) -> WeatherListViewModel {
        let convert = ConvertTimestampToDateHelper(timestamp: forecast.date)
        let icon = forecast.weather[0].icon + ".png"
        let weekDay = convert.getDate() + " " + convert.getDayOfWeek()
        let temperature =  self.convertDoubleToString(forecast.temperature.max)
        let nightTemp = "/ " + self.convertDoubleToString(forecast.temperature.night)
        let mainWeather = forecast.weather[0].main
        let humidity = convertIntToString(forecast.humidity)
        
        
        return WeatherListViewModel(icon: icon, weekDay: weekDay, temperature: temperature, nightTemp: nightTemp, mainWeather: mainWeather, humidity: humidity)
    }
    
    fileprivate func convertDoubleToString(_ double: Double) -> String {
        return String(format: "%.f",double) + "˚"
    }
    
    fileprivate func convertIntToString(_ int: Int) -> String {
        return String(int) + "%"
    }
}
