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

public final class DetailView: UIView {

    // MARK: - Subviews
    private let bannerView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = AppUI.Color.sky
        return view
    }()

    private let titleLabel: UILabel = {
        let view: UILabel = UILabel()
        view.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.heavy)
        view.lineBreakMode = .byTruncatingTail
        view.textColor = UIColor.white
        view.numberOfLines = 1
        view.textAlignment = .left
        view.adjustsFontSizeToFitWidth = false
        return view
    }()

    private let priceLabel: UILabel = {
        let view: UILabel = UILabel()
        view.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
        view.textColor = UIColor.white
        view.text = "Price"
        return view
    }()

    private let priceValueLabel: UILabel = {
        let view: UILabel = UILabel()
        view.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
        view.textColor = UIColor.white
        view.text = "5"
        return view
    }()

    private let genreLabel: UILabel = {
        let view: UILabel = UILabel()
        view.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
        view.textColor = UIColor.white
        view.text = "Genre:"
        return view
    }()

    private let genreValueLabel: UILabel = {
        let view: UILabel = UILabel()
        view.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
        view.textColor = UIColor.white
        view.text = "Drama"
        return view
    }()

    private lazy var genreStackView: UIStackView = {
        let view: UIStackView = UIStackView(arrangedSubviews: [
                self.genreLabel, self.genreValueLabel
            ]
        )
        view.axis = NSLayoutConstraint.Axis.vertical
        view.alignment = UIStackView.Alignment.fill
        view.distribution = UIStackView.Distribution.fillEqually
        view.spacing = 5.0
        return view
    }()

    private lazy var priceStackView: UIStackView = {
        let view: UIStackView = UIStackView(arrangedSubviews: [
                self.priceLabel, self.priceValueLabel
            ]
        )
        view.axis = NSLayoutConstraint.Axis.vertical
        view.alignment = UIStackView.Alignment.fill
        view.distribution = UIStackView.Distribution.fillEqually
        view.spacing = 5.0
        return view
    }()

    private lazy var stackHorizontalView: UIStackView = {
        let view: UIStackView = UIStackView()
        view.axis = NSLayoutConstraint.Axis.horizontal
        view.alignment = UIStackView.Alignment.center
        view.distribution = UIStackView.Distribution.fillEqually
        view.spacing = 5.0
        return view
    }()

    private lazy var imageBanner: UIImageView = {
        let view: UIImageView = UIImageView()
        view.image = UIImage(named: "repeatingBackground")
        view.clipsToBounds = true
        view.contentMode = UIImageView.ContentMode.scaleAspectFill
        return view
    }()

    private let descriptionTextView: UITextView = {
        let view: UITextView = UITextView()
        view.isEditable = false
        view.isUserInteractionEnabled = true
        view.backgroundColor = UIColor.clear
        view.font = UIFont.boldSystemFont(ofSize: 20)
        view.textColor = UIColor.white
        return view
    }()

    // MARK: - Initializer
    public override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = AppUI.Color.green

        self.subviews(forAutoLayout: [
                self.bannerView, self.stackHorizontalView,
                self.descriptionTextView
            ]
        )

        self.bannerView.subviews(forAutoLayout: [
            self.titleLabel, self.imageBanner
        ])

        let stackViews: [UIStackView] = [
            self.priceStackView, self.genreStackView,
        ]

        self.stackHorizontalView.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) -> Void in
            make.top.equalTo(self.bannerView.snp.bottom).offset(50.0)
            make.leading.equalToSuperview().offset(20.0)
            make.trailing.equalToSuperview().inset(20.0)
        }

        stackViews.forEach { (stackView: UIStackView) -> Void in
            self.stackHorizontalView.addArrangedSubview(stackView)
        }

    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Instance Methods
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutIfNeeded()
        
        self.bannerView.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) -> Void in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo((self.frame.height / 2) - 100)
        }

        self.titleLabel.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) -> Void in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(10.0)
            make.centerX.equalToSuperview()
        }

        self.imageBanner.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) -> Void in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10.0)
            make.centerX.equalToSuperview()
            make.width.equalTo(80.0)
            make.height.equalTo(110.0)
        }

        self.descriptionTextView.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) -> Void in
            make.top.equalTo(self.stackHorizontalView.snp.bottom).offset(20.0)
            make.leading.equalToSuperview().offset(20.0)
            make.trailing.equalToSuperview().inset(20.0)
            make.height.equalTo(200.0)
        }
    }

    public func configure(track: Track) {
        let imageString: String = "\(track.artworkUrl100)"

        guard
            let thumbNailURL: URL = URL(string: imageString)
            else { return }

        self.imageBanner.kf.indicatorType = .activity
        self.imageBanner.kf.setImage(
            with: thumbNailURL,
            placeholder: UIImage(named: "Placeholder"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ]
        ) { (result: Result) in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }

        self.descriptionTextView.text = track.longDescription
        self.titleLabel.text = track.trackName
        self.priceValueLabel.text = "$ \(track.trackHdPrice)"
        self.genreValueLabel.text = track.primaryGenreName
    }
}
