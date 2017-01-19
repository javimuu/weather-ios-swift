//
//  GenerateViewHelper.swift
//  weather
//
//  Created by muu van duy on 2017/01/17.
//  Copyright © 2017 muuvanduy. All rights reserved.
//

import Foundation
import UIKit

struct ViewModel {
    
    let icon: String
    let temperature: String
    let mainWeather: String
    let maxMinTemp: String

}

struct GenerateViewHelper {
    static let instance = GenerateViewHelper()
    
    func generateView (_ condition: Condition) -> ViewModel {
        let icon = condition.weather[0].icon + ".png"
        let temperature = self.convertDoubleToString(condition.main.temperature)
        let mainWeather = condition.weather[0].main
        let maxMinTemp = self.convertDoubleToString(condition.main.tempMax) + "/ " + convertDoubleToString(condition.main.tempMin)
        
        return ViewModel(icon: icon, temperature: temperature, mainWeather: mainWeather, maxMinTemp: maxMinTemp)
    }
    
    fileprivate func convertDoubleToString(_ double: Double) -> String {
        return String(format: "%.f",double) + "˚"
    }
}

