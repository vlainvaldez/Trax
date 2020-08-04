//
//  MainCoordinator.swift
//  Trax
//
//  Created by alvin joseph valdez on 12/9/19.
//  Copyright © 2019 alvin joseph valdez. All rights reserved.
//

import UIKit

class MainCoordinator: AbstractCoordinator {
      
  // MARK: - Stored Properties
  private let navigationController: UINavigationController
  private let trackAPIService: TrackAPIService = TrackAPIService()
  
  // MARK: - Initializer
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
    super.init()
  }

  // MARK: - Instance Methods
  override func start() {
    super.start()
    trackAPIService.getTracks { (tracks: [Track]) -> Void in
      let vc: MainVC = MainVC(tracks: tracks)
      vc.delegate = self
      self.navigationController.setViewControllers([vc], animated: true)
      self.add(childCoordinator: self)
    }
  }
}


// MARK: - MainVCDelegate Methods
extension MainCoordinator: MainVCDelegate {
  func goToDetail(track: Track) {
    let coordinator: DetailCoordinator = DetailCoordinator(
        navigationController: navigationController,
        track: track
    )
    navigationController.delegate = self

    coordinator.start()
    add(childCoordinator: coordinator)
  }
}

// MARK: - UINavigationControllerDelegate Methods
extension MainCoordinator: UINavigationControllerDelegate {
  func navigationController(
    _ navigationController: UINavigationController,
    didShow viewController: UIViewController,
    animated: Bool
  ) {    
    guard
      let fromViewController = navigationController.transitionCoordinator?.viewController(
          forKey: UITransitionContextViewControllerKey.from),
      !navigationController.viewControllers.contains(fromViewController),
      fromViewController is DetailVC
    else { return }
      
    guard
      let coordinator = childCoordinators.filter({ $0 is DetailCoordinator }).first
    else { return }
      
    remove(childCoordinator: coordinator)
  }
}
