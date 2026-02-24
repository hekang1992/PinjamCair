//
//  AppLaunchViewController.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/24.
//

import UIKit

class AppLaunchViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.post(name: NSNotification.Name("changeRootVc"), object: nil)
    }
    
}
