//
//  EndMaxView.swift
//  PinjamCair
//
//  Created by hekang on 2026/3/2.
//

import UIKit

class EndMaxView: BaseView {
    
    var model: BaseModel? {
        didSet {
            guard let model = model else { return }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
