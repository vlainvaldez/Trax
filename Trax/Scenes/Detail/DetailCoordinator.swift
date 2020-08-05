//
//  DetailCoordinator.swift
//  Trax
//
//  Created by alvin joseph valdez on 12/10/19.
//  Copyright © 2019 alvin joseph valdez. All rights reserved.
//

import UIKit

class DetailCoordinator: AbstractCoordinator {

  // MARK: - Stored Properties
  private unowned let navigationController: UINavigationController
  private let track: Track
  
  // MARK: - Initializer
  init(navigationController: UINavigationController, track: Track) {
    self.navigationController = navigationController
    self.track = track
    super.init()
  }
      
  // MARK: - Instance Methods
  override func start() {
    super.start()
    let vc: DetailVC = DetailVC(track: track)
    navigationController.pushViewController(vc, animated: true)
  }
}
