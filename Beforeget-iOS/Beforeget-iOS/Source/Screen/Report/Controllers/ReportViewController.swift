//
//  ReportViewController.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/07.
//

import UIKit

import SnapKit
import Then

import Kingfisher

import Lottie

final class ReportViewController: UIPageViewController {
    
    // MARK: - Network
    
    private let reportAPI = ReportAPI.shared
    
    // MARK: - Properties
    
    private lazy var naviBar = BDSNavigationBar(self, view: .report, isHidden: false)
    
    private lazy var downLoadButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setImage(Asset.Assets.btnShare.image, for: .normal)
        $0.addTarget(self, action: #selector(touchupDownLoadButton), for: .touchUpInside)
    }
    
    private var monthButton = RespondingButton().then {
        $0.setTitleColor(Asset.Colors.black200.color, for: .normal)
        $0.addTarget(self, action: #selector(touchupMonthButton), for: .touchUpInside)
        $0.titleLabel?.font = BDSFont.enBody7
    }
    
    private var monthPicker = MonthYearPickerView()
    
    private var pages = [UIViewController]()
    private let initialPage = 0
    private var currentPageIndex = 0
    
    private let paginationStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 13
        $0.distribution = .equalSpacing
    }
    
    private let pageImageView1 = UIImageView().then {
        $0.image = Asset.Assets.pageActive.image
    }
    
    private let pageImageView2 = UIImageView().then {
        $0.image = Asset.Assets.pageInactive.image
    }
    
    private let pageImageView3 = UIImageView().then {
        $0.image = Asset.Assets.pageInactive.image
    }
    
    private let pageImageView4 = UIImageView().then {
        $0.image = Asset.Assets.pageInactive.image
    }
    
    private let pageImageView5 = UIImageView().then {
        $0.image = Asset.Assets.pageInactive.image
    }
    
    private let page1 = ReportLabelViewController()
    private let page2 = ReportGraphViewController()
    private let page3 = ReportRankingViewController()
    private let page4 = ReportSentenceViewController()
    private let page5 = ReportOnePageViewController()
    
    private var countData: [Int] = [0, 0, 0, 0, 0]
    private var sortedCountData: [Int] = [0, 0, 0, 0, 0]
    private var heights = [Double]()
    
    private var isScrollEnabled: Bool = false
    
    private var reportLoadingView = ReportLoadingView()
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reportLoadingView.play()
        
        configUI()
        setupLayout()
        setupControllers()
        
        getFirstReportData()
        getSecondReportData()
        getThridReportData()
        getFourthReportData()
        getTotalReportData()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        setupStatusBar(Asset.Colors.white.color)
        view.backgroundColor = Asset.Colors.white.color
        
        monthButton.layer.borderWidth = 1
        monthButton.layer.borderColor = Asset.Colors.gray200.color.cgColor
        monthButton.makeRound(radius: 31 / 2)
        
        let month = subtractMonthButton(month: -1)
        monthButton.setTitle("\(month)", for: .normal)
        
