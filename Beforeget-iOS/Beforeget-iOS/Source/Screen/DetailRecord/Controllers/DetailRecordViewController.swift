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
    
    private var linkString: String = "https://www.youtube.com/watch?v=qZFo0PYkHFo"
    
    public var myRecordArray: [MyDetailRecord] = []
    public var myAdditionalArray: [Additional] = []
    public var typeArray: [String] = []
    
    private var sectionArray: [DetailRecordSection] = []
        
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
        // MARK: - FIXME 답이 없다...
        print(self.postId,"들어와?")
        myRecordAPI.getMyDetailRecord(postId: postId) { data, err in
            guard let data = data else { return }
            self.myRecordArray = data
            print(self.myRecordArray,"아ㅏㅏ")
            self.recordTableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = Asset.Colors.white.color
        setupStatusBar(Asset.Colors.black200.color)
        myRecordAPI.getMyDetailRecord(postId: postId) { data, err in
            guard let data = data else { return }
            self.recordTableView.reloadData()
        }
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
                headerView.dateLabel.text = $0.date
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
        let myRecordDetail = myRecordAPI.myDetailRecord?.data
//        myRecordDetail[section].add
//        myRecordDetail[section].comment
        guard let myRecordDetail = myRecordDetail else { return 0 }
        guard let additionalArray = myRecordDetail[section].additional else {
            print("안들어옴")
            return 0 }
        
        let myComment = myRecordDetail[section].comment
        guard let myComment = myComment else { print("안들어옴")
            return 1 }
        print(myComment)
        
                
        if myComment == "" {
            return 1 + additionalArray.count
        } else {
            return 1 + additionalArray.count
        }
        
//
//        guard let comment = myRecordDetail[section].comment else { return 0 }
//
//
////        typeArray = additionalArray[section]
//        print(myRecordDetail, "????????????")
//        print(comment, "코멘트ㅡㅡㅡㅡㅡㅡ")
//        print(addArray, additionalArray.count, "개수@@@@@@@@@@@@@@@@", typeArray.count)
//
//        dump(additionalArray)
//        print("#################################")
//        print(myRecordDetail[section].comment, "코멘트잇니")
//
//        if myRecordDetail[section].comment == nil || myRecordDetail[section].comment == "" {
//            return 1 + additionalArray.count
//        } else {
//            return additionalArray.count
//        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let detailSection = DetailRecordSection(rawValue: indexPath.row)
        else { return UITableViewCell() }
        
        let myRecordDetail = myRecordAPI.myDetailRecord?.data
        guard let myRecordDetail = myRecordDetail else { return UITableViewCell() }
        guard let additionalArray = myRecordDetail[indexPath.section].additional else { return UITableViewCell() }
        
        

        dump(additionalArray)
        print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
        dump(typeArray)
        
        
        
        switch detailSection {
        case .comment:
            guard let commentCell = tableView.dequeueReusableCell(
                withIdentifier: CommentDetailTableViewCell.className,
                for: indexPath) as? CommentDetailTableViewCell
            else { return UITableViewCell() }
            commentCell.config(indexPath.row)
            commentCell.reloadInputViews()
            return commentCell
            
        case .image:
            guard let imageCell = tableView.dequeueReusableCell(
                withIdentifier: ImageTableViewCell.className,
                for: indexPath) as? ImageTableViewCell
            else { return UITableViewCell() }
//            imageCell.config(indexPath.row)
            return imageCell
            
        case .comma:
            guard let commaCell = tableView.dequeueReusableCell(
                withIdentifier: CommaTableViewCell.className,
                for: indexPath) as? CommaTableViewCell
            else { return UITableViewCell() }
//            commaCell.config(indexPath.row)
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
//            textCell.config(indexPath.row)
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
//            lineCell.config(indexPath.row)
            return lineCell
            
        case .link:
            guard let linkCell = tableView.dequeueReusableCell(
                withIdentifier: LinkTableViewCell.className,
                for: indexPath) as? LinkTableViewCell
            else { return UITableViewCell() }
            linkCell.linkButtonDelegate = self
//            linkCell.config(indexPath.row)
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

// MARK: - Enum

extension DetailRecordViewController {
    
    public enum AddType: CustomStringConvertible, CaseIterable {
        case 명대사, 인상깊은구절
        case 줄거리, 가사, 방송사OTT
        case 포스터, 표지, 명장면, 앨범커버
        case 장르, 카테고리
        case OST, 앨범
        case 감독, 배우, 가수, 작가, 요일, 플랫폼, 채널, 출판사
        case 링크
        case 타임스탬프
        
        public var description: String {
            switch self {
            case .명대사: return "명대사"
            case .인상깊은구절: return "인상 깊은 구절"
            case .줄거리: return "줄거리"
            case .가사: return "가사"
            case .방송사OTT: return "방송사(OTT)"
            case .포스터: return "포스터"
            case .표지: return "표지"
            case .명장면: return "명장면"
            case .앨범커버: return "앨범커버"
            case .장르: return "장르"
            case .카테고리: return "카테고리"
            case .앨범: return "앨범"
            case .감독: return "감독"
            case .배우: return "배우"
            case .가수: return "가수"
            case .작가: return "작가"
            case .요일: return "요일"
            case .플랫폼: return "플랫폼"
            case .채널: return "채널"
            case .출판사: return "출판사"
            case .링크: return "링크"
            case .타임스탬프: return "타임스탬프"
            case .OST: return "OST"
            }
        }
        
        public var type: DetailRecordSection {
            switch self {
            case .명대사: return .comment
            case .인상깊은구절: return .comment
            case .줄거리: return .text
            case .가사: return .text
            case .방송사OTT: return .line
            case .포스터: return .image
            case .표지: return .image
            case .명장면: return .image
            case .앨범커버: return .image
            case .장르: return .genre
            case .카테고리: return .genre
            case .OST: return .song
            case .앨범: return .song
            case .감독: return .line
            case .배우: return .line
            case .가수: return .line
            case .작가: return .line
            case .요일: return .line
            case .플랫폼: return .line
            case .채널: return .line
            case .출판사: return .line
            case .링크: return .link
            case .타임스탬프: return .stamp
            }
        }
        
        func getCellType() -> UITableViewCell {
            switch self {
            case .명대사: return CommentDetailTableViewCell()
            case .인상깊은구절: return CommentDetailTableViewCell()
            case .줄거리: return TextTableViewCell()
            case .가사: return TextTableViewCell()
            case .방송사OTT: return LineTableViewCell()
            case .포스터: return ImageTableViewCell()
            case .표지: return ImageTableViewCell()
            case .명장면: return ImageTableViewCell()
            case .앨범커버: return ImageTableViewCell()
            case .장르: return GenreTableViewCell()
            case .카테고리: return GenreTableViewCell()
            case .OST: return SongTableViewCell()
            case .앨범: return SongTableViewCell()
            case .감독: return LineTableViewCell()
            case .배우: return LineTableViewCell()
            case .가수: return LineTableViewCell()
            case .작가: return LineTableViewCell()
            case .요일: return LineTableViewCell()
            case .플랫폼: return LineTableViewCell()
            case .채널: return LineTableViewCell()
            case .출판사: return LineTableViewCell()
            case .링크: return LinkTableViewCell()
            case .타임스탬프: return StampTableViewCell()
            }
        }
    }
}
