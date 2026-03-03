//
//  BaseViewController.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/24.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.init(hexString: "#1DBC79")
    }
    
}

extension BaseViewController {
    
    func toProductDetailVc() {
        guard let nav = navigationController else { return }
        
        if let vc = nav.viewControllers.compactMap({ $0 as? ProductDetailViewController }).first {
            nav.popToViewController(vc, animated: true)
        } else {
            nav.popToRootViewController(animated: true)
        }
    }
    
}

extension BaseViewController {
    
    func goNextAuthVc(stepModel: mrerModel, cardModel: spergiceModel) {
        let type = stepModel.ommfic ?? ""
        switch type {
        case "afterency":
            let uplistVc = UploadImageViewController()
            uplistVc.cardModel = cardModel
            uplistVc.stepModel = stepModel
            self.navigationController?.pushViewController(uplistVc, animated: true)
            
        case "developally":
            let personalVc = PersonalViewController()
            personalVc.cardModel = cardModel
            personalVc.stepModel = stepModel
            self.navigationController?.pushViewController(personalVc, animated: true)
            
        case "goldenSunr":
            let workerVc = WorkerViewController()
            workerVc.cardModel = cardModel
            workerVc.stepModel = stepModel
            self.navigationController?.pushViewController(workerVc, animated: true)
            
        case "stereably":
            let contactVc = ContactViewController()
            contactVc.cardModel = cardModel
            contactVc.stepModel = stepModel
            self.navigationController?.pushViewController(contactVc, animated: true)
            
        case "pavidization":
            let walletVc = WalletViewController()
            walletVc.cardModel = cardModel
            walletVc.stepModel = stepModel
            self.navigationController?.pushViewController(walletVc, animated: true)
            
        case "":
            let orderID = cardModel.weightfier ?? ""
            let cisain = cardModel.cisain ?? ""
            let musicfic = cardModel.musicfic ?? ""
            let oedate = String(cardModel.oedate ?? 0)
            let usuallyable = LoginManager.shared.getPhone()
            let pediern = UIDevice.current.name
            let parameters = ["readyize": orderID,
                              "cisain": cisain,
                              "musicfic": musicfic,
                              "oedate": oedate,
                              "usuallyable": usuallyable,
                              "pediern": pediern]
            Task {
                await self.reallyClickInfo(parameters: parameters, cardModel: cardModel)
            }
            
        default:
            break
        }
    }
    
    private func reallyClickInfo(parameters: [String: String], cardModel: spergiceModel) async {
        Task {
            do {
                let viewModel = AppViewModel()
                let model = try await viewModel.reallyApplyInfo(parameters: parameters)
                let ectopurposeess = model.ectopurposeess ?? ""
                if ["0", "00"].contains(ectopurposeess) {
                    let pageUrl = model.casia?.feliee ?? ""
                    if pageUrl.contains(SchemeRouter.shared.schemeUrl) {
                        SchemeRouter.shared.handle(urlString: pageUrl, vc: self)
                    }else {
                        let webVc = H5ViewController()
                        webVc.pageUrl = pageUrl
                        self.navigationController?.pushViewController(webVc, animated: true)
                    }
                    Task {
                        await self.peig(cardModel: cardModel, viewModel: viewModel)
                    }
                }else {
                    ToastManager.showLocalMessage(model.urgth ?? "")
                }
            } catch {
                
            }
        }
    }
    
    private func peig(cardModel: spergiceModel, viewModel: AppViewModel) async {
        do {
            let parameters = ["ennea": cardModel.stochacity ?? "",
                              "ticization": "8",
                              "weightfier": cardModel.weightfier ?? "",
                              "piain": String(Int(Date().timeIntervalSince1970)),
                              "managementtic": String(Int(Date().timeIntervalSince1970))]
            let _ = try await viewModel.uploadNamePointInfo(parameters: parameters)
        } catch {
            
        }
    }
    
}
