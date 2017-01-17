//
//  WeatherListController.swift
//  weather
//
//  Created by muu van duy on 2017/01/13.
//  Copyright © 2017 muuvanduy. All rights reserved.
//

import UIKit
import Alamofire

class WeatherListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let cellReuseIdentifier = "cell"
    var forecastWrapper: ForecastWrapper?
    var forecasts: [Forecast]?
    
    override func viewWillAppear(_ animated: Bool) {
        
        ProgressHUDHelper.sharedInstance.showLoadingHUD(to_view: view)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.loadForecastDaily()
        ProgressHUDHelper.sharedInstance.hideLoadingHUD(for_view: view)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.responseToSwipeGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Get data from API
    
    func loadForecastDaily() {
        
        GettingDailyForecastHelper.instance.getDailyForecast { result in
            let forecastWrapper = result.value
            self.addForecastToList(forecastWrapper!)
            self.tableView?.reloadData()
        }
    }
    
    func addForecastToList(_ forecastWrapper: ForecastWrapper) {
        
        self.forecastWrapper = forecastWrapper
        self.forecasts = forecastWrapper.list
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        // Return the number of sections.
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Return the number of rows in the section.
        return self.forecasts!.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! CustomTableViewCell
        
        let generator =  GenerateWeatherListHelper.instance.generateView(self.forecasts![indexPath.row])
        
        cell.iconCol?.image = UIImage(named: generator.icon)
        cell.weekdayCol?.text = generator.weekDay
        cell.temperatureCol?.text = generator.temperature
        cell.nightTemp?.text = generator.nightTemp
        cell.humidity?.text = generator.humidity
        cell.mainWeather?.text = generator.mainWeather
        
        return cell
    }
    
    // MARK: - Handle events
    
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
