//
//  config.swift
//  weather
//
//  Created by muu van duy on 2017/01/16.
//  Copyright © 2017 muuvanduy. All rights reserved.
//

import Foundation

struct Params {
    static let currentUrl: String = "http://api.openweathermap.org/data/2.5/weather?q=Tokyou,jp&units=metric&APPID="
    static let dailyForecast: String = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=35&lon=139&cnt=16&units=metric&APPID="
}

struct Constants {
    static let API_KEY: String = "32464315a1be08b1047c0718402831c7"
}
