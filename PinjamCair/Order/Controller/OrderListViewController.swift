//
//  OrderListViewController.swift
//  PinjamCair
//
//  Created by Ryan Thomas on 2026/2/27.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxGesture
import TYAlertController
import MJRefresh

class OrderListViewController: BaseViewController {
    
    private let viewModel = AppViewModel()
    
    private var modelArray: [dipsiauousModel] = []
    
    lazy var emptyView: EmptyView = {
        let emptyView = EmptyView(frame: .zero)
        return emptyView
    }()
    
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
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(OrderListViewCell.self, forCellReuseIdentifier: "OrderListViewCell")
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
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
        
        bgView.addSubview(emptyView)
        bgView.addSubview(tableView)
        
        emptyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
               
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            await self.orderListInfo()
        }
    }
    
}

extension OrderListViewController {
    
    private func orderListInfo() async {
        do {
            var type: String = "4"
            if name == LocalStr("All") {
                type = "4"
            }else if name == LocalStr("In progress") {
                type = "7"
            }else if name == LocalStr("Repayment") {
                type = "6"
            }else if name == LocalStr("Finished") {
                type = "5"
            }
            let parameters = ["carcinpickward": type,
                              "cacohood": "1",
                              "seatster": "100"]
            let model = try await viewModel.orderListInfo(parameters: parameters)
            let ectopurposeess = model.ectopurposeess ?? ""
            if ["0", "00"].contains(ectopurposeess) {
                let modelArray = model.casia?.dipsiauous ?? []
                self.modelArray = modelArray
                self.tableView.reloadData()
                if modelArray.isEmpty || modelArray.count == 0 {
                    self.tableView.isHidden = true
                    self.emptyView.isHidden = false
                }else {
                    self.tableView.isHidden = false
                    self.emptyView.isHidden = true
                }
            }else {
                self.tableView.isHidden = true
                self.emptyView.isHidden = false
            }
            await self.tableView.mj_header?.endRefreshing()
        } catch {
            self.tableView.isHidden = true
            self.emptyView.isHidden = false
            await self.tableView.mj_header?.endRefreshing()
        }
    }
    
}

extension OrderListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderListViewCell", for: indexPath) as! OrderListViewCell
        let model = self.modelArray[indexPath.row]
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.modelArray[indexPath.row]
        let pageUrl = model.ciliwhichery ?? ""
        if pageUrl.contains(SchemeRouter.shared.schemeUrl) {
            SchemeRouter.shared.handle(urlString: pageUrl, vc: self)
        }else {
            let webVc = H5ViewController()
            webVc.pageUrl = pageUrl
            self.navigationController?.pushViewController(webVc, animated: true)
        }
    }
    
}
