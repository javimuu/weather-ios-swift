//
//  WeatherListController.swift
//  weather
//
//  Created by muu van duy on 2017/01/13.
//  Copyright © 2017 muuvanduy. All rights reserved.
//

import UIKit

class WeatherListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let cellReuseIdentifier = "cell"
    
    override func viewWillAppear(_ animated: Bool) {
        ProgressHUDHelper.sharedInstance.showLoadingHUD(to_view: view)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        ProgressHUDHelper.sharedInstance.hideLoadingHUD(for_view: view)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.responseToSwipeGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        // add data to table view
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    let tableItems = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5",
                      "Item 6", "Item 7", "Item 8", "Item 9", "Item 10", "Item 11",
                      "Item 12", "Item 13", "Item 14", "Item 15"]

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return tableItems.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! CustomTableViewCell

        cell.iconCol?.image = #imageLiteral(resourceName: "icon1")
        cell.weekdayCol?.text = tableItems[indexPath.row]
        cell.temperatureCol?.text = tableItems[indexPath.row]
        return cell
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
