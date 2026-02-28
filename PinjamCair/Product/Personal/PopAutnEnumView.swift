//
//  PopAutnEnumView.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/28.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PopAutnEnumView: BaseView {
    
    var cancelBlock: (() -> Void)?
    var saveBlock: ((drawieModel) -> Void)?
    
    private var currentSelectedIndex: Int? = nil
    
    var modelArray: [drawieModel]?
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "en_a_d_image")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(type: .custom)
        return cancelBtn
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hexString: "#0B3F29")
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return nameLabel
    }()
    
    lazy var saveBtn: UIButton = {
        let saveBtn = UIButton(type: .custom)
        saveBtn.setTitleColor(.white, for: .normal)
        saveBtn.setTitle(LocalStr("Confirm"), for: .normal)
        saveBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        saveBtn.backgroundColor = UIColor.init(hexString: "#1DBC79")
        saveBtn.layer.cornerRadius = 24.pix()
        saveBtn.layer.masksToBounds = true
        return saveBtn
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(AuthListViewCell.self, forCellReuseIdentifier: "AuthListViewCell")
        tableView.layer.cornerRadius = 16
        tableView.layer.masksToBounds = true
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(nameLabel)
        bgImageView.addSubview(cancelBtn)
        bgImageView.addSubview(saveBtn)
        bgImageView.addSubview(tableView)
        
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 343.pix(), height: 592.pix()))
        }
        
        cancelBtn.snp.makeConstraints { make in
            make.width.height.equalTo(32.pix())
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(31.pix())
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(22)
        }
        
        saveBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(cancelBtn.snp.top).offset(-82.pix())
            make.size.equalTo(CGSize(width: 283.pix(), height: 48.pix()))
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(17.pix())
            make.left.right.equalToSuperview().inset(10)
            make.bottom.equalTo(saveBtn.snp.top).offset(-5.pix())
        }
        
        cancelBtn
            .rx
            .tap
            .throttle(.milliseconds(250), latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.cancelBlock?()
            })
            .disposed(by: disposeBag)
        
        saveBtn
            .rx
            .tap
            .throttle(.milliseconds(250), latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                if currentSelectedIndex == nil {
                    ToastManager.showLocalMessage("Please select one")
                    return
                }
                if let modelArray = modelArray, let currentSelectedIndex = currentSelectedIndex {
                    self.saveBlock?(modelArray[currentSelectedIndex])
                }
            })
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func selectIndex(_ index: Int?) {
        guard let modelArray = modelArray, modelArray.count > 0 else { return }
        
        if let index = index, index >= 0 && index < modelArray.count {
            currentSelectedIndex = index
        } else {
            currentSelectedIndex = nil
        }
        
        tableView.reloadData()
    }
    
}

extension PopAutnEnumView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 12.pix()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AuthListViewCell", for: indexPath) as! AuthListViewCell
        cell.model = self.modelArray?[indexPath.row]
        
        let isSelected = (currentSelectedIndex == indexPath.row)
        cell.setSelectedState(isSelected)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if currentSelectedIndex == indexPath.row {
            currentSelectedIndex = nil
        } else {
            currentSelectedIndex = indexPath.row
        }
        tableView.reloadData()
    }
    
}
