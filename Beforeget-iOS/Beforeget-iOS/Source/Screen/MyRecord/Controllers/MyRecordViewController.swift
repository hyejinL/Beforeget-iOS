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
    
    // MARK: - Network
    
    private let myRecordAPI = MyRecordAPI.shared
    
    // MARK: - Properties
    
    public var mediaID = -1
        
    private var recordArray: [MyRecord] = []
    
    /// 여기에 필터 선택 시에 전달된 데이터가 저장되어서 디테일뷰로 이동
    private var storedDate: String = ""
    private var storedMedia: String = ""
    private var storedStar: String = ""
    
    private var mediaData: String = ""
    private var starData: String = ""
    
    var selectedDateIndex: Int = -1
    var selectedMediaArray: [String] = []
    var selectedStarArray: [Int] = []
        
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
        MyRecordEmptyTableViewCell.register(target: $0)
        MyRecordTableViewCell.register(target: $0)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
        myRecordAPI.getMyRecord { data, err in
            guard let data = data else { return }
            self.recordArray = data
            DispatchQueue.main.async {
                self.recordTableView.reloadData()
            }
//            self.myRecordAPI.getMyRecordFilter(date: "-1", media: "\(self.mediaID)", star: "-1") { data, err in
//
//            }
        }
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = Asset.Colors.white.color
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
            make.top.equalTo(navigationBar.snp.top)
            make.trailing.equalTo(plusButton.snp.leading).offset(-1)
            make.width.height.equalTo(44)
        }
        
        plusButton.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.top)
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
        let detailRecordViewController = DetailRecordViewController()
        detailRecordViewController.postId = self.recordArray[indexPath.row].id
        
//        myRecordAPI.getMyRecordFilter(date: storedDate, media: storedMedia, star: storedStar) { filteredData, err in
//            // MARK: - 이 포스트아이디에는 필터링된 후 리로드 된 테이블뷰의 데이터의 id가 들어가져야 한다.
//            guard let filteredData = filteredData else { return }
//            detailRecordViewController.postId = filteredData[indexPath.row].id
//        }
        navigationController?.pushViewController(detailRecordViewController, animated: true)
    }
}

// MARK: - UITableViewDelegate

extension MyRecordViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let myRecord = myRecordAPI.myRecord?.data
        guard let myRecord = myRecord else { return 0 }
        if myRecord.isEmpty {
            return 1
        } else {
            return myRecord.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myRecord = myRecordAPI.myRecord?.data
        guard let myRecord = myRecord else { return UITableViewCell() }
        if myRecord.isEmpty {
            guard let emptyCell = tableView.dequeueReusableCell(
                withIdentifier: MyRecordEmptyTableViewCell.className,
                for: indexPath) as? MyRecordEmptyTableViewCell
            else { return UITableViewCell() }
            emptyCell.selectionStyle = .none
            return emptyCell
            
        } else {
            guard let recordCell = tableView.dequeueReusableCell(
                withIdentifier: MyRecordTableViewCell.className,
                for: indexPath) as? MyRecordTableViewCell
            else { return UITableViewCell() }
            recordCell.selectionStyle = .none
            recordCell.config(index: indexPath.row)
            return recordCell
        }
    }
}

// MARK: - Custom Delegate

extension MyRecordViewController:
    DateFilterDelegate,
    MediaFilterDelegate,
    StarFilterDelegate,
    SendDataDelegate  {
        
    private func presentFilterModal() {
        let filterModalViewController = FilterModalViewController()
        filterModalViewController.modalPresentationStyle = .overFullScreen
        filterModalViewController.sendDataDelegate = self
        filterModalViewController.selectedDateIndex = selectedDateIndex
        filterModalViewController.selectedMediaArray = selectedMediaArray
        filterModalViewController.selectedStarArray = selectedStarArray
        present(filterModalViewController, animated: false, completion: nil)
    }
    
    public func clickDateButton() {
        // MARK: - FIXME
        presentFilterModal()
    }
    
    public func clickMediaButton() {
        // MARK: - FIXME
        /// 2번째 미디어 페이지로 바로 오픈해야 됨
        presentFilterModal()
    }
    
    public func clickStarButton() {
        // MARK: - FIXME
        /// 3번째 별점 페이지로 바로 오픈해야 됨
        presentFilterModal()
    }
    
    public func sendData(date: [String], data: Int, media: [String], star: [Int]) {
        var dateString = date.joined(separator: ",")
        var mediaString = media.joined(separator: ",")
        var mediaArray: [String] = []
        mediaArray.append(mediaString)
        
        media.forEach {
            if $0 == "Movie" {
                mediaString = "1"
                mediaArray.append(mediaString)
            } else if $0 == "Book" {
                mediaString = "2"
                mediaArray.append(mediaString)
            } else if $0 == "TV" {
                mediaString = "3"
                mediaArray.append(mediaString)
            } else if $0 == "Music" {
                mediaString = "4"
                mediaArray.append(mediaString)
            } else if $0 == "Webtoon" {
                mediaString = "5"
                mediaArray.append(mediaString)
            } else if $0 == "Youtube" {
                mediaString = "6"
                mediaArray.append(mediaString)
            }
        }
        mediaArray.removeFirst()
        
        let mediaInt = mediaArray.joined(separator: ",")
        let starArray = star.map { String($0) }
        var starString = starArray.joined(separator: ",")

        if data == 0 {
            dateString = "0"
        } else if data == 1 {
            dateString = "1"
        } else if data == 2 {
            dateString = "2"
        } else if data == -1 {
            dateString = "-1"
        }
        
        if media.isEmpty {
            mediaString = "-1"
        }
        
        if star.isEmpty {
            starString = "-1"
        }
//
//        storedDate = dateString
//        storedMedia = mediaInt
//        storedStar = starString
        
        myRecordAPI.getMyRecordFilter(date: dateString, media: mediaInt, star: starString) { data, err in
            print("넘어온 값", dateString, mediaInt, starString)
            self.recordTableView.reloadData()
            
        }
                
        filterView.dateButton.isSelected = (data == -1) ?
        false : true
        
        filterView.mediaButton.isSelected = (media == ["미디어"]) ?
        false : true
        
        filterView.starButton.isSelected = (star == []) ?
        false : true

        if filterView.mediaButton.isSelected {
            if media.isEmpty {
                mediaData = "미디어"
                filterView.mediaButton.isSelected = false
            } else if media.count == 1 {
                mediaData = "\(media[0])"
            } else {
                mediaData = "\(media[0]) 외 \(media.count-1)"
            }
        } else {
            mediaData = "미디어"
        }
                
        filterView.mediaButton.setTitle(mediaData, for: .normal)
        selectedDateIndex = data
        selectedMediaArray = media
        selectedStarArray = star
    }
}
