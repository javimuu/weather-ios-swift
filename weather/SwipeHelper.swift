//
//  SwipeHelper.swift
//  weather
//
//  Created by muu van duy on 2017/01/13.
//  Copyright © 2017 muuvanduy. All rights reserved.
//

import Foundation
import UIKit

class SwipeHelper {
    
    static let sharedInstance = SwipeHelper()
    
    fileprivate init() {
        // do initial setup or establish an initial connection
    }
    
    func presentDestination(_ this: UIViewController, destination: String) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: destination)
        resultViewController.modalTransitionStyle = .flipHorizontal
        this.present(resultViewController, animated: true, completion: nil)
    }

}


