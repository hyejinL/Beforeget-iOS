//
//  PostViewController.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/07.
//

import UIKit

import SnapKit
import Then

class PostViewController: UIViewController {

    // MARK: - Properties
    
    private lazy var navigationBar = BDSNavigationBar(self, view: .write, isHidden: false)
    
    private let doneButton = UIButton().then {
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(Asset.Colors.gray200.color, for: .normal)
    }
    
    private lazy var writingTableView = UITableView().then {
        $0.backgroundColor = Asset.Colors.white.color
        $0.sectionHeaderTopPadding = 0
        
        $0.delegate = self
        $0.dataSource = self
    }
    
    private lazy var toolBar = UIToolbar().then {
        $0.barTintColor = Asset.Colors.white.color
        $0.setItems([UIBarButtonItem(customView: addItemButton), toolBarSpacing, UIBarButtonItem(customView: deleteItemButton)], animated: true)
    }
    
    private let toolBarSpacing = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil).then {
        $0.width = 15
    }
    
    private let addItemButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.title = "기록항목 추가"
        config.image = Asset.Assets.icnAddItem.image
        config.imagePadding = 8
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        config.baseForegroundColor = Asset.Colors.black200.color
        $0.configuration = config
    }
    
    private let deleteItemButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.title = "기록항목 삭제"
        config.image = Asset.Assets.icnEdit.image
        config.imagePadding = 4
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        config.baseForegroundColor = Asset.Colors.black200.color
        $0.configuration = config
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = .white
    }
    
    private func setupLayout() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.addSubviews([navigationBar,
                          doneButton,
                          writingTableView,
                          toolBar])
        
        navigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        doneButton.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.top).inset(6)
            $0.trailing.equalTo(navigationBar.snp.trailing).inset(13)
        }
        
        writingTableView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        toolBar.snp.makeConstraints {
            $0.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    // MARK: - Custom Method

}

extension PostViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension PostViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return WritingHeaderView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 192
    }
}


