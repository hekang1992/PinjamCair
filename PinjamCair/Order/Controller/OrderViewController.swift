//
//  OrderViewController.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/24.
//

import UIKit
import SnapKit
import DeviceKit
import MJRefresh

class OrderViewController: BaseViewController {
    
    private let viewModel = AppViewModel()
    
    private var type: String = "4"
    
    private var modelArray: [dipsiauousModel] = []
    
    // MARK: - UI
    lazy var headImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "login_head_image")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var tipsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = LocalStr("Order")
        label.textColor = UIColor(hexString: "#FFFFFF")
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    lazy var bgView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var footView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    // MARK: - Order Tabs
    lazy var oneView: OrderListView = {
        let view = OrderListView(frame: .zero)
        view.nameLabel.text = LocalStr("All")
        view.nameLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        view.nameLabel.textColor = UIColor.init(hexString: "#0B3F29")
        view.logoImageView.image = UIImage(named: "one_oc_image")
        return view
    }()
    
    lazy var twoView: OrderListView = {
        let view = OrderListView(frame: .zero)
        view.nameLabel.text = LocalStr("In progress")
        view.logoImageView.image = UIImage(named: "two_oc_image")
        return view
    }()
    
    lazy var threeView: OrderListView = {
        let view = OrderListView(frame: .zero)
        view.nameLabel.text = LocalStr("Repayment")
        view.logoImageView.image = UIImage(named: "three_oc_image")
        return view
    }()
    
    lazy var fourView: OrderListView = {
        let view = OrderListView(frame: .zero)
        view.nameLabel.text = LocalStr("Finished")
        view.logoImageView.image = UIImage(named: "four_oc_image")
        return view
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
    
    lazy var emptyView: EmptyView = {
        let emptyView = EmptyView(frame: .zero)
        return emptyView
    }()
    
    private var tabViews: [OrderListView] {
        return [oneView, twoView, threeView, fourView]
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        setupOrderListView()
        
        updateSelectedView(oneView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            await self.orderListInfo()
        }
    }
}

extension OrderViewController {
    
    private func orderListInfo() async {
        do {
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
    
    private func setupUI() {
        view.addSubview(headImageView)
        view.addSubview(tipsLabel)
        view.addSubview(bgView)
        bgView.addSubview(scrollView)
        view.addSubview(footView)
        
        headImageView.snp.makeConstraints { make in
            make.top.leading.right.equalToSuperview()
            make.height.equalTo(280.pix())
        }
        
        tipsLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(12)
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(21)
        }
        
        bgView.snp.makeConstraints { make in
            make.top.equalTo(tipsLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(26)
            make.height.equalTo(75)
        }
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        footView.snp.makeConstraints { make in
            make.top.equalTo(bgView.snp.bottom).offset(12)
            make.bottom.leading.right.equalToSuperview()
        }
        
        footView.addSubview(emptyView)
        emptyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        footView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
        
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            Task {
                await self.orderListInfo()
            }
        })
    }
}

extension OrderViewController {
    
    private func setupOrderListView() {
        
        tabViews.forEach { scrollView.addSubview($0) }
        
        oneView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(60)
        }
        
        twoView.snp.makeConstraints { make in
            make.left.equalTo(oneView.snp.right).offset(15)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(90)
        }
        
        threeView.snp.makeConstraints { make in
            make.left.equalTo(twoView.snp.right).offset(15)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(80)
        }
        
        fourView.snp.makeConstraints { make in
            make.left.equalTo(threeView.snp.right).offset(15)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(60)
            make.right.equalToSuperview().offset(-10)
        }
        
        oneView.tapClick = { [weak self] _ in
            self?.type = "4"
            self?.updateSelectedView(self?.oneView)
            Task {
                await self?.orderListInfo()
            }
        }
        
        twoView.tapClick = { [weak self] _ in
            self?.type = "7"
            self?.updateSelectedView(self?.twoView)
            Task {
                await self?.orderListInfo()
            }
        }
        
        threeView.tapClick = { [weak self] _ in
            self?.type = "6"
            self?.updateSelectedView(self?.threeView)
            Task {
                await self?.orderListInfo()
            }
        }
        
        fourView.tapClick = { [weak self] _ in
            self?.type = "5"
            self?.updateSelectedView(self?.fourView)
            Task {
                await self?.orderListInfo()
            }
        }
        
    }
    
    private func updateSelectedView(_ selectedView: OrderListView?) {
        guard let selectedView = selectedView else { return }
        
        tabViews.forEach { view in
            if view == selectedView {
                view.nameLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
                view.nameLabel.textColor = UIColor.init(hexString: "#0B3F29")
            } else {
                view.nameLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
                view.nameLabel.textColor = .white
            }
        }
    }
}

extension OrderViewController: UITableViewDelegate, UITableViewDataSource {
    
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
