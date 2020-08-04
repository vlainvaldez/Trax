//
//  DetailView.swift
//  Trax
//
//  Created by alvin joseph valdez on 12/10/19.
//  Copyright © 2019 alvin joseph valdez. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class DetailView: UIView {

  // MARK: - Subviews
  private let bannerView: UIView = {
    let view: UIView = UIView()
    view.backgroundColor = AppUI.Color.sky
    return view
  }()

  private let titleLabel: UILabel = {
    let view: UILabel = UILabel()
    view.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
    view.lineBreakMode = .byTruncatingTail
    view.textColor = .white
    view.numberOfLines = 1
    view.textAlignment = .left
    view.adjustsFontSizeToFitWidth = false
    return view
  }()

  private let priceLabel: UILabel = {
    let view: UILabel = UILabel()
    view.font = UIFont.systemFont(ofSize: 15, weight: .bold)
    view.textColor = .white
    view.text = "Price"
    return view
  }()

  private let priceValueLabel: UILabel = {
    let view: UILabel = UILabel()
    view.font = UIFont.systemFont(ofSize: 15, weight: .bold)
    view.textColor = .white
    view.text = "5"
    return view
  }()

  private let genreLabel: UILabel = {
    let view: UILabel = UILabel()
    view.font = UIFont.systemFont(ofSize: 15, weight: .bold)
    view.textColor = .white
    view.text = "Genre:"
    return view
  }()

  private let genreValueLabel: UILabel = {
    let view: UILabel = UILabel()
    view.font = UIFont.systemFont(ofSize: 15, weight: .bold)
    view.textColor = .white
    view.text = "Drama"
    return view
  }()

  private lazy var genreStackView: UIStackView = {
    let view: UIStackView = UIStackView(arrangedSubviews: [
      genreLabel, genreValueLabel
    ])
    view.axis = .vertical
    view.alignment = .fill
    view.distribution = .fillEqually
    view.spacing = 5.0
    return view
  }()

  private lazy var priceStackView: UIStackView = {
    let view: UIStackView = UIStackView(arrangedSubviews: [
      priceLabel, priceValueLabel
    ])
    view.axis = .vertical
    view.alignment = .fill
    view.distribution = .fillEqually
    view.spacing = 5.0
    return view
  }()

  private lazy var stackHorizontalView: UIStackView = {
    let view: UIStackView = UIStackView()
    view.axis = .horizontal
    view.alignment = .center
    view.distribution = .fillEqually
    view.spacing = 5.0
    return view
  }()

  private lazy var imageBanner: UIImageView = {
    let view: UIImageView = UIImageView()
    view.image = UIImage(named: "repeatingBackground")
    view.clipsToBounds = true
    view.contentMode = .scaleAspectFill
    return view
  }()

  private let descriptionTextView: UITextView = {
    let view: UITextView = UITextView()
    view.isEditable = false
    view.isUserInteractionEnabled = true
    view.backgroundColor = .clear
    view.font = UIFont.boldSystemFont(ofSize: 20)
    view.textColor = .white
    return view
  }()

  // MARK: - Initializer
  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = AppUI.Color.green

    subviews(forAutoLayout: [
      bannerView, stackHorizontalView,
      descriptionTextView
    ])

    bannerView.subviews(forAutoLayout: [
      titleLabel, imageBanner
    ])

    let stackViews: [UIStackView] = [
      priceStackView, genreStackView,
    ]

    stackHorizontalView.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) -> Void in
      make.top.equalTo(self.bannerView.snp.bottom).offset(50.0)
      make.leading.equalToSuperview().offset(20.0)
      make.trailing.equalToSuperview().inset(20.0)
    }

    stackViews.forEach { (stackView: UIStackView) -> Void in
      stackHorizontalView.addArrangedSubview(stackView)
    }
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Instance Methods
  override func layoutSubviews() {
    super.layoutSubviews()
    layoutIfNeeded()
      
    bannerView.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) -> Void in
      make.top.leading.trailing.equalToSuperview()
      make.height.equalTo((self.frame.height / 2) - 100)
    }

    titleLabel.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) -> Void in
      make.top.equalTo(self.safeAreaLayoutGuide).offset(10.0)
      make.centerX.equalToSuperview()
    }

    imageBanner.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) -> Void in
      make.top.equalTo(self.titleLabel.snp.bottom).offset(10.0)
      make.centerX.equalToSuperview()
      make.width.equalTo(80.0)
      make.height.equalTo(110.0)
    }

    descriptionTextView.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) -> Void in
      make.top.equalTo(self.stackHorizontalView.snp.bottom).offset(20.0)
      make.leading.equalToSuperview().offset(20.0)
      make.trailing.equalToSuperview().inset(20.0)
      make.height.equalTo(200.0)
    }
  }

  func configure(track: Track) {
    let imageString: String = "\(track.artworkUrl100)"

    guard
      let thumbNailURL: URL = URL(string: imageString)
    else { return }

    imageBanner.kf.indicatorType = .activity
    imageBanner.kf.setImage(
      with: thumbNailURL,
      placeholder: UIImage(named: "Placeholder"),
      options: [
          .scaleFactor(UIScreen.main.scale),
          .transition(.fade(1)),
          .cacheOriginalImage
      ]) { (result: Result) in
      switch result {
      case .success(let value):
        debugPrint("Task done for: \(value.source.url?.absoluteString ?? "")")
      case .failure(let error):
        debugPrint("Job failed: \(error.localizedDescription)")
      }
    }

    descriptionTextView.text = track.longDescription
    titleLabel.text = track.trackName
    priceValueLabel.text = "$ \(track.trackHdPrice)"
    genreValueLabel.text = track.primaryGenreName
  }
}
