//
//  MyRecordViewController.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/07.
//

import UIKit

import SnapKit
import Then

final class MyRecordViewController: UIViewController {
    
    // MARK: - Properties
        
    private lazy var navigationBar = BDSNavigationBar(
        self, view: .record, isHidden: false)
    
    private lazy var searchButton = UIButton().then {
        $0.setImage(Asset.Assets.btnSearch.image, for: .normal)
    }
    
    private lazy var plusButton = UIButton().then {
        $0.setImage(Asset.Assets.btnPlus.image, for: .normal)
    }
    
    private let filterView = FilterView()
    
    private lazy var recordTableView = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        RecordTableViewCell.register(target: $0)
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
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setupLayout() {
        view.addSubviews([navigationBar,
                          searchButton,
                          plusButton,
                          filterView,
                          recordTableView])
        
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.top).inset(6)
            make.trailing.equalTo(plusButton.snp.leading).offset(-1)
            make.width.height.equalTo(44)
        }
        
        plusButton.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.top).inset(6)
            make.trailing.equalTo(navigationBar.snp.trailing).inset(8)
            make.width.height.equalTo(44)
        }
        
        filterView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(77)
        }
        
        recordTableView.snp.makeConstraints { make in
            make.top.equalTo(filterView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Custom Method
    
    
}

// MARK: - UITableViewDelegate

extension MyRecordViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDelegate

extension MyRecordViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let recordCell = tableView.dequeueReusableCell(withIdentifier: RecordTableViewCell.className, for: indexPath) as? RecordTableViewCell else { return UITableViewCell() }
        return recordCell
    }
}
