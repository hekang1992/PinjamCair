//
//  AppDelegate.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/24.
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
        if LoginManager.shared.isLoggedIn() {
            window?.rootViewController = AppTabBarController()
        }else {
            window?.rootViewController = AppNavigationController(rootViewController: LoginViewController())
        }
        
//        for familyName in UIFont.familyNames {
//            print("Family: \(familyName)")
//            for fontName in UIFont.fontNames(forFamilyName: familyName) {
//                print("--- Font: \(fontName)")
//            }
//        }
        
    }
    
}
