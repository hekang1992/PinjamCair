//
//  LoginViewController.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/24.
//

import UIKit
import SnapKit

class LoginViewController: BaseViewController {
    
    lazy var loginView: LoginView = {
        let loginView = LoginView(frame: .zero)
        return loginView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

//        view.addSubview(loginView)
//        loginView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
        
        let dateView = CustomDatePickerView(initialDate: "30-12-1990")
        
        dateView.onConfirm = { dateString in
            print("选中的日期:", dateString)
        }

        view.addSubview(dateView)
        dateView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
}
