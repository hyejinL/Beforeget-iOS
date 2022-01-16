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
    
    private var mediaData: String = ""
    private var starData: String = ""
    
    /// 서버한테 보내야 될 값들
    private var dateQuery: String = ""
    private var mediaQuery: String = ""
    private var starQuery: String = ""
    
    private let record = RecordMannager()
    
    private lazy var navigationBar = BDSNavigationBar(
        self, view: .record, isHidden: false)
    
    private lazy var searchButton = UIButton().then {
        $0.setImage(Asset.Assets.btnSearch.image, for: .normal)
    }
    
    private lazy var plusButton = UIButton().then {
        $0.setImage(Asset.Assets.btnPlus.image, for: .normal)
    }
    
    public lazy var filterView = FilterView().then {
        $0.dateDelegate = self
        $0.mediaDelegate = self
        $0.starDelegate = self
    }
    
    private lazy var recordTableView = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.separatorStyle = .none
        MyRecordTableViewCell.register(target: $0)
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
            make.height.equalTo(44)
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
}

// MARK: - UITableViewDelegate

extension MyRecordViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

// MARK: - UITableViewDelegate

extension MyRecordViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return record.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let recordCell = tableView.dequeueReusableCell(
            withIdentifier: MyRecordTableViewCell.className,
            for: indexPath) as? MyRecordTableViewCell
        else { return UITableViewCell() }
        recordCell.selectionStyle = .none
        recordCell.config(index: indexPath.item)
        return recordCell
    }
}

// MARK: - Custom Delegate

extension MyRecordViewController:
    DateFilterDelegate,
    MediaFilterDelegate,
    StarFilterDelegate,
    SendDataDelegate  {
    
    // MARK: - Custom Method
    
    private func presentFilterModal() {
        let filterModalViewController = FilterModalViewController()
        filterModalViewController.modalPresentationStyle = .overFullScreen
        filterModalViewController.sendDataDelegate = self
        present(filterModalViewController, animated: false, completion: nil)
    }
    
    public func clickDateButton() {
        presentFilterModal()
        print("기간버튼")
    }
    
    public func clickMediaButton() {
        /// 2번째 미디어 페이지로 바로 오픈해야 됨
        presentFilterModal()
        //        filterModalViewController.filterCollectionView.cellForItem(at: 1)
        print("미디어버튼")
    }
    
    public func clickStarButton() {
        /// 3번째 별점 페이지로 바로 오픈해야 됨
        presentFilterModal()
        print("스타버튼")
    }
    
    public func sendData(data: Int, media: [String], star: [String]) {
        // MARK: - FIXME
        /// 문제 : 미디어 부분에서 여러개 선택했을 때 설정처리 + 기간일 경우 int가 0부터 넘어옴..;;;
        /// 서버한테 넘겨주려고 변수를 만들어뒀습니다!
        /// 추후에 서버 통신 시 위 파라미터를 통해 값을 넘겨주면 됩니다!!!!
        print(data, media, star, "넘어온 값")
        
        filterView.dateButton.isSelected = (data == 0) ?
        false : true
        filterView.mediaButton.isSelected = (media == ["미디어"]) ?
        false : true
        filterView.starButton.isSelected = (star == ["별점"]) ?
        false : true
        
        mediaData = filterView.mediaButton.isSelected ?
        "\(media[0]) 외 \(media.count)" : "미디어"
        
        filterView.mediaButton.setTitle(mediaData, for: .normal)
        
        switch data {
        case 0: dateQuery = "14"
        case 1: dateQuery = "1"
        case 2: dateQuery = "3"
        default: dateQuery = "날짜"
        }
    }
}
