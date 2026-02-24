//
//  LoginView.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/24.
//

import UIKit
import SnapKit

class LoginView: BaseView {

    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView()
        headImageView.image = UIImage(named: "login_head_image")
        headImageView.contentMode = .scaleAspectFill
        return headImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headImageView)
        headImageView.snp.makeConstraints { make in
            make.top.leading.right.equalToSuperview()
            make.height.equalTo(240.pix())
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
