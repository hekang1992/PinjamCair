//
//  MineViewController.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/24.
//

import UIKit
import SnapKit
import DeviceKit
import MJRefresh

class MineViewController: BaseViewController {
    
    private let viewModel = AppViewModel()
    
    lazy var mineView: MineView = {
        let mineView = MineView(frame: .zero)
        return mineView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mineView)
        mineView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mineView.tapBlock = { [weak self] pageUrl in
            guard let self = self else { return }
            if pageUrl.contains(SchemeRouter.shared.schemeUrl) {
                SchemeRouter.shared.handle(urlString: pageUrl, vc: self)
            }else {
                let webVc = H5ViewController()
                webVc.pageUrl = pageUrl
                self.navigationController?.pushViewController(webVc, animated: true)
            }
        }
        
        self.mineView.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            Task { [weak self] in
                await self?.getMineInfo()
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task { [weak self] in
            await self?.getMineInfo()
        }
    }
    
}

extension MineViewController {
    
    private func getMineInfo() async {
        do {
            let parameters = ["vitical": IDFVKeychainManager.shared.getIDFV(),
                              "sexability": Device.current.systemName ?? ""]
            let model = try await viewModel.getMineInfo(parameters: parameters)
            let ectopurposeess = model.ectopurposeess ?? ""
            if ["0", "00"].contains(ectopurposeess) {
                self.mineView.modelArray = model.casia?.dorsally ?? []
                self.mineView.tableView.reloadData()
            }
            await self.mineView.tableView.mj_header?.endRefreshing()
        } catch {
            await self.mineView.tableView.mj_header?.endRefreshing()
        }
    }
    
}
