//
//  GettingCurrentWeatherHelper.swift
//  weather
//
//  Created by muu van duy on 2017/01/16.
//  Copyright © 2017 muuvanduy. All rights reserved.
//

import Foundation
import Alamofire


class GettingCurrentWeatherHelper {
    static let instance = GettingCurrentWeatherHelper()
    
    fileprivate func getCurrentWeatherAtPath(_ path: String, completionHandler: @escaping (Result<Condition>) -> Void)  {
        
        Alamofire.request(path, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(_):
                if let data = response.result.value {
                    do {
                        let condition =  try Condition(json: (data as? [String: Any])! )
                        completionHandler(.success(condition))
                    } catch {
                        completionHandler(.failure(RequestError.requestError(error)))
                    }
                }
                break
                
            case .failure(_):
                completionHandler(.failure(RequestError.requestError(response.result.error!)))
                break
            }
        }
    }
    
    func getCurrentWeather(_ completionHandler: @escaping (Result<Condition>) -> Void) {
        let url = Params.currentUrl + Constants.API_KEY
        self.getCurrentWeatherAtPath(url, completionHandler: completionHandler)
    }

}
