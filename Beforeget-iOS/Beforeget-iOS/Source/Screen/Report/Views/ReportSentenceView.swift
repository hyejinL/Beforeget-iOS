//
//  ReportSentenceView.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/12.
//

import UIKit

import SnapKit
import Then

protocol ReportSentenceViewDelegate: AnyObject {
    func touchupMovie()
    func touchupBook()
    func touchupTV()
    func touchupMusic()
    func touchupWebtoon()
    func touchupYoutube()
}

class ReportSentenceView: UIView {
    
    // MARK: - Properties
    
    private var mediaVerticalStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 5
    }
    
    private var mediaHorizontalStackView1 = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 5
    }
    
    private var mediaHorizontalStackView2 = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 5
    }
    
    private var mediaHorizontalStackView3 = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 5
    }
    
    var movieImageView = UIImageView()
    var bookImageView = UIImageView()
    var tvImageView = UIImageView()
    var musicImageView = UIImageView()
    var webtoonImageView = UIImageView()
    var youtubeImageView = UIImageView()
    
    private var movieLabel = UILabel().then {
        $0.text = "Movie"
    }
    
    private var bookLabel = UILabel().then {
        $0.text = "Book"
    }
    
    private var tvLabel = UILabel().then {
        $0.text = "TV"
    }
    
    private var musicLabel = UILabel().then {
        $0.text = "Music"
    }
    
    private var webtoonLabel = UILabel().then {
        $0.text = "Webtoon"
    }
    
    private var youtubeLabel = UILabel().then {
        $0.text = "Youtube"
    }
    
    private var movieCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        ReportSentenceCollectionViewCell.register(target: $0)
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
        $0.isHidden = true
    }
    
    private var bookCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        ReportSentenceCollectionViewCell.register(target: $0)
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
        $0.isHidden = true
    }
    
    private var tvCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        ReportSentenceCollectionViewCell.register(target: $0)
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
        $0.isHidden = true
    }
    
    private var musicCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        ReportSentenceCollectionViewCell.register(target: $0)
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
        $0.isHidden = true
    }
    
    private var webtoonCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        ReportSentenceCollectionViewCell.register(target: $0)
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
        $0.isHidden = true
    }
    
    private var youtubeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        ReportSentenceCollectionViewCell.register(target: $0)
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
        $0.isHidden = true
    }
    
    var movieData = [String]()
    var bookData = [String]()
    var tvData = [String]()
    var musicData = [String]()
    var webtoonData = [String]()
    var youtubeData = [String]()
    
    var movieIsFront: Bool = true {
        didSet {
            movieLabel.isHidden = !movieIsFront
            movieCollectionView.isHidden = movieIsFront
        }
    }
    
    var bookIsFront: Bool = true {
        didSet {
            bookLabel.isHidden = !bookIsFront
            bookCollectionView.isHidden = bookIsFront
        }
    }
    
    var tvIsFront: Bool = true {
        didSet {
            tvLabel.isHidden = !tvIsFront
            tvCollectionView.isHidden = tvIsFront
        }
    }
    
    var musicIsFront: Bool = true {
        didSet {
            musicLabel.isHidden = !musicIsFront
            musicCollectionView.isHidden = musicIsFront
        }
    }
    
    var webtoonIsFront: Bool = true {
        didSet {
            webtoonLabel.isHidden = !webtoonIsFront
            webtoonCollectionView.isHidden = webtoonIsFront
        }
    }
    
    var youtubeIsFront: Bool = true {
        didSet {
            youtubeLabel.isHidden = !youtubeIsFront
            youtubeCollectionView.isHidden = youtubeIsFront
        }
    }
    
    weak var delegate: ReportSentenceViewDelegate?
    
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
        [movieImageView, bookImageView, tvImageView, musicImageView, webtoonImageView, youtubeImageView].forEach {
            $0.image = Asset.Assets.imgSentenceFront.image
        }
        
        setupTapGesture()
        
        [movieLabel, bookLabel, tvLabel, musicLabel, webtoonLabel, youtubeLabel].forEach {
            $0.font = BDSFont.enBody4
            $0.textColor = Asset.Colors.white.color
        }
    }
    
    private func setupLayout() {
        addSubview(mediaVerticalStackView)
        mediaVerticalStackView.addArrangedSubviews([mediaHorizontalStackView1, mediaHorizontalStackView2, mediaHorizontalStackView3])
        mediaHorizontalStackView1.addArrangedSubviews([movieImageView, bookImageView])
        mediaHorizontalStackView2.addArrangedSubviews([tvImageView, musicImageView])
        mediaHorizontalStackView3.addArrangedSubviews([webtoonImageView, youtubeImageView])
        
        mediaVerticalStackView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
        
        [movieImageView, bookImageView, tvImageView, musicImageView, webtoonImageView, youtubeImageView].forEach {
            $0.snp.makeConstraints {
                $0.width.equalTo(165)
            }
        }
        
        [mediaHorizontalStackView1, mediaHorizontalStackView2, mediaHorizontalStackView3].forEach {
            $0.snp.makeConstraints {
                $0.width.equalToSuperview()
            }
        }
        
        movieImageView.addSubviews([movieLabel, movieCollectionView])
        bookImageView.addSubviews([bookLabel, bookCollectionView])
        tvImageView.addSubviews([tvLabel, tvCollectionView])
        musicImageView.addSubviews([musicLabel, musicCollectionView])
        webtoonImageView.addSubviews([webtoonLabel, webtoonCollectionView])
        youtubeImageView.addSubviews([youtubeLabel, youtubeCollectionView])
        
        [movieLabel, bookLabel, tvLabel, musicLabel, webtoonLabel, youtubeLabel].forEach {
            $0.snp.makeConstraints {
                $0.centerX.centerY.equalToSuperview()
            }
        }
        
        [movieCollectionView, bookCollectionView, tvCollectionView, musicCollectionView, webtoonCollectionView, youtubeCollectionView].forEach {
            $0.snp.makeConstraints {
                $0.width.equalTo(UIScreen.main.hasNotch ? 120 : 115)
                $0.height.equalTo(UIScreen.main.hasNotch ? 103 : 93)
                $0.centerX.centerY.equalToSuperview()
            }
        }
    }
    
    // MARK: - Custom Method
    
    private func setupTapGesture() {
        let movieTapGesture = UITapGestureRecognizer(target: self, action: #selector(touchupMovie))
        let bookTapGesture = UITapGestureRecognizer(target: self, action: #selector(touchupBook))
        let tvTapGesture = UITapGestureRecognizer(target: self, action: #selector(touchupTV))
        let musicTapGesture = UITapGestureRecognizer(target: self, action: #selector(touchupMusic))
        let webtoonTapGesture = UITapGestureRecognizer(target: self, action: #selector(touchupWebtoon))
        let youtubeTapGesture = UITapGestureRecognizer(target: self, action: #selector(touchupYoutube))
        
        [movieImageView, bookImageView, tvImageView, musicImageView, webtoonImageView, youtubeImageView].forEach {
            $0.isUserInteractionEnabled = true
        }
        
        movieImageView.addGestureRecognizer(movieTapGesture)
        bookImageView.addGestureRecognizer(bookTapGesture)
        tvImageView.addGestureRecognizer(tvTapGesture)
        musicImageView.addGestureRecognizer(musicTapGesture)
        webtoonImageView.addGestureRecognizer(webtoonTapGesture)
        youtubeImageView.addGestureRecognizer(youtubeTapGesture)
    }
    
    private func bind() {
        [movieCollectionView, bookCollectionView, tvCollectionView, musicCollectionView, webtoonCollectionView, youtubeCollectionView].forEach {
            $0.delegate = self
            $0.dataSource = self
            $0.reloadData()
        }
    }
    
    private func calculateCellWidth(text: String) -> CGFloat {
        let label = UILabel()
        label.text = text
        label.font = BDSFont.body8
        label.sizeToFit()
        return label.frame.width + 18
    }
    
    // MARK: - @objc
    
    @objc func touchupMovie() {
        delegate?.touchupMovie()
        movieIsFront.toggle()
    }
    
    @objc func touchupBook() {
        delegate?.touchupBook()
        bookIsFront.toggle()
    }
    
    @objc func touchupTV() {
        delegate?.touchupTV()
        tvIsFront.toggle()
    }
    
    @objc func touchupMusic() {
        delegate?.touchupMusic()
        musicIsFront.toggle()
    }
    
    @objc func touchupWebtoon() {
        delegate?.touchupWebtoon()
        webtoonIsFront.toggle()
    }
    
    @objc func touchupYoutube() {
        delegate?.touchupYoutube()
        youtubeIsFront.toggle()
    }
}

// MARK: - UICollectionView Delegate

extension ReportSentenceView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case movieCollectionView:
            return CGSize(width: calculateCellWidth(text: movieData[indexPath.item]), height: 25)
        case bookCollectionView:
            return CGSize(width: calculateCellWidth(text: bookData[indexPath.item]), height: 25)
        case tvCollectionView:
            return CGSize(width: calculateCellWidth(text: tvData[indexPath.item]), height: 25)
        case musicCollectionView:
            return CGSize(width: calculateCellWidth(text: musicData[indexPath.item]), height: 25)
        case webtoonCollectionView:
            return CGSize(width: calculateCellWidth(text: webtoonData[indexPath.item]), height: 25)
        case youtubeCollectionView:
            return CGSize(width: calculateCellWidth(text: youtubeData[indexPath.item]), height: 25)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return UIScreen.main.hasNotch ? 14 : 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}

// MARK: - UICollectionView DataSource

extension ReportSentenceView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case movieCollectionView:
            return movieData.count
        case bookCollectionView:
            return bookData.count
        case tvCollectionView:
            return tvData.count
        case musicCollectionView:
            return musicData.count
        case webtoonCollectionView:
            return webtoonData.count
        case youtubeCollectionView:
            return youtubeData.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case movieCollectionView :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReportSentenceCollectionViewCell.className, for: indexPath) as? ReportSentenceCollectionViewCell else { return UICollectionViewCell() }
            cell.initCell(sentence: movieData[indexPath.item])
            return cell
        case bookCollectionView :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReportSentenceCollectionViewCell.className, for: indexPath) as? ReportSentenceCollectionViewCell else { return UICollectionViewCell() }
            cell.initCell(sentence: bookData[indexPath.item])
            return cell
        case tvCollectionView :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReportSentenceCollectionViewCell.className, for: indexPath) as? ReportSentenceCollectionViewCell else { return UICollectionViewCell() }
            cell.initCell(sentence: tvData[indexPath.item])
            return cell
        case musicCollectionView :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReportSentenceCollectionViewCell.className, for: indexPath) as? ReportSentenceCollectionViewCell else { return UICollectionViewCell() }
            cell.initCell(sentence: musicData[indexPath.item])
            return cell
        case webtoonCollectionView :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReportSentenceCollectionViewCell.className, for: indexPath) as? ReportSentenceCollectionViewCell else { return UICollectionViewCell() }
            cell.initCell(sentence: webtoonData[indexPath.item])
            return cell
        case youtubeCollectionView :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReportSentenceCollectionViewCell.className, for: indexPath) as? ReportSentenceCollectionViewCell else { return UICollectionViewCell() }
            cell.initCell(sentence: youtubeData[indexPath.item])
            return cell
        default:
            return UICollectionViewCell()
            
        }
    }
}
