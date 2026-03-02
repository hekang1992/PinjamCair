//
//  EmptyView.swift
//  PinjamCair
//
//  Created by hekang on 2026/3/2.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxGesture

class EmptyView: BaseView {
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: LocalStr("ep_list_a_image"))
        bgImageView.contentMode = .scaleAspectFit
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20.pix())
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 231.pix(), height: 343.pix()))
        }
        
        bgImageView
            .rx
            .tapGesture()
            .throttle(.microseconds(200), scheduler: MainScheduler.instance)
            .when(.recognized).bind(onNext: { _ in
                NotificationCenter.default.post(name: NSNotification.Name("changeRootVc"), object: nil)
            }).disposed(by: disposeBag)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
