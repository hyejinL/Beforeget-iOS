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
    
    private var songArray: [String] = ["소코도모 - 인생은 회전목마", "잔나비 - 꿈과 책과 힘과 벽과 개발과 코딩"]

    // MARK: - Properties
    
    private var cellMargin: CGFloat = 47
    
    public var titleLabel = CellTitleLabel().then {
        $0.title = "노래제목"
    }
    
    private lazy var songTableView = UITableView(frame: frame, style: .plain).then {
        $0.separatorStyle = .none
        $0.isScrollEnabled = false
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = .yellow
        SongListTableViewCell.register(target: $0)
    }
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        contentView.backgroundColor = .red
    }
    
    private func setupLayout() {
        contentView.addSubviews([titleLabel,
                                 songTableView])
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
        }
        
        songTableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(cellMargin)
        }
    }
    
    // MARK: - Custom Method

    public func setData() {
       /// 문제 : 나중에 데이터 전달
    }
}

// MARK: - UITableViewDelegate

extension SongTableViewCell: UITableViewDelegate {
    
}

// MARK: - UITableViewDelegate

extension SongTableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let songListCell = tableView.dequeueReusableCell(withIdentifier: SongListTableViewCell.className, for: indexPath) as? SongListTableViewCell else { return UITableViewCell() }
//        songListCell.setData(songArray[indexPath.item])
        return songListCell
    }
}
