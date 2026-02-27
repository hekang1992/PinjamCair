//
//  AppTabBarController.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/24.
//

import UIKit

class AppTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        setupViewControllers()
        setupTabBarAppearance()
    }
    
    private func setupViewControllers() {
        
        let homeVC = HomeViewController()
        homeVC.tabBarItem = createTabBarItem(
            title: LocalStr("Loans"),
            imageName: "loan_nor_image",
            selectedImageName: "loan_sel_image"
        )
        
        let orderVC = OrderViewController()
        orderVC.tabBarItem = createTabBarItem(
            title: LocalStr("Orders"),
            imageName: "oc_nor_image",
            selectedImageName: "oc_sel_image"
        )
        
        let mineVC = MineViewController()
        mineVC.tabBarItem = createTabBarItem(
            title: LocalStr("Account"),
            imageName: "cn_nor_image",
            selectedImageName: "cn_sel_image"
        )
        
        viewControllers = [homeVC, orderVC, mineVC].map {
            AppNavigationController(rootViewController: $0)
        }
    }
    
    private func createTabBarItem(title: String, imageName: String, selectedImageName: String) -> UITabBarItem {
        let image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        let selectedImage = UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal)
        
        return UITabBarItem(title: title, image: image, selectedImage: selectedImage)
    }
    
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(hexString: "#BBBBBB"),
            .font: UIFont.systemFont(ofSize: 12)
        ]
        
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(hexString: "#0B3F29"),
            .font: UIFont.systemFont(ofSize: 12)
        ]
        
        let layouts = [
            appearance.stackedLayoutAppearance,
            appearance.inlineLayoutAppearance,
            appearance.compactInlineLayoutAppearance
        ]
        
        for layout in layouts {
            layout.normal.titleTextAttributes = normalAttributes
            layout.selected.titleTextAttributes = selectedAttributes
        }
        
        self.tabBar.standardAppearance = appearance
        
        if #available(iOS 15.0, *) {
            self.tabBar.scrollEdgeAppearance = appearance
        }
        
    }
}

extension AppTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
    
}
