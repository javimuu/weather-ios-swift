//
//  WeatherListController.swift
//  weather
//
//  Created by muu van duy on 2017/01/13.
//  Copyright © 2017 muuvanduy. All rights reserved.
//

import UIKit

class WeatherListViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        ProgressHUDHelper.sharedInstance.showLoadingHUD(to_view: view)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        ProgressHUDHelper.sharedInstance.hideLoadingHUD(for_view: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.responseToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    @IBAction func backToMainView(sender: UIBarButtonItem) {
        SwipeHelper.sharedInstance.presentDestination(self, destination: "viewController")
    }
    
    func responseToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture  as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
                
            case UISwipeGestureRecognizerDirection.right:
                SwipeHelper.sharedInstance.presentDestination(self, destination: "viewController")
            default: break
                
            }
        }
    }

}
