//
//  ProductDetailViewController.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/27.
//

import UIKit
import SnapKit
import MJRefresh
import DeviceKit
import Kingfisher
import RxSwift
import RxCocoa

enum ClickType {
    case next
    case cell
}

class ProductDetailViewController: BaseViewController {
    
    var productId: String = ""
    
    private var model: BaseModel?
    
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
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(StepViewCell.self, forCellReuseIdentifier: "StepViewCell")
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.setTitleColor(.white, for: .normal)
        nextBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        nextBtn.setBackgroundImage(UIImage(named: "login_btn_image"), for: .normal)
        return nextBtn
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
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textAlignment = .left
        descLabel.text = LocalStr("Certification")
        descLabel.textColor = UIColor.init(hexString: "#0B3F29")
        descLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return descLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.init(hexString: "#F6F7F9")
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
        
        view.addSubview(nextBtn)
        nextBtn.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 343.pix(), height: 60.pix()))
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(5)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(nextBtn.snp.top).offset(-5)
        }
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            Task {
                await self?.getDetailInfo()
            }
        })
        
        headView.backBlock = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        
        nextBtn
            .rx
            .tap
            .throttle(.microseconds(200), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                if let clickModel = self.model?.casia?.stagn {
                    clickToVc(model: clickModel, type: .next)
                }
            }).disposed(by: disposeBag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task { [weak self] in
            await self?.getDetailInfo()
        }
    }
    
}

extension ProductDetailViewController {
    
    private func getDetailInfo() async {
        do {
            let parameters = ["hoplcy": productId, "wholing": Device.current.systemVersion ?? ""]
            let model = try await viewModel.productDetailInfo(parameters: parameters)
            let ectopurposeess = model.ectopurposeess ?? ""
            if ["0", "00"].contains(ectopurposeess) {
                self.model = model
                self.configTitle(model: model)
            }
            self.tableView.reloadData()
            await MainActor.run {
                self.tableView.mj_header?.endRefreshing()
            }
        } catch {
            await MainActor.run {
                self.tableView.mj_header?.endRefreshing()
            }
        }
    }
    
    private func configTitle(model: BaseModel) {
        self.headView.nameLabel.text = model.casia?.spergice?.shareian ?? ""
        self.nextBtn.setTitle(model.casia?.spergice?.employeesome ?? "", for: .normal)
    }
    
}

extension ProductDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 252.pix()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cardModel = self.model?.casia?.spergice
        let headView = UIView()
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "pd_head_image")
        headView.addSubview(bgImageView)
        headView.addSubview(descLabel)
        bgImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 346.pix(), height: 187.pix()))
            make.top.equalToSuperview().offset(5.pix())
        }
        
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(bgImageView.snp.bottom).offset(24)
            make.left.equalTo(bgImageView)
            make.height.equalTo(20)
        }
        
        bgImageView.addSubview(logoImageView)
        bgImageView.addSubview(nameLabel)
        bgImageView.addSubview(listView)
        
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(-40)
            make.top.equalToSuperview().offset(16.pix())
            make.height.width.equalTo(30)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView)
            make.left.equalTo(logoImageView.snp.right).offset(10)
            make.height.equalTo(20)
        }
        
        listView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(15)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(106.pix())
        }
        
        let logoUrl = cardModel?.adduous ?? ""
        logoImageView.kf.setImage(with: URL(string: logoUrl))
        nameLabel.text = cardModel?.shareian ?? ""
        listView.oneLabel.text = cardModel?.cultureesque ?? ""
        listView.twoLabel.text = cardModel?.cisain ?? ""
        
        let one = (cardModel?.canous?.antiture?.herself ?? "") + "    "
        let two = "    " + (cardModel?.musicfic ?? "")
        listView.rateLabel.text = String(format: "%@|%@", one, two)
        
        return headView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model?.casia?.mrer?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StepViewCell", for: indexPath) as! StepViewCell
        let model = self.model?.casia?.mrer?[indexPath.row]
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let model = self.model?.casia?.mrer?[indexPath.row] {
            clickToVc(model: model, type: .cell)
        }
    }
    
}

extension ProductDetailViewController {
    
    private func clickToVc(model: mrerModel, type: ClickType) {
        switch type {
        case .next:
            let ommfic = model.ommfic ?? ""
            if ommfic == "afterency" {
                let listVc = UploadImageViewController()
                if let cardModel = self.model?.casia?.spergice {
                    listVc.cardModel = cardModel
                }
                self.navigationController?.pushViewController(listVc, animated: true)
            }
            
        case .cell:
            break
        
        }
    }
    
}
