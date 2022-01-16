//
//  DetailRecordViewController.swift
//  Beforeget-iOS
//
//  Created by Thisisme Hi on 2022/01/14.
//

import UIKit

import SafariServices
import SnapKit
import Then

final class DetailRecordViewController: UIViewController, LinkButtonDelegate {
    
    // MARK: - Dummy Data
    
    private var linkString: String = "https://www.youtube.com/watch?v=qZFo0PYkHFo"
    
    private var sectionArray: [DetailRecordSection] = [
        .comment, .image, .comma,
        .genre, .text, .song,
        .line, .link, .stamp
    ]
    
    // MARK: - Properties
    
    private lazy var navigationBar = BDSNavigationBar(
        self, view: .none, isHidden: false).then {
            $0.backButton.setImageTintColor(.white)
            $0.backgroundColor = Asset.Colors.black200.color
        }
    
    private let backView = UIView().then {
        $0.backgroundColor = Asset.Colors.black200.color
    }
    
    private lazy var buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 1
        $0.distribution = .fillEqually
        $0.addArrangedSubviews([shareButton,
                                menuButton])
    }
    
    private lazy var shareButton = UIButton(type: .system).then {
        $0.setImage(Asset.Assets.btnShare.image, for: .normal)
        $0.setImageTintColor(.white)
    }
    
    private lazy var menuButton = UIButton(type: .system).then {
        $0.setImage(Asset.Assets.btnDetail.image, for: .normal)
        $0.setImageTintColor(.white)
        $0.addTarget(self, action: #selector(touchupMenuButton(_:)), for: .touchUpInside)
    }
    
    private lazy var recordTableView = UITableView(frame: .zero, style: .grouped).then {
        $0.backgroundColor = Asset.Colors.white.color
        $0.delegate = self
        $0.dataSource = self
        $0.separatorStyle = .none
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = Asset.Colors.white.color
        setupStatusBar(Asset.Colors.black200.color)
    }
    
    private func setupLayout() {
        view.addSubviews([navigationBar,
                          backView,
                          buttonStackView,
                          recordTableView])
        
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        backView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(recordTableView.snp.top)
            make.height.equalTo(0)
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
    
    func clickLinkButton(url: NSURL) {
        let safariView: SFSafariViewController = SFSafariViewController(url: url as URL)
        self.present(safariView, animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            recordTableView.backgroundColor = Asset.Colors.black200.color
        } else {
            recordTableView.backgroundColor = Asset.Colors.white.color
        }
    }
    
    // MARK: - @objc
    
    @objc func touchupMenuButton(_ sender: UIButton) {
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let edit = UIAlertAction(title: "수정", style: .default) { _ in
            // MARK: - FIXME
            //  수정하기 -> 글쓰기 화면으로 넘어가야 함
        }
        let delete = UIAlertAction(title: "삭제", style: .default) { _ in
            // MARK: - FIXME
            // 삭제하기 -> 내 기록에서 삭제가 되어야 함
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        optionMenu.addAction(edit)
        optionMenu.addAction(delete)
        optionMenu.addAction(cancel)
        self.present(optionMenu, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate

extension DetailRecordViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = DetailRecordHeaderView()
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension + 47
    }
}

// MARK: - UITableViewDataSource

extension DetailRecordViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let detailSection = DetailRecordSection(rawValue: indexPath.row)
        else { return UITableViewCell() }
        
        switch detailSection {
        case .comment:
            guard let commentCell = tableView.dequeueReusableCell(
                withIdentifier: CommentTableViewCell.className,
                for: indexPath) as? CommentTableViewCell
            else { return UITableViewCell() }
            return commentCell
            
        case .image:
            guard let imageCell = tableView.dequeueReusableCell(
                withIdentifier: ImageTableViewCell.className,
                for: indexPath) as? ImageTableViewCell
            else { return UITableViewCell() }
            return imageCell
            
        case .comma:
            guard let commaCell = tableView.dequeueReusableCell(
                withIdentifier: CommaTableViewCell.className,
                for: indexPath) as? CommaTableViewCell
            else { return UITableViewCell() }
            return commaCell
            
        case .genre:
            guard let genreCell = tableView.dequeueReusableCell(
                withIdentifier: GenreTableViewCell.className,
                for: indexPath) as? GenreTableViewCell
            else { return UITableViewCell() }
            return genreCell
            
        case .text:
            guard let textCell = tableView.dequeueReusableCell(
                withIdentifier: TextTableViewCell.className,
                for: indexPath) as? TextTableViewCell
            else { return UITableViewCell() }
            return textCell
            
        case .song:
            guard let songCell = tableView.dequeueReusableCell(
                withIdentifier: SongTableViewCell.className,
                for: indexPath) as? SongTableViewCell
            else { return UITableViewCell() }
            songCell.layoutIfNeeded()
            songCell.songListTableView.contentSize.height = CGFloat(songCell.songArray.count*56)
            return songCell
            
        case .line:
            guard let lineCell = tableView.dequeueReusableCell(
                withIdentifier: LineTableViewCell.className,
                for: indexPath) as? LineTableViewCell
            else { return UITableViewCell() }
            return lineCell
            
        case .link:
            guard let linkCell = tableView.dequeueReusableCell(
                withIdentifier: LinkTableViewCell.className,
                for: indexPath) as? LinkTableViewCell
            else { return UITableViewCell() }
            linkCell.linkButtonDelegate = self
            linkCell.config(linkString)
            return linkCell
            
        case .stamp:
            guard let stampCell = tableView.dequeueReusableCell(
                withIdentifier: StampTableViewCell.className,
                for: indexPath) as? StampTableViewCell
            else { return UITableViewCell() }
            return stampCell
        }
    }
}
