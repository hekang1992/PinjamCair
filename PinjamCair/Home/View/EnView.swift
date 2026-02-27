//
//  EnView.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/24.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift
import RxCocoa
import RxGesture

class EnView: BaseView {
    
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
        oneImageView.image = UIImage(named: "one_home_me_image")
        oneImageView.contentMode = .scaleAspectFit
        return oneImageView
    }()
    
    lazy var twoImageView: UIImageView = {
        let twoImageView = UIImageView()
        twoImageView.image = UIImage(named: "two_home_me_image")
        twoImageView.contentMode = .scaleAspectFit
        twoImageView.isUserInteractionEnabled = true
        return twoImageView
    }()
    
    lazy var threeImageView: UIImageView = {
        let threeImageView = UIImageView()
        threeImageView.image = UIImage(named: "three_home_me_image")
        threeImageView.contentMode = .scaleAspectFit
        return threeImageView
    }()
    
    lazy var fourImageView: UIImageView = {
        let fourImageView = UIImageView()
        fourImageView.image = UIImage(named: "en_home_me_image")
        fourImageView.contentMode = .scaleAspectFit
        return fourImageView
    }()
    
    lazy var applyBtn: UIButton = {
        let applyBtn = UIButton(type: .custom)
        applyBtn.setTitleColor(.white, for: .normal)
        applyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        applyBtn.setBackgroundImage(UIImage(named: "app_home_me_image"), for: .normal)
        applyBtn.isUserInteractionEnabled = false
        applyBtn.titleEdgeInsets = UIEdgeInsets(top: 5.pix(), left: 0, bottom: 0, right: 0)
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
    
    lazy var termsLabel: UILabel = {
        let termsLabel = UILabel()
        termsLabel.textAlignment = .left
        termsLabel.textColor = .black
        termsLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        termsLabel.isUserInteractionEnabled = true
        let fullText = "Read and agree to the Loan Terms"
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: "Loan Terms")
        attributedString.addAttribute(.foregroundColor, value: UIColor(hexString: "#1DBC79"), range: range)
        termsLabel.attributedText = attributedString
        return termsLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupGestures()
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(oneImageView)
        scrollView.addSubview(twoImageView)
        scrollView.addSubview(threeImageView)
        scrollView.addSubview(fourImageView)
        
        oneImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 343.pix(), height: 120.pix()))
        }
        
        twoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(oneImageView.snp.bottom).offset(16)
            make.size.equalTo(CGSize(width: 351.pix(), height: 338.pix()))
        }
        
        threeImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(twoImageView.snp.bottom).offset(12)
            make.size.equalTo(CGSize(width: 351.pix(), height: 188.pix()))
        }
        
        fourImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(threeImageView.snp.bottom).offset(36)
            make.size.equalTo(CGSize(width: 98.pix(), height: 20.pix()))
            make.bottom.equalToSuperview().offset(-20.pix())
        }
        
        twoImageView.addSubview(logoImageView)
        twoImageView.addSubview(nameLabel)
        twoImageView.addSubview(listView)
        twoImageView.addSubview(termsLabel)
        twoImageView.addSubview(applyBtn)
        
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
        
        termsLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.top.equalTo(listView.snp.bottom).offset(16)
            make.height.equalTo(20)
        }
        
        applyBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(termsLabel.snp.bottom).offset(8.pix())
            make.size.equalTo(CGSize(width: 305.pix(), height: 64.pix()))
        }
    }
    
    private func setupGestures() {
        // termsLabel 的点击事件
        termsLabel.rx
            .tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                self?.loanTermsTapped()
            })
            .disposed(by: disposeBag)
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.cancelsTouchesInView = false
        twoImageView.addGestureRecognizer(tapGesture)
        
        tapGesture.rx.event
            .throttle(.microseconds(300), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] gesture in
                guard let self = self else { return }
                
                let location = gesture.location(in: self.twoImageView)
                
                if self.termsLabel.frame.contains(location) {
                    return
                }
                
                guard let model = self.model else { return }
                let productId = String(model.stochacity ?? 0)
                self.tapProductBlock?(productId)
            })
            .disposed(by: disposeBag)
    }
}

extension EnView {
    
    @objc func loanTermsTapped() {
        ToastManager.showLocalMessage("Loan Terms tapped")
    }
    
}
