//
//  ProgressHelper.swift
//  weather
//
//  Created by muu van duy on 2017/01/13.
//  Copyright © 2017 muuvanduy. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class ProgressHUDHelper {
    static let sharedInstance = ProgressHUDHelper()
    init() {
        // do initial setup or establish an initial connection
    }
    
    
    func showLoadingHUD(to_view: UIView) {
        let hud = MBProgressHUD.showAdded(to: to_view, animated: true)
        hud.label.text = "Loading..."
    }
    
    func hideLoadingHUD(for_view: UIView) {
        MBProgressHUD.hide(for: for_view, animated: true)
    }
    
}
