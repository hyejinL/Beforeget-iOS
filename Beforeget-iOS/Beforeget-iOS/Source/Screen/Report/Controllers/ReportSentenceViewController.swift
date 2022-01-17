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

    // MARK: - Properties
    
    private var reportTopView = ReportTopView()
    private var reportSentenceView = ReportSentenceView()
    private lazy var monthPicker = MonthYearPickerView()
    
    private var movieData: [String] = ["너무 웃겨요", "눈물 좔좔 호수수", "눈물 좔좔 호수수"]
    private var bookData: [String] = ["너무 웃겨요", "눈물 좔좔 호수수", "눈물 좔좔 호수수"]
    private var tvData: [String] = ["너무 웃겨요", "눈물 좔좔 호수수", "눈물 좔좔 호수수"]
    private var musicData: [String] = []
    private var webtoonData: [String] = []
    private var youtubeData: [String] = ["너무 웃겨요", "눈물 좔좔 호수수", "눈물 좔좔 호수수"]
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
        bind()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        reportTopView.monthButton.inputAccessoryView = setupToolbar()
        reportTopView.monthButton.inputView = monthPicker
        
        reportTopView.reportTitle = "유형별 한 줄 리뷰 순위"
        reportTopView.reportDescription = "유형 카드를 탭하여 확인해보세요"
    }
    
    private func setupLayout() {
        view.addSubviews([reportTopView, reportSentenceView])
        
        reportTopView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(44)
            $0.height.equalTo(UIScreen.main.hasNotch ? 146 : 142)
        }
        
        reportSentenceView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(reportTopView.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(UIScreen.main.hasNotch ? 54 : 62)
        }
    }
    
    // MARK: - Custom Method
    
    private func bind() {
        reportTopView.delegate = self
        reportSentenceView.delegate = self
        
        reportSentenceView.movieData = movieData
        reportSentenceView.bookData = bookData
        reportSentenceView.tvData = tvData
        reportSentenceView.musicData = musicData
        reportSentenceView.webtoonData = webtoonData
        reportSentenceView.youtubeData = youtubeData
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

    @objc func touchupDoneButton() {
        reportTopView.monthButton.setTitle("\(monthPicker.year)년 \(monthPicker.month)월", for: .normal)
        view.endEditing(true)
    }
}

// MARK: - ReportTopView Delegate

extension ReportSentenceViewController: ReportTopViewDelegate {
    func touchupMonthButton() {
        
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
