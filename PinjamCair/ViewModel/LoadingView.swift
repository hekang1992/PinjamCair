//
//  LoadingView.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/24.
//

import UIKit
import Toast_Swift

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
    
    static func keyWindow() -> UIWindow? {
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

class ToastManager {
    
    static func showLocalMessage(_ key: String) {
        let languageStr = LocalStr(key)
        showOnWindow(languageStr)
    }
    
    private static func showOnWindow(_ message: String) {

        guard let keyWindow = LoadingView.keyWindow() else { return }
        
        DispatchQueue.main.async {
            keyWindow.makeToast(message, duration: 3.0, position: .center)
        }
    }
}

extension UIColor {
    convenience init(hexString: String) {
        var hexSanitized = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: 1.0)
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
