//
//  EndView.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/27.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift
import RxCocoa
import RxGesture

class EndView: BaseView {
    
    var tapProductBlock: ((String) -> Void)?
    
    var model: notdropalityModel? {
        didSet {
            guard let model = model else { return }
            let logoUrl = model.adduous ?? ""
            logoImageView.kf.setImage(with: URL(string: logoUrl))
            nameLabel.text = model.shareian ?? ""
            
            listView.oneLabel.text = model.autoesque ?? ""
            listView.twoLabel.text = model.phrenious ?? ""
            
            let one = (model.townaire ?? "") + "    "
            let two = "    " + (model.nauo ?? "")
            listView.rateLabel.text = String(format: "%@|%@", one, two)
            
            applyBtn.setTitle(model.employeesome ?? "", for: .normal)
        }
    }
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "td_home_me_image")
        oneImageView.contentMode = .scaleAspectFit
        return oneImageView
    }()
    
    lazy var twoImageView: UIImageView = {
        let twoImageView = UIImageView()
        twoImageView.image = UIImage(named: "thd_home_me_image")
        twoImageView.contentMode = .scaleAspectFit
        twoImageView.isUserInteractionEnabled = true
        return twoImageView
    }()
    
    lazy var threeImageView: UIImageView = {
        let threeImageView = UIImageView()
        threeImageView.image = UIImage(named: "end_home_me_image")
        threeImageView.contentMode = .scaleAspectFit
        return threeImageView
    }()
    
    lazy var applyBtn: UIButton = {
        let applyBtn = UIButton(type: .custom)
        applyBtn.setTitleColor(.white, for: .normal)
        applyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        applyBtn.setBackgroundImage(UIImage(named: "app_home_me_image"), for: .normal)
        applyBtn.isUserInteractionEnabled = false
        applyBtn.titleEdgeInsets = UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 0)
        return applyBtn
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.layer.cornerRadius = 5
        logoImageView.layer.masksToBounds = true
        logoImageView.backgroundColor = .systemPink
        return logoImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hexString: "#000000")
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return nameLabel
    }()
    
    lazy var listView: CardListView = {
        let listView = CardListView()
        return listView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        scrollView.addSubview(oneImageView)
        scrollView.addSubview(twoImageView)
        scrollView.addSubview(threeImageView)
        
        oneImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 343.pix(), height: 308.pix()))
        }
        twoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(oneImageView.snp.bottom).offset(16)
            make.size.equalTo(CGSize(width: 351.pix(), height: 188.pix()))
        }
        threeImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(twoImageView.snp.bottom).offset(18)
            make.size.equalTo(CGSize(width: 118.pix(), height: 20.pix()))
            make.bottom.equalToSuperview().offset(-20.pix())
        }
        
        oneImageView.addSubview(logoImageView)
        oneImageView.addSubview(nameLabel)
        oneImageView.addSubview(listView)
        oneImageView.addSubview(applyBtn)
        
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(-40)
            make.top.equalToSuperview().offset(60.pix())
            make.height.width.equalTo(30)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView)
            make.left.equalTo(logoImageView.snp.right).offset(10)
            make.height.equalTo(20)
        }
        
        listView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(12)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(106.pix())
        }
        
        applyBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(listView.snp.bottom).offset(14.pix())
            make.size.equalTo(CGSize(width: 305.pix(), height: 64.pix()))
        }
        
        oneImageView
            .rx
            .tapGesture()
            .throttle(.microseconds(300), scheduler: MainScheduler.instance)
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                guard let self = self, let model = model else { return }
                let productId = String(model.stochacity ?? 0)
                self.tapProductBlock?(productId)
            }).disposed(by: disposeBag)
        
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
