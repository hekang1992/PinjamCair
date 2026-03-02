//
//  OrderListViewController.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/27.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxGesture
import TYAlertController

class OrderListViewController: BaseViewController {
    
    private let viewModel = AppViewModel()
    
    var name: String? {
        didSet {
            guard let name = name else { return }
            headView.nameLabel.text = name
        }
    }
    
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
        
        headView.backBlock = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        view.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(16)
            make.left.right.bottom.equalToSuperview()
        }
               
    }
    
}
