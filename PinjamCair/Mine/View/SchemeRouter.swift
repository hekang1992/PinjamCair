//
//  SchemeRouter.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/27.
//

import UIKit

enum RouteType {
    case setting
    case main
    case login
    case order
    case productDetail(productId: String?)
    case contact
}

class SchemeRouter {
    
    static let shared = SchemeRouter()
    private init() {}
    
    private let validScheme = "responsibility"
    
    let schemeUrl = "responsibility://octatory.imageia.hedraage"
    
    private let pathMap: [String: RouteType] = [
        "shakeivity": .setting,
        "chancetion": .main,
        "primidom": .login,
        "workible": .contact
    ]
    
    func handle(urlString: String, vc: UIViewController) {
        
        guard let url = URL(string: urlString),
              url.scheme == validScheme else {
            return
        }
        
        let path = url.lastPathComponent
        
        if url.path.isEmpty || url.path == "/" {
            navigate(to: .main, vc: vc)
            return
        }
        
        if path == "battice" {
            let productId = getQueryValue(url: url, key: "hoplcy")
            navigate(to: .productDetail(productId: productId), vc: vc)
            return
        }
        
        if let route = pathMap[path] {
            navigate(to: route, vc: vc)
        } else {
            print("none-")
        }
    }
    
    private func getQueryValue(url: URL, key: String) -> String? {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let queryItems = components.queryItems else {
            return nil
        }
        
        return queryItems.first(where: { $0.name == key })?.value
    }
}

extension SchemeRouter {
    
    private func navigate(to route: RouteType, vc: UIViewController) {

        let nav = vc.navigationController
        
        switch route {
            
        case .setting:
            let vc = SettingViewController()
            nav?.pushViewController(vc, animated: true)
            
        case .main:
            NotificationCenter.default.post(name: NSNotification.Name("changeRootVc"), object: nil)
            
        case .login:
            LoginManager.shared.deleteLoginInfo()
            NotificationCenter.default.post(name: NSNotification.Name("changeRootVc"), object: nil)
            
        case .order:
            break
            
        case .productDetail(let productId):
            let vc = ProductDetailViewController()
            vc.productId = productId ?? ""
            nav?.pushViewController(vc, animated: true)
            
        case .contact:
            let vc = ContactViewController()
            nav?.pushViewController(vc, animated: true)
        }
    }
}
