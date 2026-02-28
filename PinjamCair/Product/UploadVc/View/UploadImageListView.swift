//
//  UploadImageListView.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/28.
//

import UIKit
import SnapKit

class UploadImageListView: BaseView {
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var typeImageView: UIImageView = {
        let typeImageView = UIImageView()
        typeImageView.image = UIImage(named: LocalStr("en_cam_image"))
        typeImageView.contentMode = .scaleAspectFit
        return typeImageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(typeImageView)
        
        bgImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 327.pix(), height: 254.pix()))
        }
        
        typeImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 120.pix(), height: 40.pix()))
            make.left.equalToSuperview().inset(24)
            make.top.equalToSuperview().offset(98)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
