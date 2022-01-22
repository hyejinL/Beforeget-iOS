//
//  ReportSentenceViewController.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/09.
//

import UIKit

import SnapKit
import Then

final class ReportSentenceViewController: UIViewController {
    
    // MARK: - Network
    
    private let reportAPI = ReportAPI.shared

    // MARK: - Properties
    
    private var reportTopView = ReportTopView()
    private var reportSentenceView = ReportSentenceView()
    private lazy var monthPicker = MonthYearPickerView()
    
    // MARK: - TODO REMOVE
    
    var movieData: [String] = []
    var bookData: [String] = []
    var tvData: [String] = []
    var musicData: [String] = []
    var webtoonData: [String] = []
    var youtubeData: [String] = []
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
        bind()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        reportTopView.reportTitle = "유형별 한 줄 리뷰 순위"
        reportTopView.reportDescription = "유형 카드를 탭하여 확인해보세요"
    }
    
    private func setupLayout() {
        view.addSubviews([reportTopView, reportSentenceView])
        
        reportTopView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(UIScreen.main.hasNotch ? 126 : 115)
            $0.height.equalTo(UIScreen.main.hasNotch ? 70 : 66)
        }
        
        reportSentenceView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(reportTopView.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(UIScreen.main.hasNotch ? 54 : 62)
        }
    }
    
    // MARK: - Custom Method
    
    private func bind() {
        reportSentenceView.delegate = self
        
        reportSentenceView.movieData = movieData
        reportSentenceView.bookData = bookData
        reportSentenceView.tvData = tvData
        reportSentenceView.musicData = musicData
        reportSentenceView.webtoonData = webtoonData
        reportSentenceView.youtubeData = youtubeData
    }
}

// MARK: - ReportSentenceView Delegate

extension ReportSentenceViewController: ReportSentenceViewDelegate {
    func touchupMovie() {
        if movieData.isEmpty {
            reportSentenceView.movieImageView.image = reportSentenceView.movieIsFront ? Asset.Assets.boxSentenceEmpty.image : Asset.Assets.imgSentenceFront.image
        } else {
            reportSentenceView.movieImageView.image = reportSentenceView.movieIsFront ? Asset.Assets.imgSentenceBack.image : Asset.Assets.imgSentenceFront.image
        }
        UIView.transition(with: reportSentenceView.movieImageView, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
    }
    
    func touchupBook() {
        if bookData.isEmpty {
            reportSentenceView.bookImageView.image = reportSentenceView.bookIsFront ? Asset.Assets.boxSentenceEmpty.image : Asset.Assets.imgSentenceFront.image
        } else {
            reportSentenceView.bookImageView.image = reportSentenceView.bookIsFront ? Asset.Assets.imgSentenceBack.image : Asset.Assets.imgSentenceFront.image
        }
        UIView.transition(with: reportSentenceView.bookImageView, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
    }
    
    func touchupTV() {
        if tvData.isEmpty {
            reportSentenceView.tvImageView.image = reportSentenceView.tvIsFront ? Asset.Assets.boxSentenceEmpty.image : Asset.Assets.imgSentenceFront.image
        } else {
            reportSentenceView.tvImageView.image = reportSentenceView.tvIsFront ? Asset.Assets.imgSentenceBack.image : Asset.Assets.imgSentenceFront.image
        }
        UIView.transition(with: reportSentenceView.tvImageView, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
    }
    
    func touchupMusic() {
        if musicData.isEmpty {
            reportSentenceView.musicImageView.image = reportSentenceView.musicIsFront ? Asset.Assets.boxSentenceEmpty.image : Asset.Assets.imgSentenceFront.image
        } else {
            reportSentenceView.musicImageView.image = reportSentenceView.musicIsFront ? Asset.Assets.imgSentenceBack.image : Asset.Assets.imgSentenceFront.image
        }
        UIView.transition(with: reportSentenceView.musicImageView, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
    }
    
    func touchupWebtoon() {
        if webtoonData.isEmpty {
            reportSentenceView.webtoonImageView.image = reportSentenceView.webtoonIsFront ? Asset.Assets.boxSentenceEmpty.image : Asset.Assets.imgSentenceFront.image
        } else {
            reportSentenceView.webtoonImageView.image = reportSentenceView.webtoonIsFront ? Asset.Assets.imgSentenceBack.image : Asset.Assets.imgSentenceFront.image
        }
        UIView.transition(with: reportSentenceView.webtoonImageView, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
    }
    
    func touchupYoutube() {
        if youtubeData.isEmpty {
            reportSentenceView.youtubeImageView.image = reportSentenceView.youtubeIsFront ? Asset.Assets.boxSentenceEmpty.image : Asset.Assets.imgSentenceFront.image
        } else {
            reportSentenceView.youtubeImageView.image = reportSentenceView.youtubeIsFront ? Asset.Assets.imgSentenceBack.image : Asset.Assets.imgSentenceFront.image
        }
        UIView.transition(with: reportSentenceView.youtubeImageView, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
    }
}
