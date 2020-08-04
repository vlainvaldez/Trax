//
//  DetailVC.swift
//  Trax
//
//  Created by alvin joseph valdez on 12/10/19.
//  Copyright © 2019 alvin joseph valdez. All rights reserved.
//

import UIKit
import RealmSwift

class DetailVC: UIViewController {
  
  // MARK: - Stored Properties
  private let track: Track
  
  // MARK: - Initializer
  init(track: Track) {
    self.track = track
    super.init(nibName: nil, bundle: nil)
  }
    
  required  init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
    
  // MARK: - ViewController Lifecycle Methods
  override func loadView() {
    view = DetailView()
  }
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    rootView.configure(track: track)
    restorationIdentifier = "DetailVC"
    restorationClass = DetailVC.self
  }
}

// MARK: - Views
extension DetailVC {
  unowned var rootView: DetailView { return view as! DetailView }
}

extension DetailVC: UIViewControllerRestoration {
  static func viewController(
    withRestorationIdentifierPath
    identifierComponents: [String],
    coder: NSCoder) -> UIViewController? {
    
    guard
      let vc: DetailVC = DetailVC(coder: coder)
    else { return UIViewController() }
    
    return vc
  }
}

