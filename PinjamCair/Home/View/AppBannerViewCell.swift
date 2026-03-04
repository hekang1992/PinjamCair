//
//  AppBannerViewCell.swift
//  PinjamCair
//
//  Created by hekang on 2026/3/2.
//

import UIKit
import SnapKit
import FSPagerView

class AppBannerViewCell: UITableViewCell {
    
    var clickTapBlock: ((String) -> Void)?
    
    var modelArray: [notdropalityModel]? {
        didSet {
            guard let _ = modelArray else { return }
            pagerView.reloadData()
        }
    }
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 5
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        return bgView
    }()
    
    lazy var ringImageView: UIImageView = {
        let ringImageView = UIImageView()
        ringImageView.image = UIImage(named: "ring_icon_image")
        return ringImageView
    }()
    
    private lazy var pagerView: FSPagerView = {
        let pagerView = FSPagerView()
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.register(ImageCarouselCell.self,
                           forCellWithReuseIdentifier: "ImageCarouselCell")
        pagerView.interitemSpacing = 5
        pagerView.transformer = FSPagerViewTransformer(type: .linear)
        pagerView.isInfinite = true
        pagerView.automaticSlidingInterval = 3.0
        pagerView.backgroundColor = .clear
        pagerView.layer.borderWidth = 0
        return pagerView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(bgView)
        bgView.addSubview(ringImageView)
        bgView.addSubview(pagerView)
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(56)
            make.bottom.equalToSuperview().offset(-12)
        }
        ringImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.width.height.equalTo(24)
        }
        pagerView.snp.makeConstraints { make in
            make.left.equalTo(ringImageView.snp.right).offset(8)
            make.top.right.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AppBannerViewCell: FSPagerViewDelegate, FSPagerViewDataSource {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return modelArray?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(
            withReuseIdentifier: "ImageCarouselCell",
            at: index
        ) as! ImageCarouselCell
        
        if let model = modelArray?[index] {
            cell.configure(with: model)
        }
        self.cellPara(with: cell)
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        guard let model = modelArray?[index] else { return }
        self.clickTapBlock?(model.feliee ?? "")
    }
    
    private func cellPara(with cell: ImageCarouselCell) {
        cell.contentView.layer.shadowColor = UIColor.clear.cgColor
        cell.contentView.layer.shadowRadius = 0
        cell.contentView.layer.shadowOpacity = 0
        cell.contentView.layer.shadowOffset = .zero
        
        cell.contentView.transform = CGAffineTransform.identity
        
        cell.contentView.backgroundColor = .clear
        cell.backgroundColor = .clear
    }
    
}
