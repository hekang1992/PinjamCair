//
//  EndMaxView.swift
//  PinjamCair
//
//  Created by hekang on 2026/3/2.
//

import UIKit
import SnapKit

class EndMaxView: BaseView {
    
    var model: BaseModel? {
        didSet {
            guard let _ = model else { return }
            tableView.reloadData()
        }
    }
    
    var tapProductBlock: ((String) -> Void)?
    
    var tapBannerBlock: ((String) -> Void)?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(CardViewCell.self, forCellReuseIdentifier: "CardViewCell")
        tableView.register(AppBannerViewCell.self, forCellReuseIdentifier: "AppBannerViewCell")
        tableView.register(MaxProductViewCell.self, forCellReuseIdentifier: "MaxProductViewCell")
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.leading.right.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EndMaxView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let model = self.model?.casia?.dipsiauous?[section]
        let type = model?.emesive ?? ""
        switch type {
        case "juvenar", "emetolawyeran", "clavaloneular":
            return 0
            
        case "noteent":
            return 50
            
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let model = self.model?.casia?.dipsiauous?[section]
        let type = model?.emesive ?? ""
        switch type {
        case "juvenar", "emetolawyeran", "clavaloneular":
            return UIView()
            
        case "noteent":
            let headView = UIView()
            let titleLabel = UILabel(frame: .zero)
            titleLabel.text = "Produk"
            titleLabel.textColor = UIColor.init(hexString: "#0B3F29")
            titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
            headView.addSubview(titleLabel)
            titleLabel.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(16)
                make.bottom.equalToSuperview().offset(-12)
                make.height.equalTo(20)
            }
            return headView
            
        default:
            return UIView()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.model?.casia?.dipsiauous?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = self.model?.casia?.dipsiauous?[section]
        let type = model?.emesive ?? ""
        switch type {
        case "juvenar":
            return 0
            
        case "emetolawyeran", "clavaloneular":
            return 1
            
        case "noteent":
            return model?.notdropality?.count ?? 0
            
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = self.model?.casia?.dipsiauous?[indexPath.section]
        let type = model?.emesive ?? ""
        
        switch type {
        case "juvenar":
            return UITableViewCell()
            
        case "emetolawyeran":
            let cell = tableView.dequeueReusableCell(withIdentifier: "CardViewCell", for: indexPath) as! CardViewCell
            cell.model = model?.notdropality?.first ?? notdropalityModel()
            cell.tapProductBlock = { [weak self] productID in
                self?.tapProductBlock?(productID)
            }
            return cell
            
        case "clavaloneular":
            let cell = tableView.dequeueReusableCell(withIdentifier: "AppBannerViewCell", for: indexPath) as! AppBannerViewCell
            let modelArray = model?.notdropality ?? []
            cell.modelArray = modelArray
            cell.clickTapBlock = { [weak self] pageUrl in
                self?.tapBannerBlock?(pageUrl)
            }
            return cell
            
            
        case "noteent":
            let cell = tableView.dequeueReusableCell(withIdentifier: "MaxProductViewCell", for: indexPath) as! MaxProductViewCell
            cell.model = model?.notdropality?[indexPath.row]
            cell.tapProductBlock = { [weak self] productID in
                self?.tapProductBlock?(productID)
            }
            return cell
            
        default:
            return UITableViewCell()
        }
    
    }
    
}
