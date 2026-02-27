//
//  MineView.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/24.
//

import UIKit
import SnapKit

class MineView: BaseView {
    
    var modelArray: [dorsallyModel] = []
    
    var tapBlock: ((String) -> Void)?

    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView()
        headImageView.image = UIImage(named: "login_head_image")
        headImageView.contentMode = .scaleAspectFill
        return headImageView
    }()
    
    lazy var tipsLabel: UILabel = {
        let tipsLabel = UILabel()
        tipsLabel.textAlignment = .left
        tipsLabel.text = LocalStr("Account")
        tipsLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        tipsLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return tipsLabel
    }()
    
    lazy var messageListView: MineMessageView = {
        let messageListView = MineMessageView()
        return messageListView
    }()
    
    lazy var loanServiceBtn: UIButton = {
        let loanServiceBtn = UIButton(type: .custom)
        loanServiceBtn.setBackgroundImage(UIImage(named: LocalStr("cn_desc_lo_image")), for: .normal)
        loanServiceBtn.adjustsImageWhenHighlighted = false
        return loanServiceBtn
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 18
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        return bgView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(MineListViewCell.self, forCellReuseIdentifier: "MineListViewCell")
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headImageView)
        addSubview(tipsLabel)
        addSubview(messageListView)
        addSubview(loanServiceBtn)
        addSubview(bgView)
        bgView.addSubview(tableView)
        headImageView.snp.makeConstraints { make in
            make.top.leading.right.equalToSuperview()
            make.height.equalTo(280.pix())
        }
        tipsLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(5)
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(21)
        }
        messageListView.snp.makeConstraints { make in
            make.top.equalTo(tipsLabel.snp.bottom).offset(25)
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(55)
        }
        loanServiceBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 343.pix(), height: 106.pix()))
            make.bottom.equalTo(bgView.snp.top).offset(14)
        }
        bgView.snp.makeConstraints { make in
            make.top.equalTo(headImageView.snp.bottom).offset(-10)
            make.left.right.bottom.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.top.leading.right.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MineView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120.pix()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView()
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: LocalStr("cn_oc_image"))
        bgImageView.contentMode = .scaleAspectFill
        headView.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 324.pix(), height: 74.pix()))
        }
        return headView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MineListViewCell", for: indexPath) as! MineListViewCell
        let model = modelArray[indexPath.row]
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = modelArray[indexPath.row]
        let pageUrl = model.openarium ?? ""
        self.tapBlock?(pageUrl)
    }
    
}
