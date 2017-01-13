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
    init() {
        // do initial setup or establish an initial connection
    }
    
    func responseToSwipeGesture(gesture: UIGestureRecognizer, direction: UISwipeGestureRecognizerDirection, destination: String) {
        if let swipeGesture = gesture  as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
                
            case UISwipeGestureRecognizerDirection.right:
                print("right")
            case UISwipeGestureRecognizerDirection.left:
                print("left")
            default: break
                
            }
        }
    }
    
    func presentDestination(_ this: UIViewController, destination: String) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: destination) as! UIViewController
        resultViewController.modalTransitionStyle = .flipHorizontal
        this.present(resultViewController, animated: true, completion: nil)
    }

}


