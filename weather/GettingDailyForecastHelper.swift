//
//  GettingCurrentWeatherHelper.swift
//  weather
//
//  Created by muu van duy on 2017/01/16.
//  Copyright © 2017 muuvanduy. All rights reserved.
//

import Foundation
import Alamofire


class GettingDailyForecastHelper {
    static let instance = GettingDailyForecastHelper()
    
    fileprivate func getDailyForecastAtPath(_ path: String, completionHandler: @escaping (Result<ForecastWrapper>) -> Void)  {
        
        Alamofire.request(path, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(let json):
                do {
                    let forecast =  try ForecastWrapper(json: (json as? [String: Any])! )
                    completionHandler(.success(forecast))
                } catch {
                    completionHandler(.failure(RequestError.requestError(error)))
                }
                
            case .failure(let error):
                completionHandler(.failure(RequestError.requestError(error)))
            }
        }
    }
    
    func getDailyForecast(_ completionHandler: @escaping (Result<ForecastWrapper>) -> Void) {
        let url = Params.dailyForecast + Constants.API_KEY
        self.getDailyForecastAtPath(url, completionHandler: completionHandler)
    }
    
}
