import UIKit
import SnapKit
import RxSwift
import RxCocoa

class AppHeadView: BaseView {
    
    var backBlock: (() -> Void)?
    
    private let backBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(named: "app_back_image"), for: .normal)
        return button
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(hexString: "#FFFFFF")
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        bindEvent()
    }
    
    private func setupUI() {
        addSubview(backBtn)
        addSubview(nameLabel)
        
        backBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.width.height.equalTo(24)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(backBtn.snp.right).offset(12)
            make.right.lessThanOrEqualToSuperview().offset(-20)
        }
    }
    
    private func bindEvent() {
        backBtn
            .rx
            .tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind { [weak self] in
                self?.backBlock?()
            }
            .disposed(by: disposeBag)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
