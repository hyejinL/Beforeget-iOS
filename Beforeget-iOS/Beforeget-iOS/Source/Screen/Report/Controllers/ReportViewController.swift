//
//  ReportViewController.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/07.
//

import UIKit

import SnapKit
import Then

final class ReportViewController: UIPageViewController {
    
    // MARK: - Properties
    
    private lazy var naviBar = BDSNavigationBar(self, view: .report, isHidden: false)
    
    private lazy var downLoadButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setImage(Asset.Assets.btnDownload.image, for: .normal)
        $0.addTarget(self, action: #selector(touchupDownLoadButton), for: .touchUpInside)
    }
    
    private var pages = [UIViewController]()
    private let initialPage = 0
    
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
    
    // MARK: - TODO REMOVE
    
    private var dumyData: [Int] = [0, 3, 0, 2, 12]
    private var heights = [Double]()
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
        setupControllers()
        calculateHeight()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        setupStatusBar(Asset.Colors.white.color)
        view.backgroundColor = Asset.Colors.white.color
    }
    
    private func setupLayout() {
        view.addSubviews([naviBar, paginationStackView])
        naviBar.addSubview(downLoadButton)
        
        naviBar.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(UIScreen.main.hasNotch ? 44 : 50)
        }
        
        downLoadButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview()
            $0.width.height.equalTo(44)
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
        guard let maxCount = dumyData.max() else { return }
        page2.reportGraphView.maxCount = maxCount
        page5.reportOnePageView.maxCount = maxCount
        
        let midCount = dumyData.sorted(by: >)[2]
        page2.reportGraphView.midCount = midCount
        page5.reportOnePageView.midCount = midCount
        
        for data in dumyData {
            let totalHeight = UIScreen.main.hasNotch ? 150 : 130
            let height = totalHeight * data / maxCount
            heights.append(Double(height))
        }
    }
    
    private func setupBarData() {
        page5.reportOnePageView.barView1.setupBarHeight(height: CGFloat(heights[0]))
        page5.reportOnePageView.barView2.setupBarHeight(height: CGFloat(heights[1]))
        page5.reportOnePageView.barView3.setupBarHeight(height: CGFloat(heights[2]))
        page5.reportOnePageView.barView4.setupBarHeight(height: CGFloat(heights[3]))
        page5.reportOnePageView.barView5.setupBarHeight(height: CGFloat(heights[4]))
    }
    
    private func setupBarAnimation() {
        page2.reportGraphView.barView1.animate(height: CGFloat(heights[0]))
        page2.reportGraphView.barView2.animate(height: CGFloat(heights[1]))
        page2.reportGraphView.barView3.animate(height: CGFloat(heights[2]))
        page2.reportGraphView.barView4.animate(height: CGFloat(heights[3]))
        page2.reportGraphView.barView5.animate(height: CGFloat(heights[4]))
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
}

// MARK: - UIPageViewController DataSource

extension ReportViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex == 0 {
            return pages.last
        } else {
            return pages[currentIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        
        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]
        } else {
            return pages.first
        }
    }
}

// MARK: - UIPageViewController Delegate

extension ReportViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard
            let viewController = pageViewController.viewControllers?.first,
            let currentIndex = pages.firstIndex(of: viewController)
        else { return }
        
        switch currentIndex {
        case 1:
            pageImageView2.image = Asset.Assets.pageActive.image
            [pageImageView1, pageImageView3, pageImageView4, pageImageView5].forEach {
                $0.image = Asset.Assets.pageInactive.image
            }
            setupBarAnimation()
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
            pageImageView5.image = Asset.Assets.pageActive.image
            [pageImageView1, pageImageView2, pageImageView3, pageImageView4].forEach {
                $0.image = Asset.Assets.pageInactive.image
            }
            setupBarData()
        default:
            pageImageView1.image = Asset.Assets.pageActive.image
            [pageImageView2, pageImageView3, pageImageView4, pageImageView5].forEach {
                $0.image = Asset.Assets.pageInactive.image
            }
        }
    }
}

