//
//  DetailRecordViewController.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/14.
//

import UIKit

import SnapKit
import Then

final class DetailRecordViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var navigationBar = BDSNavigationBar(self, view: .none, isHidden: false)
    
    private lazy var downloadButton = UIButton(type: .system).then {
        $0.setImage(Asset.Assets.btnDownload.image, for: .normal)
    }
    
    private lazy var menuButton = UIButton(type: .system).then {
        $0.setImage(Asset.Assets.btnDetail.image, for: .normal)
    }
    
    private lazy var recordTableView = UITableView(frame: .zero, style: .plain).then {
        $0.delegate = self
        $0.dataSource = self
        TopTableViewCell.register(target: $0)
        ReviewTableViewCell.register(target: $0)
        CommentTableViewCell.register(target: $0)
        ImageTableViewCell.register(target: $0)
        CommaTableViewCell.register(target: $0)
        GenreTableViewCell.register(target: $0)
        TextTableViewCell.register(target: $0)
        SongTableViewCell.register(target: $0)
        LineTableViewCell.register(target: $0)
        LinkTableViewCell.register(target: $0)
        StampTableViewCell.register(target: $0)
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
        
    }
    
    // MARK: - Custom Method


}

// MARK: - UITableViewDelegate

extension DetailRecordViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource

extension DetailRecordViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
