//
//  Errors.swift
//  weather
//
//  Created by muu van duy on 2017/01/17.
//  Copyright © 2017 muuvanduy. All rights reserved.
//

import Foundation

enum SerializationError: Error {
    
    case missing(String)
    case invalid(String, Any)
    
}

enum RequestError: Error {
    
    case requestError(Any)

}
