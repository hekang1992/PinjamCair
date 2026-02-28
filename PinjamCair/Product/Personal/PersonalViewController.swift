//
//  PersonalViewController.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/24.
//

import UIKit
import SnapKit

class PersonalViewController: BaseViewController {
    
    var cardModel: spergiceModel?
    var stepModel: mrerModel? {
        didSet {
            guard let stepModel = stepModel else { return }
            headView.nameLabel.text = stepModel.rusbadior ?? ""
        }
    }
    
    private let viewModel = AppViewModel()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "h5_head_bg_image")
        bgImageView.contentMode = .scaleAspectFill
        return bgImageView
    }()
    
    lazy var headView: AppHeadView = {
        let headView = AppHeadView(frame: .zero)
        return headView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 18
        bgView.layer.masksToBounds = true
        bgView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bgView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        return bgView
    }()
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.setTitleColor(.white, for: .normal)
        nextBtn.setTitle(LocalStr("Next"), for: .normal)
        nextBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        nextBtn.setBackgroundImage(UIImage(named: "login_btn_image"), for: .normal)
        return nextBtn
    }()
    
    lazy var stepImageView: UIImageView = {
        let stepImageView = UIImageView()
        stepImageView.image = UIImage(named: "one_step_image")
        stepImageView.contentMode = .scaleAspectFit
        return stepImageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.top.leading.right.equalToSuperview()
            make.height.equalTo(180.pix())
        }
        
        view.addSubview(headView)
        headView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        view.addSubview(stepImageView)
        stepImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(headView.snp.bottom).offset(16)
            make.size.equalTo(CGSize(width: 343.pix(), height: 62.pix()))
        }
        
        view.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.equalTo(stepImageView.snp.bottom).offset(14)
            make.left.right.bottom.equalToSuperview()
        }
        
        bgView.addSubview(nextBtn)
        nextBtn.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 343.pix(), height: 60.pix()))
        }
        
        headView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.toProductDetailVc()
        }
        
    }

}
