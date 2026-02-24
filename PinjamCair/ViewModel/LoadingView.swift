//
//  LoadingView.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/24.
//

import UIKit

final class LoadingView {
    
    static let shared = LoadingView()
    
    private var backgroundView: UIView?
    
    func show() {
        guard let window = Self.keyWindow(),
              backgroundView == nil else { return }
        
        let bgView = UIView(frame: window.bounds)
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 12
        containerView.center = bgView.center
        
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .black
        indicator.center = CGPoint(x: 50, y: 50)
        indicator.startAnimating()
        
        containerView.addSubview(indicator)
        bgView.addSubview(containerView)
        window.addSubview(bgView)
        
        backgroundView = bgView
    }
    
    func hide() {
        backgroundView?.removeFromSuperview()
        backgroundView = nil
    }
    
    private static func keyWindow() -> UIWindow? {
        if #available(iOS 13.0, *) {
            return UIApplication.shared
                .connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}

extension UIColor {
    convenience init(hexString: String) {
        var hex = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hex.hasPrefix("#") {
            hex.remove(at: hex.startIndex)
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgbValue)
        
        let r, g, b, a: CGFloat
        
        switch hex.count {
        case 6:
            r = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgbValue & 0x0000FF) / 255.0
            
            a = 1.0
        case 8:
            r = CGFloat((rgbValue & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgbValue & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgbValue & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgbValue & 0x000000FF) / 255.0
            
        default:
            r = 0; g = 0; b = 0; a = 1.0
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}

extension CGFloat {
    func pix() -> CGFloat {
        return self / 375.0 * UIScreen.main.bounds.width
    }
}

extension Double {
    func pix() -> CGFloat {
        return CGFloat(self) / 375.0 * UIScreen.main.bounds.width
    }
}

extension Int {
    func pix() -> CGFloat {
        return CGFloat(self) / 375.0 * UIScreen.main.bounds.width
    }
}