        monthButton.inputAccessoryView = setupToolbar()
        monthButton.inputView = monthPicker
    }
    
    private func setupLayout() {
        view.addSubviews([naviBar, monthButton, paginationStackView, reportLoadingView])
        naviBar.addSubview(downLoadButton)
        
        naviBar.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        downLoadButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview()
            $0.width.height.equalTo(44)
        }
        
        monthButton.snp.makeConstraints { 
            $0.top.equalTo(naviBar.snp.bottom).offset(UIScreen.main.hasNotch ? 23 : 13)
            $0.leading.trailing.equalToSuperview().inset(133)
            $0.height.equalTo(31)
        }
        
        paginationStackView.addArrangedSubviews([pageImageView1,
                                                 pageImageView2,
                                                 pageImageView3,
                                                 pageImageView4,
                                                 pageImageView5])
        
        paginationStackView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(145)
            $0.height.equalTo(6)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(UIScreen.main.hasNotch ? 18 : 26)
        }
        
        reportLoadingView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    private func setupControllers() {
        dataSource = self
        delegate = self
        
        [page1, page2, page3, page4, page5].forEach {
            pages.append($0)
        }
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
    }
    
    private func calculateHeight() {
        guard let maxCount = sortedCountData.max() else { return }
        // 기록이 없을 경우
        if maxCount == 0 {
            heights = [0, 0, 0, 0 ,0]
            return
        }
        
        page2.reportGraphView.maxCount = maxCount
        page5.reportOnePageView.maxCount = maxCount
        
        let midCount = ceil(Double(maxCount) / 2)
        page2.reportGraphView.midCount = Int(midCount)
        page5.reportOnePageView.midCount = Int( midCount)
        
        heights.removeAll()
        for data in sortedCountData {
            let totalHeight = UIScreen.main.hasNotch ? 150 : 130
            let height = totalHeight * data / maxCount
            heights.append(Double(height))
        }
        
        isScrollEnabled = true
    }
    
    private func setupSecondReportBarAnimation() {
        page2.reportGraphView.barView1.animate(height: CGFloat(heights[0]))
        page2.reportGraphView.barView2.animate(height: CGFloat(heights[1]))
        page2.reportGraphView.barView3.animate(height: CGFloat(heights[2]))
        page2.reportGraphView.barView4.animate(height: CGFloat(heights[3]))
        page2.reportGraphView.barView5.animate(height: CGFloat(heights[4]))
    }
    
    private func setupFiveReportBarAnimation() {
        page5.reportOnePageView.barView1.animate(height: CGFloat(heights[0]))
        page5.reportOnePageView.barView2.animate(height: CGFloat(heights[1]))
        page5.reportOnePageView.barView3.animate(height: CGFloat(heights[2]))
        page5.reportOnePageView.barView4.animate(height: CGFloat(heights[3]))
        page5.reportOnePageView.barView5.animate(height: CGFloat(heights[4]))
    }
    
    private func saveImageOnPhone(image: UIImage, image_name: String) -> URL? {
        let imagePath: String = "\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/\(image_name).png"
        let imageUrl: URL = URL(fileURLWithPath: imagePath)
        
        do {
            try image.pngData()?.write(to: imageUrl)
            return imageUrl
        } catch {
            return nil
        }
    }
    
    private func showError() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "오류.", message: "다시 시도해주세요.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    private func subtractMonthButton(month:Int) -> String {
        guard let date = Calendar.current.date(byAdding: .month, value: month, to: Date()) else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY년 MM월"
        return dateFormatter.string(from: date)
    }
    
    private func addOrSubtractMonth(month:Int) -> String {
        guard let date = Calendar.current.date(byAdding: .month, value: month, to: Date()) else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM"
        return dateFormatter.string(from: date)
    }
    
    private func setupToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.backgroundColor = Asset.Colors.white.color
        toolbar.tintColor = Asset.Colors.black200.color
        toolbar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 45)
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(touchupDoneButton))
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        
        return toolbar
    }
    
    // MARK: - @objc
    
    @objc func touchupDownLoadButton()  {
        let screenShot = self.view.toImage()
        
        let imageToShare = screenShot
        
        let activityItems : NSMutableArray = []
        activityItems.add(imageToShare)
        
        guard let url = saveImageOnPhone(image: imageToShare, image_name: "Beforeget") else {
            showError()
            return
        }
        
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        activityVC.excludedActivityTypes = [UIActivity.ActivityType.addToReadingList]
        
        self.present(activityVC, animated: true, completion: nil)
    }
    
    @objc func touchupDoneButton() {
        monthButton.setTitle("\(monthPicker.year)년 \(monthPicker.month)월", for: .normal)
        view.endEditing(true)
        
        if currentPageIndex == 0 {
            reportAPI.getFirstReport(date: "\(monthPicker.year)-\(monthPicker.month)") { [weak self] data, err in
                guard let self = self else { return }
                guard let data = data else { return }
                
                self.page1.reportDescriptionView.descriptionTitle = data.title
                self.page1.reportDescriptionView.descriptionContent = data.comment
                
                let listURL = URL(string: data.poster)
                self.page1.typeImageView.kf.setImage(with: listURL)
                
                self.page1.reportTopView.reportTitle = "\(self.monthPicker.month)월의 밴토리님은?"
            }
        }
        
        if currentPageIndex == 1 {
            reportAPI.getSecondReport(date: "\(monthPicker.year)-\(monthPicker.month)", count: 5, completion: { [weak self] data, err in
                guard let self = self else { return }
                guard let data = data else { return }
                
                self.page2.reportDescriptionView.descriptionTitle = data.title
                self.page2.reportDescriptionView.descriptionContent = data.comment
                
                self.page2.reportGraphView.barView1.barTitle = "\(data.recordCount[4].month)월"
                self.page2.reportGraphView.barView2.barTitle = "\(data.recordCount[3].month)월"
                self.page2.reportGraphView.barView3.barTitle = "\(data.recordCount[2].month)월"
                self.page2.reportGraphView.barView4.barTitle = "\(data.recordCount[1].month)월"
                self.page2.reportGraphView.barView5.barTitle = "\(data.recordCount[0].month)월"
                
                for i in 0...data.recordCount.count-1 {
                    self.countData[i] = data.recordCount[i].count
                }
                self.sortedCountData = self.countData.reversed()
                
                self.calculateHeight()
                self.setupSecondReportBarAnimation()
            })
        }
        
        if currentPageIndex == 2 {
            reportAPI.getThirdReport(date: "\(monthPicker.year)-\(monthPicker.month)", completion: { [weak self] data, err in
                guard let self = self else { return }
                guard let data = data else { return }
                
                self.page3.reportDescriptionView.descriptionTitle = data.title
                self.page3.reportDescriptionView.descriptionContent = data.label
                
                self.page3.reportRankingView.firstCount = data.arr[0].count
                self.page3.reportRankingView.firstType = data.arr[0].type
                self.page3.reportRankingView.secondCount = data.arr[1].count
                self.page3.reportRankingView.secondType = data.arr[1].type
                self.page3.reportRankingView.thirdCount = data.arr[2].count
                self.page3.reportRankingView.thirdType = data.arr[2].type
            })
        }
    }
    
    @objc func touchupMonthButton() {
        monthButton.becomeFirstResponder()
        
    }
}

