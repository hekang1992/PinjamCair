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
            let workVc = WorkViewController()
            workVc.cardModel = cardModel
            workVc.stepModel = stepModel
            self.navigationController?.pushViewController(workVc, animated: true)
            
        case "stereably":
            break
        case "pavidization":
            break
        default:
            break
        }
    }
    
}
