//
//  MyRecordViewController.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/07.
//

import UIKit

import SnapKit
import Then
import CoreMedia

final class MyRecordViewController: UIViewController {
    
    // MARK: - Network
    
    private let myRecordAPI = MyRecordAPI.shared
    
    // MARK: - Properties
    
    private var recordArray: [MyRecord] = []
    
    private var mediaData: String = ""
    private var starData: String = ""
    
    /// 서버한테 보내야 될 값들
    private var dateQuery: String = ""
    private var mediaQuery: String = ""
    private var starQuery: String = ""
    
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
            self.recordTableView.reloadData()
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
        navigationController?.pushViewController(detailRecordViewController, animated: true)
    }
}

// MARK: - UITableViewDelegate

extension MyRecordViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordArray.count
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
        // MARK: - FIXME
        /// 서버한테 넘겨주려고 변수를 만들어뒀습니다!
        /// 추후에 서버 통신 시 위 파라미터를 통해 값을 넘겨주면 됩니다!!!!
        
        
        var dateString = date.joined(separator: ",")
        print(dateString)
        
        var mediaString = media.joined(separator: ",")
        
        let starArray = star.map { String($0) }
        var starString = starArray.joined(separator: ",")

        if data == 0 {
            dateString = "0"
        } else if data == 1 {
            dateString = "1"
        } else if data == 2 {
            dateString = "2"
        }
        
        if media.isEmpty {
            mediaString = "-1"
        }
        
        if star.isEmpty {
            starString = "-1"
        }
        
        if mediaString == "Movie" {
            mediaString = "1"
        } else if mediaString == "Book" {
            mediaString = "2"
        } else if mediaString == "TV" {
            mediaString = "3"
        } else if mediaString == "Music" {
            mediaString = "4"
        } else if mediaString == "Webtoon" {
            mediaString = "5"
        } else if mediaString == "Youtube" {
            mediaString = "6"
        }
        
        myRecordAPI.getMyRecordFilter(date: dateString, media: mediaString, star: starString) { data, err in
            self.recordTableView.reloadData()
        }
        
        print(date, data, media, star, "넘어온 값", dateString)
        
        filterView.dateButton.isSelected = (data == -1) ?
        false : true
        filterView.mediaButton.isSelected = (media == ["미디어"]) ?
        false : true
        filterView.starButton.isSelected = (star == []) ?
        false : true

        if filterView.mediaButton.isSelected {
            if media.isEmpty {
                mediaData = "미디어"
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
