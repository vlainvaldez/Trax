//
//  TrackCell.swift
//  Trax
//
//  Created by alvin joseph valdez on 12/10/19.
//  Copyright © 2019 alvin joseph valdez. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

public final class TrackCell: UICollectionViewCell {
        
    // MARK: Subviews
    private let imageContainer: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = AppUI.Color.sky
        return view
    }()
    
    public lazy var imageView: UIImageView = {
        let view: UIImageView = UIImageView()
        view.clipsToBounds = true
        view.image = UIImage(named: "Placeholder")
        return view
    }()
    
    private let headerLabel: UILabel = {
        let view: UILabel = UILabel()
        view.font = UIFont.systemFont(ofSize: 16.0, weight: UIFont.Weight.bold)
        view.textColor = UIColor.white
        view.numberOfLines = 1
        view.textAlignment = NSTextAlignment.center
        view.adjustsFontSizeToFitWidth = false
        view.text = "Sample header"
        view.lineBreakMode = .byTruncatingTail
        return view
    }()
    
    private let priceLabel: UILabel = {
        let view: UILabel = UILabel()
        view.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
        view.textColor = UIColor.white
        view.text = "Price:"
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
        view.text = "5"
        return view
    }()
    
    // MARK: - Initializer
    public override init(frame: CGRect) {
        super.init(frame: frame)
    
        self.subviews(forAutoLayout: [ self.imageContainer])
        
        self.imageContainer.snp.remakeConstraints { (make: ConstraintMaker) -> Void in
            make.edges.equalToSuperview()
        }
        
        self.imageContainer.subviews(forAutoLayout: [
            self.imageView, self.headerLabel,
            self.priceLabel, self.priceValueLabel,
            self.genreLabel, self.genreValueLabel
        ])
        
        self.headerLabel.snp.remakeConstraints { (make: ConstraintMaker) -> Void in
            make.top.equalToSuperview().offset(5.0)
            make.leading.equalToSuperview().offset(20.0)
            make.trailing.equalToSuperview().inset(20.0)
        }
        
        self.imageView.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) -> Void in
            make.top.equalTo(self.headerLabel.snp.bottom).offset(10.0)
            make.centerX.equalToSuperview()
            make.height.equalTo(100.0)
            make.width.equalTo(80.0)
        }
        
        self.priceLabel.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) -> Void in
            make.top.equalTo(self.imageView.snp.bottom).offset(5.0)
            make.leading.equalTo(self.imageView)
        }
        
        self.priceValueLabel.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) -> Void in
            make.leading.equalTo(self.priceLabel.snp.trailing).offset(5.0)
            make.top.equalTo(self.priceLabel)
        }
        
        self.genreLabel.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) -> Void in
            make.top.equalTo(self.priceValueLabel.snp.bottom).offset(5.0)
            make.leading.equalToSuperview().offset(50.0)
        }
        
        self.genreValueLabel.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) -> Void in
            make.leading.equalTo(self.genreLabel.snp.trailing).offset(5.0)
            make.top.equalTo(self.genreLabel)
        }
        
        self.setCellCornerRadius()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}

// MARK: Configurables
extension TrackCell {
    public static var identifier: String {
        return "TrackCell"
    }
    
    public func configure(with model: Track) {
        
        let imageString: String = "\(model.artworkUrl100)"
        
        guard
            let thumbNailURL: URL = URL(string: imageString)
        else { return }
        
        self.imageView.kf.indicatorType = .activity
        
        self.headerLabel.text = model.trackName
        self.priceValueLabel.text = "\(model.trackHdPrice)"
        self.genreValueLabel.text = "\(model.primaryGenreName)"
        
        self.imageView.kf.setImage(with: thumbNailURL, placeholder: UIImage(named: "Placeholder"), options: [.scaleFactor(UIScreen.main.scale),
        .transition(.fade(1)),
        .cacheOriginalImage]) { (result: Result) in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - Helper Methods
extension TrackCell {
    private func setCellCornerRadius() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
}