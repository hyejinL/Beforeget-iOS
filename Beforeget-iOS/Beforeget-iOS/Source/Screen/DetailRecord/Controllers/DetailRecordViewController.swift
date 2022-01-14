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
    
    private var sectionArray: [DetailRecordSection] = [.comment, .image, .comma, .genre]
    
    private lazy var navigationBar = BDSNavigationBar(self, view: .none, isHidden: false).then {
        $0.backButton.setImageTintColor(.white)
        $0.backgroundColor = Asset.Colors.black200.color
    }
    
    private lazy var buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 1
        $0.distribution = .fillEqually
        $0.addArrangedSubviews([downloadButton,
                                menuButton])
    }
    
    private lazy var downloadButton = UIButton(type: .system).then {
        $0.setImage(Asset.Assets.btnDownload.image, for: .normal)
        $0.setImageTintColor(.white)
    }
    
    private lazy var menuButton = UIButton(type: .system).then {
        $0.setImage(Asset.Assets.btnDetail.image, for: .normal)
        $0.setImageTintColor(.white)
    }
    
    private lazy var recordTableView = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.separatorStyle = .none
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
        navigationController?.isNavigationBarHidden = true
        setupStatusBar(Asset.Colors.black200.color)
    }
    
    private func setupLayout() {
        view.addSubviews([navigationBar,
                          buttonStackView,
                          recordTableView])

        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.top)
            make.trailing.equalToSuperview().inset(8)
            make.height.equalTo(44)
        }

        recordTableView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Custom Method



}

// MARK: - UITableViewDelegate

extension DetailRecordViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource

extension DetailRecordViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = DetailRecordSection(rawValue: indexPath.row)
        else { return UITableViewCell() }
        
        switch section {
        case .comment:
            guard let commentCell = tableView.dequeueReusableCell(
                withIdentifier: CommentTableViewCell.className,
                for: indexPath) as? CommentTableViewCell
            else { return UITableViewCell() }
            return commentCell
        case .image:
            guard let commentCell = tableView.dequeueReusableCell(
                withIdentifier: ImageTableViewCell.className,
                for: indexPath) as? ImageTableViewCell
            else { return UITableViewCell() }
            return commentCell
        case .comma:
            guard let commentCell = tableView.dequeueReusableCell(
                withIdentifier: CommaTableViewCell.className,
                for: indexPath) as? CommaTableViewCell
            else { return UITableViewCell() }
            return commentCell
        case .genre:
            guard let commentCell = tableView.dequeueReusableCell(
                withIdentifier: GenreTableViewCell.className,
                for: indexPath) as? GenreTableViewCell
            else { return UITableViewCell() }
            return commentCell
        case .text:
            guard let commentCell = tableView.dequeueReusableCell(
                withIdentifier: TextTableViewCell.className,
                for: indexPath) as? TextTableViewCell
            else { return UITableViewCell() }
            return commentCell
        case .song:
            guard let commentCell = tableView.dequeueReusableCell(
                withIdentifier: SongTableViewCell.className,
                for: indexPath) as? SongTableViewCell
            else { return UITableViewCell() }
            return commentCell
        case .line:
            guard let commentCell = tableView.dequeueReusableCell(
                withIdentifier: LineTableViewCell.className,
                for: indexPath) as? LineTableViewCell
            else { return UITableViewCell() }
            return commentCell
        case .link:
            guard let commentCell = tableView.dequeueReusableCell(
                withIdentifier: LinkTableViewCell.className,
                for: indexPath) as? LinkTableViewCell
            else { return UITableViewCell() }
            return commentCell
        case .stamp:
            guard let commentCell = tableView.dequeueReusableCell(
                withIdentifier: StampTableViewCell.className,
                for: indexPath) as? StampTableViewCell
            else { return UITableViewCell() }
            return commentCell
        }
        
       
    }
}