// MARK: - UIPageViewController DataSource

extension ReportViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if isScrollEnabled == true {
            if currentIndex == 0 {
                return pages.last
            } else {
                return pages[currentIndex - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        
        if isScrollEnabled == true {
            if currentIndex < pages.count - 1 {
                return pages[currentIndex + 1]
            } else {
                return pages.first
            }
        }
        return nil
    }
}

// MARK: - UIPageViewController Delegate

extension ReportViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard
            let viewController = pageViewController.viewControllers?.first,
            let currentIndex = pages.firstIndex(of: viewController)
        else { return }
        
        currentPageIndex = currentIndex
        
        switch currentIndex {
        case 1:
            pageImageView2.image = Asset.Assets.pageActive.image
            [pageImageView1, pageImageView3, pageImageView4, pageImageView5].forEach {
                $0.image = Asset.Assets.pageInactive.image
            }
            setupSecondReportBarAnimation()
        case 2:
            pageImageView3.image = Asset.Assets.pageActive.image
            [pageImageView1, pageImageView2, pageImageView4, pageImageView5].forEach {
                $0.image = Asset.Assets.pageInactive.image
            }
        case 3:
            pageImageView4.image = Asset.Assets.pageActive.image
            [pageImageView1, pageImageView2, pageImageView3, pageImageView5].forEach {
                $0.image = Asset.Assets.pageInactive.image
            }
        case 4:
            setupFiveReportBarAnimation()
            pageImageView5.image = Asset.Assets.pageActive.image
            [pageImageView1, pageImageView2, pageImageView3, pageImageView4].forEach {
                $0.image = Asset.Assets.pageInactive.image
            }
        default:
            pageImageView1.image = Asset.Assets.pageActive.image
            [pageImageView2, pageImageView3, pageImageView4, pageImageView5].forEach {
                $0.image = Asset.Assets.pageInactive.image
            }
        }
    }
}

