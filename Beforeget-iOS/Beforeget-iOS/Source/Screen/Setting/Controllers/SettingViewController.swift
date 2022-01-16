//
//  SettingViewController.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/16.
//

import UIKit

import SnapKit
import Then

class SettingViewController: UIViewController {

    // MARK: - Properties
    
    private let settingMenuArray = ["비밀번호 변경", "서비스 이용약관", "로그아웃", "서비스 탈퇴"]
    
    private lazy var navigationBar = BDSNavigationBar(
        self, view: .none, isHidden: false)
    
    private lazy var settingTableView = UITableView(frame: .zero, style: .grouped).then {
        $0.separatorStyle = .none
        $0.sectionHeaderTopPadding = 0
        $0.backgroundColor = Asset.Colors.white.color
        $0.delegate = self
        $0.dataSource = self
        SettingTableViewCell.register(target: $0)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = Asset.Colors.white.color
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setupLayout() {
        view.addSubviews([navigationBar, settingTableView])
        
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        settingTableView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDelegate

extension SettingViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return SettingHeaderView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UIScreen.main.hasNotch ? 164 : 159
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return SettingFooterView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UIScreen.main.hasNotch ? 304 : 227
    }
}

// MARK: - UITableViewDataSource

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingMenuArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let settingCell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.className, for: indexPath) as? SettingTableViewCell
        else { return UITableViewCell() }
        if indexPath.item == 3 || indexPath.item == 2 {
            settingCell.menuLabel.textColor = Asset.Colors.gray100.color
            settingCell.nextButton.isHidden = true
        }
        settingCell.setData(settingMenuArray[indexPath.item])
        return settingCell
    }
}
