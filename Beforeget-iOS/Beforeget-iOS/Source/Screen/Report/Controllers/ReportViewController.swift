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
        setupStatusBar(.white)
    }
    
    private func setupLayout() {
        view.addSubviews([naviBar, paginationStackView])
        
        naviBar.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
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
        
        let page1 = ReportLabelViewController()
        let page2 = ReportGraphViewController()
        let page3 = ReportRankingViewController()
        let page4 = ReportSentenceViewController()
        let page5 = ReportOnePageViewController()
        
        [page1, page2, page3, page4, page5].forEach {
            pages.append($0)
        }
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
    }
}

// MARK: - UIPageViewControllerDelegate

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

extension ReportViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard
            let viewController = pageViewController.viewControllers?.first,
            let currentIndex = pages.firstIndex(of: viewController)
        else { return }
        
        switch currentIndex {
        case 0:
            pageImageView1.image = Asset.Assets.pageActive.image
            [pageImageView2, pageImageView3, pageImageView4, pageImageView5].forEach {
                $0.image = Asset.Assets.pageInactive.image
            }
        case 1:
            pageImageView2.image = Asset.Assets.pageActive.image
            [pageImageView1, pageImageView3, pageImageView4, pageImageView5].forEach {
                $0.image = Asset.Assets.pageInactive.image
            }
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

