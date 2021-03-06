//
//  SongTableViewCell.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/14.
//

import UIKit

import SnapKit
import Then

class SongTableViewCell: UITableViewCell, UITableViewRegisterable {
    
    // MARK: - Dummy Data
    
    public var songArray: [String] = ["뭐가 되고 싶어 - 원슈타인"]

    // MARK: - Properties
    
    private var cellMargin: CGFloat = 47
    
    public var titleLabel = CellTitleLabel().then {
        $0.title = "OST"
    }
    
    public lazy var songListTableView = UITableView(frame: frame, style: .plain).then {
        $0.separatorStyle = .none
        $0.isScrollEnabled = false
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = .red
        SongListTableViewCell.register(target: $0)
    }
    
    // MARK: - Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
        setupLayout()
        contentView.layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        contentView.backgroundColor = .white
    }
    
    private func setupLayout() {
        contentView.addSubviews([titleLabel,
                                 songListTableView])
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(23)
        }
        
        songListTableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(cellMargin)
            make.height.equalTo(songArray.count*56)
        }
    }
    
    // MARK: - Custom Method

    public func config() {
       /// 문제 : 나중에 데이터 전달
    }
}

// MARK: - UITableViewDelegate

extension SongTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let songListCell = tableView.dequeueReusableCell(withIdentifier: SongListTableViewCell.className, for: indexPath) as? SongListTableViewCell else { return UITableViewCell() }
        songListCell.config(songArray[indexPath.row])
        return songListCell
    }
}
