//
//  ContactViewController.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import MJRefresh
import TYAlertController

class ContactViewController: BaseViewController {
    
    var cardModel: spergiceModel?
    var stepModel: mrerModel? {
        didSet {
            guard let stepModel = stepModel else { return }
            headView.nameLabel.text = stepModel.rusbadior ?? ""
        }
    }
    
    private let viewModel = AppViewModel()
    
    private var model: BaseModel?
    
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
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.setTitleColor(.white, for: .normal)
        nextBtn.setTitle(LocalStr("Next"), for: .normal)
        nextBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        nextBtn.setBackgroundImage(UIImage(named: "login_btn_image"), for: .normal)
        return nextBtn
    }()
    
    lazy var stepImageView: UIImageView = {
        let stepImageView = UIImageView()
        stepImageView.image = UIImage(named: "fu_step_image")
        stepImageView.contentMode = .scaleAspectFit
        return stepImageView
    }()
    
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
        tableView.register(ContactViewCell.self, forCellReuseIdentifier: "ContactViewCell")
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
        
        view.addSubview(stepImageView)
        stepImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(headView.snp.bottom).offset(16)
            make.size.equalTo(CGSize(width: 343.pix(), height: 62.pix()))
        }
        
        view.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.equalTo(stepImageView.snp.bottom).offset(14)
            make.left.bottom.right.equalToSuperview()
        }
        
        view.addSubview(nextBtn)
        nextBtn.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 343.pix(), height: 60.pix()))
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(stepImageView.snp.bottom).offset(14)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(nextBtn.snp.top)
        }
        
        headView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.toProductDetailVc()
        }
        
        nextBtn
            .rx
            .tap
            .throttle(.microseconds(200), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                
            }).disposed(by: disposeBag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            await self.getContactInfo()
        }
    }
    
}

extension ContactViewController {
    
    private func getContactInfo() async {
        do {
            let parameters = ["hoplcy": cardModel?.stochacity ?? ""]
            let model = try await viewModel.getContactInfo(parameters: parameters)
            let ectopurposeess = model.ectopurposeess ?? ""
            if ["0", "00"].contains(ectopurposeess) {
                self.model = model
                self.tableView.reloadData()
            }
        } catch {
            
        }
    }
}

extension ContactViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model?.casia?.crucful?.dipsiauous?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactViewCell", for: indexPath) as! ContactViewCell
        let model = self.model?.casia?.crucful?.dipsiauous?[indexPath.row]
        cell.model = model
        return cell
    }
    
    private func tapCellInfo(with model: dieModel, cell: CoachViewCell) {
        
        let popView = PopAutnEnumView(frame: self.view.bounds)
        popView.nameLabel.text = model.rusbadior ?? ""
        let modelArray = model.drawie ?? []
        popView.modelArray = modelArray
        let name = cell.oneFiled.text ?? ""
        for (index, listModel) in modelArray.enumerated() {
            if name == listModel.throwality ?? "" {
                popView.selectIndex(index)
            }
        }
        
        let alertVc = TYAlertController(alert: popView, preferredStyle: .alert)
        self.present(alertVc!, animated: true)
        
        popView.cancelBlock = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
        
        popView.saveBlock = { [weak self] listModel in
            guard let self = self else { return }
            self.dismiss(animated: true)
            model.emesive = listModel.emesive ?? ""
            model.tvarium = listModel.throwality ?? ""
            cell.oneFiled.text = listModel.throwality ?? ""
        }
        
    }
    
}

extension ContactViewController {
    
    private func getDetailInfo() async {
        do {
            let parameters = ["hoplcy": cardModel?.stochacity ?? ""]
            let model = try await viewModel.productDetailInfo(parameters: parameters)
            let ectopurposeess = model.ectopurposeess ?? ""
            if ["0", "00"].contains(ectopurposeess) {
                if let stepModel = model.casia?.stagn, let cardModel = model.casia?.spergice {
                    self.goNextAuthVc(stepModel: stepModel, cardModel: cardModel)
                }
            }
        } catch {
            
        }
    }
}
