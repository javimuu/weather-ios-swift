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
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var minMax: UILabel!
    @IBOutlet weak var mainWeather: UILabel!
    @IBOutlet weak var iconWeather: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        
        ProgressHUDHelper.sharedInstance.showLoadingHUD(to_view: contentView)
    }
  
    override func viewDidAppear(_ animated: Bool) {
        
        ProgressHUDHelper.sharedInstance.hideLoadingHUD(for_view: contentView)
        GettingCurrentWeatherHelper.instance.getCurrentWeather { result in
            let currentWeather = result.value
            
            let generateViewHelper =  GenerateViewHelper.instance.generateView(currentWeather!)
            
            self.iconWeather?.image = UIImage(named: generateViewHelper.icon)
            self.temperature.text = generateViewHelper.temperature
            self.mainWeather.text = generateViewHelper.mainWeather
            self.minMax.text = generateViewHelper.maxMinTemp
        }

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

