//
//  AppDelegate.swift
//  PinjamCair
//
//  Created by Ryan Thomas on 2026/2/24.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        changeRootNotiVc()
        setupKeyboardConfig()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = AppLaunchViewController()
        window?.makeKeyAndVisible()
        return true
    }
    
}

extension AppDelegate {
    
    private func changeRootNotiVc() {
        NotificationCenter.default.addObserver(self, selector: #selector(changeRootVc(_:)), name: NSNotification.Name("changeRootVc"), object: nil)
    }
    
    private func setupKeyboardConfig() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
    
    @objc func changeRootVc(_ noti: Notification) {
        
        let tabBar = AppTabBarController()
        let userInfo = noti.userInfo as? [String: String] ?? [:]
        let tab = userInfo["tab"]
        let type = userInfo["type"]
        if tab == "order" {
            if let orderVC = (tabBar.viewControllers?[1] as? UINavigationController)?.viewControllers.first as? OrderViewController {
                orderVC.selectedTab = type ?? "4"
            }
            tabBar.selectedIndex = 1
        }else {
            tabBar.selectedIndex = 0
        }
        window?.rootViewController = tabBar
    }
    
}
