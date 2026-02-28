//
//  UploadImageViewController.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/24.
//

import UIKit
import SnapKit

class UploadImageViewController: BaseViewController {
    
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
    
    lazy var oneView: UploadImageListView = {
        let oneView = UploadImageListView()
        oneView.bgImageView.image = UIImage(named: LocalStr("en_cmc_image"))
        return oneView
    }()
    
    lazy var twoView: UploadImageListView = {
        let twoView = UploadImageListView()
        twoView.bgImageView.image = UIImage(named: LocalStr("en_face_image"))
        return twoView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        view.backgroundColor = .white
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
            make.left.bottom.right.equalToSuperview()
        }
        
        view.addSubview(nextBtn)
        nextBtn.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 343.pix(), height: 60.pix()))
        }
        
        bgView.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(nextBtn.snp.top).offset(-5)
        }
        
        scrollView.addSubview(oneView)
        scrollView.addSubview(twoView)
        
        oneView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 327.pix(), height: 254.pix()))
        }
        
        twoView.snp.makeConstraints { make in
            make.top.equalTo(oneView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 327.pix(), height: 254.pix()))
            make.bottom.equalToSuperview().offset(-20.pix())
        }
        
        headView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.toProductDetailVc()
        }
        
        oneView.tapClickBlock = {
            ToastManager.showLocalMessage("1")
        }
        
        twoView.tapClickBlock = {
            ToastManager.showLocalMessage("2")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task { [weak self] in
            await self?.getMessageInfo()
        }
    }
    
}

extension UploadImageViewController {
    
    private func getMessageInfo() async {
        do {
            let hoplcy = cardModel?.stochacity ?? ""
            let parameters = ["hoplcy": hoplcy]
            let model = try await viewModel.getMessageInfo(parameters: parameters)
            let ectopurposeess = model.ectopurposeess ?? ""
            if ["0", "00"].contains(ectopurposeess) {
                
            }
        } catch {
            
        }
    }
    
}
