//
//  CustomTableViewCell.swift
//  weather
//
//  Created by muu van duy on 2017/01/13.
//  Copyright © 2017 muuvanduy. All rights reserved.
//

import Foundation
import UIKit
class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var iconCol: UIImageView!
    @IBOutlet weak var weekdayCol: UILabel!
    @IBOutlet weak var temperatureCol: UILabel!
    @IBOutlet weak var mainWeather: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var nightTemp: UILabel!
}
