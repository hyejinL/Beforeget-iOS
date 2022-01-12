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
        $0.alignment = .center
        $0.spacing = 15
        $0.distribution = .fillEqually
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
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        setupStatusBar(Asset.Colors.white.color)
    }
    
    private func setupLayout() {
        view.addSubviews([naviBar, paginationStackView])
        naviBar.addSubview(downLoadButton)
        
        naviBar.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(44)
        }
        
        downLoadButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview()
            $0.width.height.equalTo(44)
        }
        
        paginationStackView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(145)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(17)
            $0.height.equalTo(6)
        }
        
        paginationStackView.addArrangedSubviews([pageImageView1,
                                                 pageImageView2,
                                                 pageImageView3,
                                                 pageImageView4,
                                                 pageImageView5])
    }
    
    private func setupControllers() {
        dataSource = self
        delegate = self
        
        [page1, page2, page3, page4, page5].forEach {
            pages.append($0)
        }
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
    }
    
    private func setupBarData() {
        page2.reportGraphView.barView1.animate(height: 30)
        page2.reportGraphView.barView2.animate(height: 60)
        page2.reportGraphView.barView3.animate(height: 40)
        page2.reportGraphView.barView4.animate(height: 80)
        page2.reportGraphView.barView5.animate(height: 10)
        
        page2.reportGraphView.barView1.barTitle = "8"
        page2.reportGraphView.barView2.barTitle = "9"
        page2.reportGraphView.barView3.barTitle = "10"
        page2.reportGraphView.barView4.barTitle = "11"
        page2.reportGraphView.barView5.barTitle = "12"
        
        
        page2.reportGraphView.barView5.setupProgressColor(Asset.Colors.green100.color)
        page2.reportGraphView.barView5.setupTitleColor(Asset.Colors.green100.color)
    }
    
    // MARK: - @objc
    @objc func touchupDownLoadButton() {
        
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
            setupBarData()
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
        default:
            pageImageView1.image = Asset.Assets.pageActive.image
            [pageImageView2, pageImageView3, pageImageView4, pageImageView5].forEach {
                $0.image = Asset.Assets.pageInactive.image
            }
        }
    }
}

