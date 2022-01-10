//
//  BDSNavigationBar.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/10.
//

import UIKit

import SnapKit
import Then

final class BDSNavigationBar: UIView {
    
    // MARK: - Enum
    
    public enum PageView {
        case report
        case record
        case write
        case none
        
        fileprivate var title: String? {
            switch self {
            case .report: return "Report"
            case .record: return "Record"
            case .write: return "Write"
            case .none: return nil
            }
        }
    }

    // MARK: - Properties
    
    private var vc: UIViewController?
    
    private lazy var backButton = BackButton(root: vc ?? UIViewController())
    private lazy var closeButton = CloseButton(root: vc ?? UIViewController())
    
    private var titleLabel = UILabel().then {
        $0.font = BDSFont.enHead1
        $0.textColor = Asset.Colors.black200.color
        $0.textAlignment = .center
    }
    
    private var view: PageView = .record {
        didSet {
            configUI()
        }
    }
        
    // MARK: - Life Cycle
    
    public init(vc: UIViewController,
                view: PageView,
                isHidden: Bool) {
        super.init(frame: .zero)
        self.vc = vc
        self.view = view
        configUI()
        setupLayout()
        setupBackButton(isHidden: isHidden)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        backgroundColor = .white
        
        switch view {
        case .report, .record, .write, .none:
            titleLabel.text = view.title
        }
    }
    
    private func setupLayout() {
        self.addSubviews([backButton,
                          titleLabel,
                          closeButton])
        
        self.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(6)
            make.leading.equalToSuperview().inset(4)
            make.width.height.equalTo(44)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(19)
            make.centerX.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(6)
            make.trailing.equalToSuperview().inset(7)
            make.width.height.equalTo(44)
        }
    }
    
    // MARK: - Custom Method
    
    private func setupBackButton(isHidden: Bool) {
        backButton.isHidden = isHidden
        closeButton.isHidden = !backButton.isHidden
    }
}
