//
//  AppBannerViewCell.swift
//  PinjamCair
//
//  Created by Ryan Thomas on 2026/3/2.
//

import UIKit
import SnapKit
import FSPagerView

class AppBannerViewCell: UITableViewCell {
    
    // MARK: - Public Properties
    var clickTapBlock: ((String) -> Void)?
    
    var modelArray: [notdropalityModel]? {
        didSet {
            pagerView.reloadData()
        }
    }
    
    // MARK: - UI Components
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(hexString: "#FFFFFF")
        return view
    }()
    
    private lazy var ringImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ring_icon_image")
        return imageView
    }()
    
    private lazy var pagerView: FSPagerView = {
        let pagerView = FSPagerView()
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.register(ImageCarouselCell.self,
                           forCellWithReuseIdentifier: ImageCarouselCell.reuseIdentifier)
        pagerView.interitemSpacing = 5
        pagerView.transformer = FSPagerViewTransformer(type: .linear)
        pagerView.isInfinite = true
        pagerView.automaticSlidingInterval = 3.0
        pagerView.backgroundColor = .clear
        return pagerView
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.addSubview(containerView)
        containerView.addSubview(ringImageView)
        containerView.addSubview(pagerView)
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(56)
            make.bottom.equalToSuperview().offset(-12)
        }
        
        ringImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.size.equalTo(24)
        }
        
        pagerView.snp.makeConstraints { make in
            make.left.equalTo(ringImageView.snp.right).offset(8)
            make.top.right.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Helper Methods
    private func configureCellAppearance(_ cell: ImageCarouselCell) {
        // 清除默认的阴影效果
        cell.contentView.layer.shadowColor = UIColor.clear.cgColor
        cell.contentView.layer.shadowRadius = 0
        cell.contentView.layer.shadowOpacity = 0
        cell.contentView.layer.shadowOffset = .zero
        
        cell.contentView.transform = .identity
        cell.contentView.backgroundColor = .clear
        cell.backgroundColor = .clear
    }
}

// MARK: - FSPagerView DataSource & Delegate
extension AppBannerViewCell: FSPagerViewDataSource, FSPagerViewDelegate {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return modelArray?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(
            withReuseIdentifier: ImageCarouselCell.reuseIdentifier,
            at: index
        ) as! ImageCarouselCell
        
        if let banner = modelArray?[index] {
            cell.configure(with: banner)
        }
        
        configureCellAppearance(cell)
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        guard let banner = modelArray?[index],
              let tapParameter = banner.feliee else { return }
        
        clickTapBlock?(tapParameter)
    }
}

// MARK: - Reusable Extension
extension UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
