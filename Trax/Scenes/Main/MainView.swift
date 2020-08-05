//
//  MainView.swift
//  Trax
//
//  Created by alvin joseph valdez on 12/9/19.
//  Copyright © 2019 alvin joseph valdez. All rights reserved.
//

import UIKit
import SnapKit

class MainView: UIView {
    
  // MARK: Subviews
  
  let collectionView: UICollectionView = {
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = 10.0
    layout.minimumInteritemSpacing = 10.0
    layout.sectionInset = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    let view: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    view.backgroundColor = AppUI.Color.green
    view.showsVerticalScrollIndicator = false
    return view
  }()
    
  // MARK: - Initializer
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = AppUI.Color.green
    
    subviews(forAutoLayout: [
      collectionView
    ])
    
    collectionView.snp.remakeConstraints { (make: ConstraintMaker) -> Void in
      make.edges.equalToSuperview()
    }
  }
    
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
    
  // MARK: - Deinitializer
  
  deinit {
    debugPrint("\(type(of: self)) was deallocated")
  }
}
