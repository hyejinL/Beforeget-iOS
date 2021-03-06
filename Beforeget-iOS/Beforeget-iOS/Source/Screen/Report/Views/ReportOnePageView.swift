//
//  ReportOnePageView.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/13.
//

import UIKit

import SnapKit
import Then

class ReportOnePageView: UIView {

    // MARK: - Properties
    
    private var reportOnePageVerticalStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 2
    }
    
    private var reportOnePageHorizontalStackView1 = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 2
    }
    
    private var graphView = UIView()
    
    private var reportOnePageHorizontalStackView2 = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 2
    }
    
    var mediaImageView = UIImageView().then {
        $0.contentMode = UIScreen.main.hasNotch ? .scaleAspectFill : .center
        $0.clipsToBounds = true
    }
    
    private var sentenceView = UIView()
    private lazy var sentenceCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        ReportSentenceCollectionViewCell.register(target: $0)
        $0.backgroundColor = Asset.Colors.black200.color
        $0.isScrollEnabled = false
    }
    
    private var maxCountLabel = UILabel().then {
        $0.textColor = Asset.Colors.white.color
        $0.font = BDSFont.enBody8
    }
    
    private var midCountLabel = UILabel().then {
        $0.textColor = Asset.Colors.white.color
        $0.font = BDSFont.enBody8
    }
    
    private var minCountLabel = UILabel().then {
        $0.text = "0"
        $0.textColor = Asset.Colors.white.color
        $0.font = BDSFont.enBody8
    }
    
    private var midLineView = UIView().then {
        $0.backgroundColor = Asset.Colors.gray100.color
    }
    
    private var minLineView = UIView().then {
        $0.backgroundColor = Asset.Colors.gray100.color
    }
    
    var barView1 = BarView()
    var barView2 = BarView()
    var barView3 = BarView()
    var barView4 = BarView()
    var barView5 = BarView().then {
        $0.setupProgressColor(Asset.Colors.green100.color)
        $0.setupTitleColor(Asset.Colors.green100.color)
    }
    
    private var barStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.spacing = 22
    }
    
    private var firstRankingView = UIView()
    private var secondRankingView = UIView()
    private var thirdRankingView = UIView()
    
    private var firstRankingMediaLabel = UILabel()
    private var secondRankingMediaLabel = UILabel()
    private var thirdRankingMediaLabel = UILabel()
    
    private var firstRankingCountLabel = UILabel().then {
        $0.textColor = Asset.Colors.green100.color
        $0.font = BDSFont.enBody1
    }
    private var secondRankingCountLabel = UILabel().then {
        $0.textColor = Asset.Colors.white.color
        $0.font = BDSFont.enBody3
    }
    private var thirdRankingCountLabel = UILabel().then {
        $0.textColor = Asset.Colors.white.color
        $0.font = BDSFont.enBody3
    }
    
    var maxCount: Int = 0 {
        didSet {
            maxCountLabel.text = "\(maxCount)"
        }
    }
    
    var midCount: Int = 0 {
        didSet {
            midCountLabel.text = "\(midCount)"
        }
    }
    
    var firstRankingMedia: String = "" {
        didSet {
            firstRankingMediaLabel.text = "\(firstRankingMedia)"
        }
    }
    
    var firstRankingCount: Int = 0 {
        didSet {
            firstRankingCountLabel.text = "\(firstRankingCount)"
        }
    }
    
    var secondRankingMedia: String = "" {
        didSet {
            secondRankingMediaLabel.text = "\(secondRankingMedia)"
        }
    }
    
    var secondRankingCount: Int = 0 {
        didSet {
            secondRankingCountLabel.text = "\(secondRankingCount)"
        }
    }
    
    var thirdRankingMedia: String = "" {
        didSet {
            thirdRankingMediaLabel.text = "\(thirdRankingMedia)"
        }
    }
    
    var thirdRankingCount: Int = 0 {
        didSet {
            thirdRankingCountLabel.text = "\(thirdRankingCount)"
        }
    }
    
    var sentence = [String]()
    
    // MARK: - Initializer
    
    init() {
        super.init(frame: .zero)
        configUI()
        setupLayout()
        bind()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        [sentenceView, graphView, secondRankingView, firstRankingView, thirdRankingView].forEach {
            $0.backgroundColor = Asset.Colors.black200.color
        }
        
        [firstRankingMediaLabel, secondRankingMediaLabel, thirdRankingMediaLabel].forEach {
            $0.font = BDSFont.enBody6
            $0.textColor = Asset.Colors.white.color
        }
    }
    
    private func setupLayout() {
        addSubviews([reportOnePageVerticalStackView])
        reportOnePageVerticalStackView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
        
        reportOnePageVerticalStackView.addArrangedSubviews([reportOnePageHorizontalStackView1,
                                                            graphView,
                                                           reportOnePageHorizontalStackView2])
        
        reportOnePageHorizontalStackView1.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        graphView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(UIScreen.main.hasNotch ? 244 : 209)
        }
        
        graphView.addSubviews([maxCountLabel, midCountLabel, minCountLabel, midLineView, minCountLabel, minLineView, barStackView])
        
        barStackView.addArrangedSubviews([barView1, barView2, barView3, barView4, barView5])

        [barView1, barView2, barView3, barView4, barView5].forEach {
            $0.snp.makeConstraints {
                $0.width.equalTo(28)
            }
        }

        barStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(53)
            $0.trailing.equalToSuperview().inset(54)
            $0.top.equalToSuperview().inset(UIScreen.main.hasNotch ? 41 : 28)
            $0.bottom.equalToSuperview().inset(UIScreen.main.hasNotch ? 26 : 19)
        }
        
        maxCountLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(UIScreen.main.hasNotch ? 25 : 35)
            $0.top.equalToSuperview().inset(UIScreen.main.hasNotch ? 37 : 28)
        }
        
        midCountLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(UIScreen.main.hasNotch ? 25 : 35)
            $0.top.equalTo(maxCountLabel.snp.bottom).offset(UIScreen.main.hasNotch ? 64 : 55)
        }
        
        midLineView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(UIScreen.main.hasNotch ? 116 : 98)
            $0.leading.equalTo(midCountLabel.snp.trailing).offset(7)
            $0.trailing.equalToSuperview().inset(UIScreen.main.hasNotch ? 45 : 35)
            $0.height.equalTo(0.5)
        }
        
        minCountLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(UIScreen.main.hasNotch ? 25 : 35)
            $0.top.equalTo(midCountLabel.snp.bottom).offset(UIScreen.main.hasNotch ? 64 : 55)
        }
        
        minLineView.snp.makeConstraints {
            $0.top.equalTo(midLineView.snp.bottom).offset(UIScreen.main.hasNotch ? 75 : 65)
            $0.leading.equalTo(midCountLabel.snp.trailing).offset(11)
            $0.trailing.equalToSuperview().inset(UIScreen.main.hasNotch ? 45 : 35)
            $0.height.equalTo(0.5)
        }
        
        reportOnePageHorizontalStackView2.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(UIScreen.main.hasNotch ? 130 : 123)
        }
        
        reportOnePageHorizontalStackView1.addArrangedSubviews([mediaImageView, sentenceView])
        reportOnePageHorizontalStackView2.addArrangedSubviews([secondRankingView, firstRankingView, thirdRankingView])
        
        mediaImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
        }

        sentenceView.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.hasNotch ? 138 : 130)
            $0.top.bottom.equalToSuperview()
        }
        
        sentenceView.addSubview(sentenceCollectionView)
        
        sentenceCollectionView.snp.makeConstraints { 
            $0.width.equalTo(130)
            $0.height.equalTo(UIScreen.main.hasNotch ? 107 : 91)
            $0.centerX.centerY.equalToSuperview()
        }

        secondRankingView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalTo(110)
        }

        firstRankingView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(135)
        }

        thirdRankingView.snp.makeConstraints {
            $0.trailing.top.bottom.equalToSuperview()
        }
        
        firstRankingView.addSubviews([firstRankingMediaLabel, firstRankingCountLabel])
        secondRankingView.addSubviews([secondRankingMediaLabel, secondRankingCountLabel])
        thirdRankingView.addSubviews([thirdRankingMediaLabel, thirdRankingCountLabel])
        
        firstRankingCountLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(UIScreen.main.hasNotch ? 32 : 29)
            $0.centerX.equalToSuperview()
        }
        
        firstRankingMediaLabel.snp.makeConstraints {
            $0.top.equalTo(firstRankingCountLabel.snp.bottom).offset(7)
            $0.centerX.equalToSuperview()
        }
        
        secondRankingCountLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(UIScreen.main.hasNotch ? 38 : 34)
            $0.centerX.equalToSuperview()
        }
        
        secondRankingMediaLabel.snp.makeConstraints {
            $0.top.equalTo(secondRankingCountLabel.snp.bottom).offset(14)
            $0.centerX.equalToSuperview()
        }
        
        thirdRankingCountLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(UIScreen.main.hasNotch ? 38 : 34)
            $0.centerX.equalToSuperview()
        }
        
        thirdRankingMediaLabel.snp.makeConstraints {
            $0.top.equalTo(thirdRankingCountLabel.snp.bottom).offset(14)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Custom Method
    
    private func calculateCellWidth(text: String) -> CGFloat {
        let label = UILabel()
        label.text = text
        label.font = BDSFont.body8
        label.sizeToFit()
        return label.frame.width + 18
    }
    
    private func bind() {
        sentenceCollectionView.delegate = self
        sentenceCollectionView.dataSource = self
        sentenceCollectionView.reloadData()
        
        barView1.barTitle = addOrSubtractMonth(month: -5)
        barView2.barTitle = addOrSubtractMonth(month: -4)
        barView3.barTitle = addOrSubtractMonth(month: -3)
        barView4.barTitle = addOrSubtractMonth(month: -2)
        barView5.barTitle = addOrSubtractMonth(month: -1)
    }
    
    private func addOrSubtractMonth(month:Int) -> String {
        let date = Calendar.current.date(byAdding: .month, value: month, to: Date())!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M???"
        return dateFormatter.string(from: date)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ReportOnePageView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: calculateCellWidth(text: sentence[indexPath.item]), height: 25)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return UIScreen.main.hasNotch ? 14 : 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}

// MARK: - UICollectionView DataSource

extension ReportOnePageView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sentence.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReportSentenceCollectionViewCell.className, for: indexPath) as? ReportSentenceCollectionViewCell else { return UICollectionViewCell() }
        cell.initCell(sentence: sentence[indexPath.item])
        return cell
    }
}
