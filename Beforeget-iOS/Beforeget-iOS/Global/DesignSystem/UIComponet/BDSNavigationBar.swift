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
    
    // MARK: - Metric Enum
    
    public enum Metric {
        static let navigationHeight: CGFloat = UIScreen.main.hasNotch ? 44 : 50
        static let titleTop: CGFloat = 13
        static let buttonLeading: CGFloat = 4
        static let buttonTrailing: CGFloat = 7
        static let buttonSize: CGFloat = 44
    }
    
    // MARK: - PageView Enum
    
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
    
    private var viewController = UIViewController()
    public var backButton = BackButton()
    private var closeButton = CloseButton()
    
    private var titleLabel = UILabel().then {
        $0.font = BDSFont.enHead2
        $0.textColor = Asset.Colors.black200.color
        $0.textAlignment = .center
    }
    
    private var viewType: PageView = .record {
        didSet {
            configUI()
        }
    }
    
    // MARK: - Initializer
    
    public init(_ viewController: UIViewController,
                view: PageView,
                isHidden: Bool) {
        super.init(frame: .zero)
        self.backButton = BackButton(root: viewController)
        self.closeButton = CloseButton(root: viewController)
        viewType = view
        configUI()
        setupLayout()
        setupBackButton(isHidden: isHidden)
    }
    
    convenience init(_ viewController: UIViewController,
                     view: PageView,
                     isHidden: Bool, mediaType: MediaType) {
        self.init(viewController, view: view, isHidden: isHidden)
        setupWriteTitle(mediaType: mediaType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        backgroundColor = .white
        titleLabel.text = viewType.title
    }
    
    private func setupLayout() {
        addSubviews([backButton,
                     titleLabel,
                     closeButton])
        
        snp.makeConstraints { make in
            make.height.equalTo(Metric.navigationHeight)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(Metric.buttonLeading)
            make.width.height.equalTo(Metric.buttonSize)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(9)
            make.centerX.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().inset(Metric.buttonTrailing)
            make.width.height.equalTo(Metric.buttonSize)
        }
    }
    
    // MARK: - Custom Method
    
    private func setupBackButton(isHidden: Bool) {
        backButton.isHidden = isHidden
        closeButton.isHidden = !backButton.isHidden
    }
    
    private func setupWriteTitle(mediaType: MediaType) {
        titleLabel.text = "\(mediaType)"
    }
}
