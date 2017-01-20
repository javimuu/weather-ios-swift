//
//  ViewController.swift
//  weather
//
//  Created by muu van duy on 2017/01/12.
//  Copyright © 2017 muuvanduy. All rights reserved.
//

import UIKit
import MBProgressHUD

class ViewController: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var minMaxWeather: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var mainWeatherLabel: UILabel!
    @IBOutlet weak var iconLabel: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var screenHeight: CGFloat! = nil
    
    let cellReuseIdentifier = "tblviewcell"
    var forecastWrapper: ForecastWrapper?
    var forecasts: [Forecast]?
    
    override func viewWillAppear(_ animated: Bool) {
        ProgressHUDHelper.sharedInstance.showLoadingHUD(to_view: view)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        ProgressHUDHelper.sharedInstance.hideLoadingHUD(for_view: view)
        GettingCurrentWeatherHelper.instance.getCurrentWeather { result in
            let currentWeather = result.value
            
            let generateViewHelper =  GenerateViewHelper.instance.generateView(currentWeather!)
            
            self.iconLabel?.image = UIImage(named: generateViewHelper.icon)
            self.temperatureLabel?.text = generateViewHelper.temperature
            self.mainWeatherLabel?.text = generateViewHelper.mainWeather
            self.minMaxWeather?.text = generateViewHelper.maxMinTemp
        }
        
        self.loadMainView()
        self.loadForecastDaily()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let bounds: CGRect = self.view.bounds
        
        self.backgroundImageView.frame = bounds
        self.tableView.frame = bounds
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        cell.selectionStyle = .none
        cell.iconCol?.image = UIImage(named: generator.icon)
        cell.weekdayCol?.text = generator.weekDay
        cell.temperatureCol?.text = generator.temperature
        cell.nightTemp?.text = generator.nightTemp
        cell.humidity?.text = generator.humidity
        cell.mainWeather?.text = generator.mainWeather
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func loadMainView() {
        self.screenHeight = UIScreen.main.bounds.size.height
        
        let background = UIImage(named: "bg_launch")
        let headerFrame = UIScreen.main.bounds
        let header = UIView(frame: headerFrame)
        let inset: CGFloat = 20
        let temperatureHeight: CGFloat = 110
        let hiloHeight: CGFloat = 40
        let iconHeight: CGFloat = 30
        
        let hiloFrame = CGRect(x: inset, y: headerFrame.size.height - hiloHeight, width: headerFrame.size.width - (2 * inset), height: hiloHeight)
        
        let temperatureFrame = CGRect(x: inset, y: headerFrame.size.height  - (temperatureHeight + hiloHeight), width: headerFrame.size.width - (2 * inset), height: temperatureHeight)
        
        let iconFrame = CGRect(x: inset, y: temperatureFrame.origin.y - iconHeight, width: iconHeight, height: iconHeight)
        
        var conditionsFrame = iconFrame
        conditionsFrame.size.width = self.view.bounds.size.width - (((2 * inset) + iconHeight) + 10)
        conditionsFrame.origin.x = iconFrame.origin.x + (iconHeight + 10)
        
        header.backgroundColor = UIColor.clear
        
        self.temperatureLabel.frame = temperatureFrame
        self.temperatureLabel.backgroundColor = UIColor.clear
        self.temperatureLabel.textColor = UIColor.white
        self.temperatureLabel.font = UIFont.init(name: "HelveticaNeue-UltraLight", size: 120)
        header.addSubview(self.temperatureLabel)
        
        self.minMaxWeather.frame = hiloFrame
        self.minMaxWeather.backgroundColor = UIColor.clear
        self.minMaxWeather.textColor = UIColor.white
        self.minMaxWeather.font = UIFont.init(name: "HelveticaNeue-Light", size: 28)
        header.addSubview(self.minMaxWeather)
        
        self.mainWeatherLabel.frame = conditionsFrame
        self.mainWeatherLabel.backgroundColor = UIColor.clear
        self.mainWeatherLabel.textColor = UIColor.white
        self.mainWeatherLabel.font = UIFont.init(name: "HelveticaNeue-Light", size: 18)
        header.addSubview(self.mainWeatherLabel)
        
        self.iconLabel.frame = iconFrame
        self.iconLabel.backgroundColor = UIColor.clear
        self.iconLabel.contentMode = .scaleAspectFill
        header.addSubview(self.iconLabel)
        
        self.backgroundImageView.image = background
        self.backgroundImageView.contentMode = .scaleAspectFill
        self.view.addSubview(self.backgroundImageView)
        
        self.tableView.tableHeaderView = header
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.separatorColor = UIColor.init(white: 1, alpha: 0.2)
        self.tableView.isPagingEnabled = true
        self.view.addSubview(self.tableView)
    }
    
    
}

