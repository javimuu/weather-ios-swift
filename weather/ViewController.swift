//
//  ViewController.swift
//  weather
//
//  Created by muu van duy on 2017/01/12.
//  Copyright © 2017 muuvanduy. All rights reserved.
//

import UIKit
import MBProgressHUD

class ViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        ProgressHUDHelper.sharedInstance.showLoadingHUD(to_view: contentView)
    }
  
    override func viewDidAppear(_ animated: Bool) {
        ProgressHUDHelper.sharedInstance.hideLoadingHUD(for_view: contentView)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle swipe event
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.responseToSwipeGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func responseToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture  as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {

            case UISwipeGestureRecognizerDirection.left:
                SwipeHelper.sharedInstance.presentDestination(self, destination: "weatherListController")
                
            default: break
                
            }
        }
    }

}

