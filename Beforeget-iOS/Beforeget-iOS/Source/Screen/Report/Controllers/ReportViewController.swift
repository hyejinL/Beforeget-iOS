//
//  ReportViewController.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/07.
//

import UIKit

class ReportViewController: UIPageViewController {
    
    // MARK: - Properties
    
    private var pages = [UIViewController]()
    private let initialPage = 0
    let pageControl = UIPageControl()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        setupLayout()
        setupControllers()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        
    }
    
    private func setupLayout() {
        view.addSubview(pageControl)
        
        pageControl.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(145)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(17)
            $0.height.equalTo(6)
        }
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
        
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        
        pageControl.currentPage = currentIndex
        print(currentIndex)
    }
}