// MARK: - Network

extension ReportViewController {
    func getFirstReportData() {
        reportAPI.getFirstReport(date: addOrSubtractMonth(month: -1), completion: { [weak self] data, err in
            guard let self = self else { return }
            guard let data = data else { return }
            
            self.page1.reportDescriptionView.descriptionTitle = data.title
            self.page1.reportDescriptionView.descriptionContent = data.comment
            
            let listURL = URL(string: data.poster)
            self.page1.typeImageView.kf.setImage(with: listURL)
        })
    }
    
    func getSecondReportData() {
        reportAPI.getSecondReport(date: addOrSubtractMonth(month: -1), count: 5, completion: { [weak self] data, err in
            guard let self = self else { return }
            guard let data = data else { return }
            
            for i in 0...data.recordCount.count-1 {
                self.countData[i] = data.recordCount[i].count
            }
            self.sortedCountData = self.countData.reversed()
            self.calculateHeight()
            
            self.page2.reportDescriptionView.descriptionTitle = data.title
            self.page2.reportDescriptionView.descriptionContent = data.comment
            
            self.page2.reportGraphView.barView1.barTitle = "\(data.recordCount[4].month)월"
            self.page2.reportGraphView.barView2.barTitle = "\(data.recordCount[3].month)월"
            self.page2.reportGraphView.barView3.barTitle = "\(data.recordCount[2].month)월"
            self.page2.reportGraphView.barView4.barTitle = "\(data.recordCount[1].month)월"
            self.page2.reportGraphView.barView5.barTitle = "\(data.recordCount[0].month)월"
            
            self.reportLoadingView.stop()
            self.reportLoadingView.removeFromSuperview()
            self.isScrollEnabled = true
        })
    }
    
    func getThridReportData() {
        reportAPI.getThirdReport(date: addOrSubtractMonth(month: -1), completion: { [weak self] data, err in
            guard let self = self else { return }
            guard let data = data else { return }
            
            self.page3.reportDescriptionView.descriptionTitle = data.title
            self.page3.reportDescriptionView.descriptionContent = data.label
            
            self.page3.reportRankingView.firstCount = data.arr[0].count
            self.page3.reportRankingView.firstType = data.arr[0].type
            self.page3.reportRankingView.secondCount = data.arr[1].count
            self.page3.reportRankingView.secondType = data.arr[1].type
            self.page3.reportRankingView.thirdCount = data.arr[2].count
            self.page3.reportRankingView.thirdType = data.arr[2].type
        })
    }
    
    func getFourthReportData() {
        reportAPI.getFourthReport(date: addOrSubtractMonth(month: -1), completion: { [weak self] data, err in
            guard let self = self else { return }
            guard let data = data else { return }
            
            self.page4.movieData = data.oneline.movie
            self.page4.bookData = data.oneline.book
            self.page4.tvData = data.oneline.tv
            self.page4.musicData = data.oneline.music
            self.page4.webtoonData = data.oneline.webtoon
            self.page4.youtubeData = data.oneline.youtube
        })
    }
    
    func getTotalReportData() {
        reportAPI.getTotalReport(date: addOrSubtractMonth(month: -1), count: 5, completion: { [weak self] data, err in
            guard let self = self else { return }
            guard let data = data else { return }
            
            self.page5.reportOnePageView.sentence = data.oneline
            
            self.page5.reportOnePageView.firstRankingMedia = data.media[0].type
            self.page5.reportOnePageView.firstRankingCount = data.media[0].count
            self.page5.reportOnePageView.secondRankingMedia = data.media[1].type
            self.page5.reportOnePageView.secondRankingCount = data.media[1].count
            self.page5.reportOnePageView.thirdRankingMedia = data.media[2].type
            self.page5.reportOnePageView.thirdRankingCount = data.media[2].count
            
            let listURL = URL(string: data.graphic)
            self.page5.reportOnePageView.mediaImageView.kf.setImage(with: listURL)
        })
    }
}
