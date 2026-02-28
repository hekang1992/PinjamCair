//
//  UploadImageViewController.swift
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
internal import AVFoundation

class UploadImageViewController: BaseViewController {
    
    var cardModel: spergiceModel?
    var stepModel: mrerModel? {
        didSet {
            guard let stepModel = stepModel else { return }
            headView.nameLabel.text = stepModel.rusbadior ?? ""
        }
    }
    
    private let viewModel = AppViewModel()
    
    private var model: BaseModel?
    
    private let camera = SystemCameraManager()
    
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
        stepImageView.image = UIImage(named: "one_step_image")
        stepImageView.contentMode = .scaleAspectFit
        return stepImageView
    }()
    
    lazy var oneView: UploadImageListView = {
        let oneView = UploadImageListView()
        oneView.bgImageView.image = UIImage(named: LocalStr("en_cmc_image"))
        return oneView
    }()
    
    lazy var twoView: UploadImageListView = {
        let twoView = UploadImageListView()
        twoView.bgImageView.image = UIImage(named: LocalStr("en_face_image"))
        return twoView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
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
        
        bgView.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(nextBtn.snp.top).offset(-5)
        }
        
        scrollView.addSubview(oneView)
        scrollView.addSubview(twoView)
        
        oneView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 327.pix(), height: 254.pix()))
        }
        
        twoView.snp.makeConstraints { make in
            make.top.equalTo(oneView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 327.pix(), height: 254.pix()))
            make.bottom.equalToSuperview().offset(-20.pix())
        }
        
        headView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.toProductDetailVc()
        }
        
        oneView.tapClickBlock = { [weak self] in
            guard let self = self else { return }
            if let model = self.model {
                let card = model.casia?.occurot?.feliee ?? ""
                let face = model.casia?.proliosity?.feliee ?? ""
                if card.isEmpty {
                    self.uploadOneImageInfo(model: model, type: .cell)
                    return
                }
                if face.isEmpty {
                    self.uploadTwoImageInfo(model: model, type: .cell)
                    return
                }
            }
        }
        
        twoView.tapClickBlock = { [weak self] in
            guard let self = self else { return }
            if let model = self.model {
                let card = model.casia?.occurot?.feliee ?? ""
                let face = model.casia?.proliosity?.feliee ?? ""
                if card.isEmpty {
                    self.uploadOneImageInfo(model: model, type: .cell)
                    return
                }
                if face.isEmpty {
                    self.uploadTwoImageInfo(model: model, type: .cell)
                    return
                }
            }
        }
        
        nextBtn
            .rx
            .tap
            .throttle(.microseconds(200), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                if let model = self.model {
                    let card = model.casia?.occurot?.feliee ?? ""
                    let face = model.casia?.proliosity?.feliee ?? ""
                    if card.isEmpty {
                        self.uploadOneImageInfo(model: model, type: .next)
                        return
                    }
                    if face.isEmpty {
                        self.uploadTwoImageInfo(model: model, type: .next)
                        return
                    }
                    Task {
                        await self.getDetailInfo()
                    }
                }
            }).disposed(by: disposeBag)
        
        Task { [weak self] in
            await self?.getMessageInfo()
        }
        
        self.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            Task {
                await self?.getMessageInfo()
            }
        })
        
    }
    
}

extension UploadImageViewController {
    
    private func getMessageInfo() async {
        do {
            let hoplcy = cardModel?.stochacity ?? ""
            let parameters = ["hoplcy": hoplcy]
            let model = try await viewModel.getMessageInfo(parameters: parameters)
            let ectopurposeess = model.ectopurposeess ?? ""
            if ["0", "00"].contains(ectopurposeess) {
                self.model = model
                let card = model.casia?.occurot?.feliee ?? ""
                let face = model.casia?.proliosity?.feliee ?? ""
                if !card.isEmpty {
                    self.oneView.typeImageView.image = UIImage(named: "com_cam_image")
                }
                if !face.isEmpty {
                    self.twoView.typeImageView.image = UIImage(named: "com_cam_image")
                }
            }
            await self.scrollView.mj_header?.endRefreshing()
        } catch {
            await self.scrollView.mj_header?.endRefreshing()
        }
    }
    
