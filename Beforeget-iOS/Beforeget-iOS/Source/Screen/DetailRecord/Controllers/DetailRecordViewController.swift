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
    
    // MARK: - Network
    
    private let myRecordAPI = MyRecordAPI.shared
    
    // MARK: - Dummy Data
    
    public var formatterDate = DateFormatter()
    
    private var linkString: String = "https://www.youtube.com/watch?v=qZFo0PYkHFo"
    
    public var myDetailRecordArray: [MyDetailRecord] = []
    public var myAdditionalArray = [DetailAdditional]()
    
    public var typeArray: [String] = []
    
    private var sectionArray: [DetailRecordSection] = [.comment, .comma, .line, .image]
    
    // MARK: - Properties
    
    public var postId = 0
    
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
        CommentDetailTableViewCell.register(target: $0)
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
        myRecordAPI.getMyDetailRecord(postId: postId) { data, err in
            guard let data = data else { return }
            self.myDetailRecordArray = data
            print(self.myDetailRecordArray,"통신 시작")
            self.recordTableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = true
        recordTableView.reloadData()
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
            // MARK: - FIMXE : 수정서버통신
            let viewController = DetailRecordEditPopupViewController()
            viewController.modalPresentationStyle = .overCurrentContext
            viewController.modalTransitionStyle = .crossDissolve
            self.present(viewController, animated: true, completion: nil)
        }
        let delete = UIAlertAction(title: "삭제", style: .default) { _ in
            // MARK: - FIXME : 삭제서버통신
            let viewController = DetailRecordDeletePopupViewController()
            viewController.modalPresentationStyle = .overCurrentContext
            viewController.modalTransitionStyle = .crossDissolve
            self.present(viewController, animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        optionMenu.addAction(edit)
        optionMenu.addAction(delete)
        optionMenu.addAction(cancel)
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    public func setupDate(_ date: String) -> String {
        formatterDate.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatterDate.timeZone = NSTimeZone(name: "UTD") as TimeZone?
        if let date = formatterDate.date(from: date) {
            return date.convertToString("yyyy. MM. dd E")
        } else {
            return ""
        }
    }
}

// MARK: - UITableViewDelegate

extension DetailRecordViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = DetailRecordHeaderView()
        myRecordAPI.getMyDetailRecord(postId: postId, completion: { data, err in
            guard let data = data else { return}
            data.forEach {
                headerView.titleLabel.text = $0.title
                let dateArray = $0.date.components(separatedBy: "-")
                headerView.dateLabel.text = "\(dateArray[0]). \(dateArray[1]). \(dateArray[2])"
                headerView.iconImageView.image =  MediaType.getIconImage(index: $0.category)
                headerView.reviewArray = $0.oneline
                headerView.reveiwTagCollectionView.reloadData()
                let starImage = $0.star
                switch starImage {
                case 1: return headerView.starImageView.image = Asset.Assets.btnStar1.image
                case 2: return headerView.starImageView.image = Asset.Assets.btnStar2.image
                case 3: return headerView.starImageView.image = Asset.Assets.btnStar3.image
                case 4: return headerView.starImageView.image = Asset.Assets.btnStar4.image
                default : return headerView.starImageView.image = Asset.Assets.btnStar5.image
                }
            }
        })
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = Asset.Colors.white.color
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UITableViewDataSource

extension DetailRecordViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let myRecordDetail = myRecordAPI.myDetailRecord?.data
        guard let myRecordDetail = myRecordDetail else { return 0 }
        
        if myRecordDetail[section].comment == "" {
            return myRecordDetail[section].additional.count
        } else {
            return myRecordDetail[section].additional.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let myRecordDetail = myRecordAPI.myDetailRecord?.data
        guard let myRecordDetail = myRecordDetail else { return UITableViewCell() }
        
        // MARK: - FIXME : 추후 과제 제출하고 수정합니다.
        if myRecordDetail[0].additional.isEmpty { // 추가 작성이 비어있는 경우
            if myRecordDetail[0].comment == "" {
                return UITableViewCell()
            } else {
                guard let commentCell = tableView.dequeueReusableCell(
                    withIdentifier: CommentDetailTableViewCell.className,
                    for: indexPath) as? CommentDetailTableViewCell
                else { return UITableViewCell() }
                commentCell.config(myRecordDetail[0].comment)
                commentCell.reloadInputViews()
                return commentCell
            }
            
        } else { // 추가 작성이 있는 경우
            if myRecordDetail[0].comment == "" { // 추가작성이 있는데 코멘트가 없는 경우
                if myRecordDetail[0].additional[indexPath.row].type == "명대사" ||
                    myRecordDetail[0].additional[indexPath.row].type == "인상 깊은 구절" {
                    guard let commaCell = tableView.dequeueReusableCell(
                        withIdentifier: CommaTableViewCell.className,
                        for: indexPath) as? CommaTableViewCell
                    else { return UITableViewCell() }
                    commaCell.config(myRecordDetail[0].additional[indexPath.row].type, quote: myRecordDetail[0].additional[indexPath.row].content)
                    return commaCell
                    
                } else if myRecordDetail[0].additional[indexPath.row].type == "표지" ||
                            myRecordDetail[0].additional[indexPath.row].type == "명장면" ||
                            myRecordDetail[0].additional[indexPath.row].type == "앨범커버" ||
                            myRecordDetail[0].additional[indexPath.row].type == "포스터" {
                    guard let imageCell = tableView.dequeueReusableCell(
                        withIdentifier: ImageTableViewCell.className,
                        for: indexPath) as? ImageTableViewCell
                    else { return UITableViewCell() }
                    imageCell.config(myRecordDetail[0].additional[indexPath.row].type,
                                     myRecordDetail[0].additional[indexPath.row].imgUrl1)
                    return imageCell
                    
                } else if myRecordDetail[0].additional[indexPath.row].type == "줄거리" ||
                            myRecordDetail[0].additional[indexPath.row].type == "가사" {
                    guard let textCell = tableView.dequeueReusableCell(
                        withIdentifier: TextTableViewCell.className,
                        for: indexPath) as? TextTableViewCell
                    else { return UITableViewCell() }
                    textCell.config(myRecordDetail[0].additional[indexPath.row].type,
                                    description: myRecordDetail[0].additional[indexPath.row].content)
                    return textCell
                    
                } else if myRecordDetail[0].additional[indexPath.row].type == "장르" ||
                            myRecordDetail[0].additional[indexPath.row].type == "카테고리" {
                    guard let genreCell = tableView.dequeueReusableCell(
                        withIdentifier: GenreTableViewCell.className,
                        for: indexPath) as? GenreTableViewCell
                    else { return UITableViewCell() }
                    return genreCell
                    
                } else if myRecordDetail[0].additional[indexPath.row].type == "OST" ||
                            myRecordDetail[0].additional[indexPath.row].type == "앨범" {
                    guard let songCell = tableView.dequeueReusableCell(
                        withIdentifier: SongTableViewCell.className,
                        for: indexPath) as? SongTableViewCell
                    else { return UITableViewCell() }
                    songCell.layoutIfNeeded()
                    songCell.songListTableView.contentSize.height = CGFloat(songCell.songArray.count*56)
                    return songCell
                    
                } else if myRecordDetail[0].additional[indexPath.row].type == "링크" {
                    guard let linkCell = tableView.dequeueReusableCell(
                        withIdentifier: LinkTableViewCell.className,
                        for: indexPath) as? LinkTableViewCell
                    else { return UITableViewCell() }
                    linkCell.linkButtonDelegate = self
                    linkCell.config(myRecordDetail[0].additional[indexPath.row-1].content)
                    return linkCell
                } else if myRecordDetail[0].additional[indexPath.row].type == "타임스탬프" {
                    guard let stampCell = tableView.dequeueReusableCell(
                        withIdentifier: StampTableViewCell.className,
                        for: indexPath) as? StampTableViewCell
                    else { return UITableViewCell() }
                    return stampCell
                    
                } else {
                    guard let lineCell = tableView.dequeueReusableCell(
                        withIdentifier: LineTableViewCell.className,
                        for: indexPath) as? LineTableViewCell
                    else { return UITableViewCell() }
                    lineCell.config(myRecordDetail[0].additional[indexPath.row].type,
                                    description: myRecordDetail[0].additional[indexPath.row].content)
                    return lineCell
                }
                
            } else { // 추가작성이 있는데 코멘트가 있는 경우
                if indexPath.row == 0  {
                    guard let commentCell = tableView.dequeueReusableCell(
                        withIdentifier: CommentDetailTableViewCell.className,
                        for: indexPath) as? CommentDetailTableViewCell
                    else { return UITableViewCell() }
                    commentCell.config(myRecordDetail[0].comment)
                    commentCell.reloadInputViews()
                    return commentCell
                    
                } else {
                    if myRecordDetail[0].additional[indexPath.row-1].type == "명대사" ||
                        myRecordDetail[0].additional[indexPath.row-1].type == "인상 깊은 구절" {
                        guard let commaCell = tableView.dequeueReusableCell(
                            withIdentifier: CommaTableViewCell.className,
                            for: indexPath) as? CommaTableViewCell
                        else { return UITableViewCell() }
                        commaCell.config(myRecordDetail[0].additional[indexPath.row-1].type, quote: myRecordDetail[0].additional[indexPath.row-1].content)
                        return commaCell
                        
                    } else if myRecordDetail[0].additional[indexPath.row-1].type == "표지" ||
                                myRecordDetail[0].additional[indexPath.row-1].type == "명장면" ||
                                myRecordDetail[0].additional[indexPath.row-1].type == "앨범커버" ||
                                myRecordDetail[0].additional[indexPath.row-1].type == "포스터" {
                        guard let imageCell = tableView.dequeueReusableCell(
                            withIdentifier: ImageTableViewCell.className,
                            for: indexPath) as? ImageTableViewCell
                        else { return UITableViewCell() }
                        imageCell.config(myRecordDetail[0].additional[indexPath.row-1].type,
                                         myRecordDetail[0].additional[indexPath.row-1].imgUrl1)
                        return imageCell
                        
                    } else if myRecordDetail[0].additional[indexPath.row-1].type == "줄거리" ||
                                myRecordDetail[0].additional[indexPath.row-1].type == "가사" {
                        guard let textCell = tableView.dequeueReusableCell(
                            withIdentifier: TextTableViewCell.className,
                            for: indexPath) as? TextTableViewCell
                        else { return UITableViewCell() }
                        textCell.config(myRecordDetail[0].additional[indexPath.row-1].type,
                                        description: myRecordDetail[0].additional[indexPath.row-1].content)
                        return textCell
                        
                    } else if myRecordDetail[0].additional[indexPath.row-1].type == "장르" ||
                                myRecordDetail[0].additional[indexPath.row-1].type == "카테고리" {
                        guard let genreCell = tableView.dequeueReusableCell(
                            withIdentifier: GenreTableViewCell.className,
                            for: indexPath) as? GenreTableViewCell
                        else { return UITableViewCell() }
                        return genreCell
                        
                    } else if myRecordDetail[0].additional[indexPath.row-1].type == "OST" ||
                                myRecordDetail[0].additional[indexPath.row-1].type == "앨범" {
                        guard let songCell = tableView.dequeueReusableCell(
                            withIdentifier: SongTableViewCell.className,
                            for: indexPath) as? SongTableViewCell
                        else { return UITableViewCell() }
                        songCell.layoutIfNeeded()
                        songCell.songListTableView.contentSize.height = CGFloat(songCell.songArray.count*56)
                        return songCell
                        
                    } else if myRecordDetail[0].additional[indexPath.row-1].type == "링크" {
                        guard let linkCell = tableView.dequeueReusableCell(
                            withIdentifier: LinkTableViewCell.className,
                            for: indexPath) as? LinkTableViewCell
                        else { return UITableViewCell() }
                        linkCell.linkButtonDelegate = self
                        linkCell.config(myRecordDetail[0].additional[indexPath.row-1].content)
                        return linkCell
                    } else if myRecordDetail[0].additional[indexPath.row-1].type == "타임스탬프" {
                        guard let stampCell = tableView.dequeueReusableCell(
                            withIdentifier: StampTableViewCell.className,
                            for: indexPath) as? StampTableViewCell
                        else { return UITableViewCell() }
                        return stampCell
                        
                    } else {
                        guard let lineCell = tableView.dequeueReusableCell(
                            withIdentifier: LineTableViewCell.className,
                            for: indexPath) as? LineTableViewCell
                        else { return UITableViewCell() }
                        lineCell.config(myRecordDetail[0].additional[indexPath.row-1].type,
                                        description: myRecordDetail[0].additional[indexPath.row-1].content)
                        return lineCell
                    }
                }
            }
        }
        
        //
        //        guard let detailSection = DetailRecordSection(rawValue: indexPath.row)
        //        else { return UITableViewCell() }
        //
        //            switch detailSection {
        //            case .comment:
        //                guard let commentCell = tableView.dequeueReusableCell(
        //                    withIdentifier: CommentDetailTableViewCell.className,
        //                    for: indexPath) as? CommentDetailTableViewCell
        //                else { return UITableViewCell() }
        //                commentCell.config(myRecordDetail[indexPath.row].comment)
        //                commentCell.reloadInputViews()
        //                return commentCell
        //
        //            case .image:
        //                guard let imageCell = tableView.dequeueReusableCell(
        //                    withIdentifier: ImageTableViewCell.className,
        //                    for: indexPath) as? ImageTableViewCell
        //                else { return UITableViewCell() }
        //                imageCell.config(myRecordDetail[indexPath.row].additional[indexPath.row].type,
        //                                 myRecordDetail[indexPath.row].additional[indexPath.row].imgUrl1)
        //                return imageCell
        //
        //            case .comma:
        //                guard let commaCell = tableView.dequeueReusableCell(
        //                    withIdentifier: CommaTableViewCell.className,
        //                    for: indexPath) as? CommaTableViewCell
        //                else { return UITableViewCell() }
        //                //            commaCell.config(indexPath.row)
        //                return commaCell
        //
        //            case .genre:
        //                guard let genreCell = tableView.dequeueReusableCell(
        //                    withIdentifier: GenreTableViewCell.className,
        //                    for: indexPath) as? GenreTableViewCell
        //                else { return UITableViewCell() }
        //                return genreCell
        //
        //            case .text:
        //                guard let textCell = tableView.dequeueReusableCell(
        //                    withIdentifier: TextTableViewCell.className,
        //                    for: indexPath) as? TextTableViewCell
        //                else { return UITableViewCell() }
        //                //            textCell.config(indexPath.row)
        //                return textCell
        //
        //            case .song:
        //                guard let songCell = tableView.dequeueReusableCell(
        //                    withIdentifier: SongTableViewCell.className,
        //                    for: indexPath) as? SongTableViewCell
        //                else { return UITableViewCell() }
        //                songCell.layoutIfNeeded()
        //                songCell.songListTableView.contentSize.height = CGFloat(songCell.songArray.count*56)
        //                return songCell
        //
        //            case .line:
        //                guard let lineCell = tableView.dequeueReusableCell(
        //                    withIdentifier: LineTableViewCell.className,
        //                    for: indexPath) as? LineTableViewCell
        //                else { return UITableViewCell() }
        //                //            lineCell.config(indexPath.row)
        //                return lineCell
        //
        //            case .link:
        //                guard let linkCell = tableView.dequeueReusableCell(
        //                    withIdentifier: LinkTableViewCell.className,
        //                    for: indexPath) as? LinkTableViewCell
        //                else { return UITableViewCell() }
        //                linkCell.linkButtonDelegate = self
        //                //            linkCell.config(<#T##link: String##String#>)
        //                return linkCell
        //
        //            case .stamp:
        //                guard let stampCell = tableView.dequeueReusableCell(
        //                    withIdentifier: StampTableViewCell.className,
        //                    for: indexPath) as? StampTableViewCell
        //                else { return UITableViewCell() }
        //                return stampCell
        //            }
        //
        //        if myRecordDetail[0].comment == "" {
        //
        //            return UITableViewCell()
        //
        //        } else {
        //            guard let commentCell = tableView.dequeueReusableCell(
        //                withIdentifier: CommentDetailTableViewCell.className,
        //                for: indexPath) as? CommentDetailTableViewCell
        //            else { return UITableViewCell() }
        //            commentCell.prepareForReuse()
        //            commentCell.config(myRecordDetail[indexPath.row].comment)
        //            return commentCell
        //        }
        //
    }
}
