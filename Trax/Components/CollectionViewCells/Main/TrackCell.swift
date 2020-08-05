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
import RealmSwift

class TrackCell: UICollectionViewCell {
        
  // MARK: - Subviews
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
    view.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
    view.textColor = .white
    view.numberOfLines = 1
    view.textAlignment = .center
    view.adjustsFontSizeToFitWidth = false
    view.text = "Sample header"
    view.lineBreakMode = .byTruncatingTail
    return view
  }()
  
  private let priceLabel: UILabel = {
    let view: UILabel = UILabel()
    view.font = UIFont.systemFont(ofSize: 15, weight: .bold)
    view.textColor = .white
    view.text = "Price:"
    return view
  }()

  private let priceValueLabel: UILabel = {
    let view: UILabel = UILabel()
    view.font = UIFont.systemFont(ofSize: 15, weight: .bold)
    view.textColor = .white
    view.text = "5"
    return view
  }()
  
  private lazy var priceStackView: UIStackView = {
    let view: UIStackView = UIStackView(arrangedSubviews: [
      priceLabel, priceValueLabel
    ])
    view.axis = .horizontal
    view.alignment = .fill
    view.distribution = .fillProportionally
    view.spacing = 5.0
    return view
  }()
  
  private lazy var genreStackView: UIStackView = {
    let view: UIStackView = UIStackView(arrangedSubviews: [
      genreLabel, genreValueLabel
    ])
    view.axis = .horizontal
    view.alignment = .fill
    view.distribution = .fillProportionally
    view.spacing = 5.0
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
    view.text = "5"
    return view
  }()
  
  private let lastVisitLabel: UILabel = {
    let view: UILabel = UILabel()
    view.font = UIFont.systemFont(ofSize: 15, weight: .bold)
    view.textColor = .white
    view.text = "Last Visit:"
    return view
  }()

  private let lastVisitValueLabel: UILabel = {
    let view: UILabel = UILabel()
    view.font = UIFont.systemFont(ofSize: 15, weight: .bold)
    view.textColor = .white
    view.text = "Monday"
    return view
  }()
    
  private lazy var lastVisitStackView: UIStackView = {
    let view: UIStackView = UIStackView(arrangedSubviews: [
      lastVisitLabel, lastVisitValueLabel
    ])
    view.axis = .horizontal
    view.alignment = .fill
    view.distribution = .fillProportionally
    view.spacing = 5.0
    return view
  }()
    
  // MARK: - Initializer
  override init(frame: CGRect) {
    super.init(frame: frame)
  
    subviews(forAutoLayout: [ imageContainer])
      
    imageContainer.snp.remakeConstraints { (make: ConstraintMaker) -> Void in
        make.edges.equalToSuperview()
    }
      
    imageContainer.subviews(forAutoLayout: [
      imageView, headerLabel,
      priceStackView, genreStackView,
      lastVisitStackView
    ])
      
    headerLabel.snp.remakeConstraints { (make: ConstraintMaker) -> Void in
      make.top.equalToSuperview().offset(20.0)
      make.leading.equalToSuperview().offset(20.0)
      make.trailing.equalToSuperview().inset(20.0)
    }
      
    imageView.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) -> Void in
      make.top.equalTo(self.headerLabel.snp.bottom).offset(10.0)
      make.centerX.equalToSuperview()
      make.height.equalTo(100.0)
      make.width.equalTo(80.0)
    }
      
    priceStackView.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) -> Void in
      make.top.equalTo(self.imageView.snp.bottom).offset(10.0)
      make.centerX.equalToSuperview()
    }
      
    genreStackView.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) -> Void in
      make.top.equalTo(self.priceStackView.snp.bottom).offset(5.0)
      make.centerX.equalToSuperview()
    }

    lastVisitStackView.snp.remakeConstraints { [unowned self] (make: ConstraintMaker) -> Void in
      make.top.equalTo(self.genreStackView.snp.bottom).offset(5.0)
      make.centerX.equalToSuperview()
    }
    
    setCellCornerRadius()
  }
    
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
    
  override func layoutSubviews() {
    super.layoutSubviews()
  }
}

// MARK: - Configurables

extension TrackCell {
  static var identifier: String {
    return "TrackCell"
  }
    
  func configure(with model: Track) {
      
    let imageString: String = "\(model.artworkUrl100)"
    
    guard let thumbNailURL: URL = URL(string: imageString)
    else { return }
    
    imageView.kf.indicatorType = .activity
    
    headerLabel.text = model.trackName
    priceValueLabel.text = "$ \(model.trackHdPrice)"
    genreValueLabel.text = "\(model.primaryGenreName)"
    
    imageView.kf.setImage(
      with: thumbNailURL,
      placeholder: UIImage(named: "Placeholder"),
      options: [
        .scaleFactor(UIScreen.main.scale),
        .transition(.fade(1)),
        .cacheOriginalImage]) { (result: Result) in
          switch result {
          case .success(let value):
            debugPrint("Task done for: \(value.source.url?.absoluteString ?? "")")
          case .failure(let error):
            debugPrint("Job failed: \(error.localizedDescription)")
          }
        }
      
    let visitPrimaryKey = model.trackId
    
    do {
      let realm = try Realm()
      guard let visit = realm.object(ofType: Visit.self, forPrimaryKey: visitPrimaryKey)
      else {
        lastVisitValueLabel.isHidden = true
        lastVisitLabel.isHidden = true
        return
      }
      lastVisitValueLabel.isHidden = false
      lastVisitLabel.isHidden = false
      lastVisitValueLabel.text = dateFormatter(date: visit.date)
    } catch {
      debugPrint("Realm failed: \(error.localizedDescription)")
    }
  }
}

// MARK: - Helper Methods

extension TrackCell {
  
  private func setCellCornerRadius() {
    layer.cornerRadius = 10
    layer.masksToBounds = true
  }
    
  private func dateFormatter(date: Date) -> String {
    let format = DateFormatter()
    format.timeZone = .current
    format.dateFormat = "MMM d, h:mm a"
    let dateString = format.string(from: date)

    return dateString
  }
}