    private func uploadOneImageInfo(model: BaseModel, type: ClickType) {
        let popView = UploadIntroduceView(frame: self.view.bounds)
        popView.bgImageView.image = UIImage(named: LocalStr("en_ktp_image"))
        let alertVc = TYAlertController(alert: popView, preferredStyle: .alert)
        self.present(alertVc!, animated: true)
        
        popView.cancelBlock = { [weak self] in
            self?.dismiss(animated: true)
        }
        
        popView.sureBlock = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
            camera.openCamera(from: self) { data in
                Task {
                    if let data = data {
                        await self.uploadImageInfo(type: "11", data: data)
                    }
                }
            }
        }
    }
    
    private func uploadTwoImageInfo(model: BaseModel, type: ClickType) {
        let popView = UploadIntroduceView(frame: self.view.bounds)
        popView.bgImageView.image = UIImage(named: LocalStr("uen_face_image"))
        let alertVc = TYAlertController(alert: popView, preferredStyle: .alert)
        self.present(alertVc!, animated: true)
        
        popView.cancelBlock = { [weak self] in
            self?.dismiss(animated: true)
        }
        
        popView.sureBlock = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
            camera.openCamera(from: self, cameraPosition: .front) { data in
                Task {
                    if let data = data {
                        await self.uploadImageInfo(type: "10", data: data)
                    }
                }
            }
        }
    }
    
    private func uploadImageInfo(type: String, data: Data) async {
        do {
            let parameters = ["emesive": type,
                              "scabiocompareette": "2",
                              "marwhoeur": "",
                              "weaponify": "1"]
            let model = try await viewModel.uploadImageInfo(parameters: parameters, data: data)
            let ectopurposeess = model.ectopurposeess ?? ""
            let ischoolul = model.casia?.ischoolul ?? 0
            if ["0", "00"].contains(ectopurposeess) {
                
                if type == "10" {
                    await self.getDetailInfo()
                }
                
                if type == "11" {
                    if ischoolul == 0 {
                        // no alert
                        await self.getMessageInfo()
                        
                    }else {
                        // alert
                        if let casiaModel = model.casia {
                            self.popKtpView(with: casiaModel)
                        }
                    }
                }
                
            }else {
                ToastManager.showLocalMessage(model.urgth ?? "")
            }
        } catch {
            
        }
    }
    
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
    
    private func popKtpView(with model: casiaModel) {
        let popView = KtpView(frame: self.view.bounds)
        popView.model = model
        let alertVc = TYAlertController(alert: popView, preferredStyle: .actionSheet)
        self.present(alertVc!, animated: true)
        
        popView.cancelBlock = { [weak self] in
            self?.dismiss(animated: true)
        }
        
        popView.timeBlock = { tx in
            let selectTime = tx.text ?? ""
            let dateView = CustomDatePickerView(initialDate: selectTime)
            
            dateView.onConfirm = { dateString in
                tx.text = dateString
            }
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
                window.addSubview(dateView)
                dateView.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
                }
            }
        }
        
        popView.sureBlock = { [weak self] in
            guard let self = self else { return }
            let name = popView.oneFiled.text ?? ""
            let number = popView.twoFiled.text ?? ""
            let time = popView.threeFiled.text ?? ""
            let phone = LoginManager.shared.getPhone()
            let orderID = cardModel?.weightfier ?? ""
            let productID = cardModel?.stochacity ?? ""
            
            Task {
                do {
                    var parameters = ["throwality": name,
                                      "languageate": number,
                                      "supportsion": time,
                                      "trueuous": phone,
                                      "readyize": orderID,
                                      "hoplcy": productID]
                    if LanguageManager.shared.currentType == .english {
                        parameters["emesive"] = "13"
                    }
                    let model = try await self.viewModel.saveImageInfo(parameters: parameters)
                    let ectopurposeess = model.ectopurposeess ?? ""
                    if ["0", "00"].contains(ectopurposeess) {
                        self.dismiss(animated: true)
                        await self.getMessageInfo()
                    }else {
                        ToastManager.showLocalMessage(model.urgth ?? "")
                    }
                } catch {
                    
                }
            }
            
        }
    }
    
}
