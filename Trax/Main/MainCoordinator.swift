//
//  MainCoordinator.swift
//  Trax
//
//  Created by alvin joseph valdez on 12/9/19.
//  Copyright © 2019 alvin joseph valdez. All rights reserved.
//

import UIKit

public final class MainCoordinator: AbstractCoordinator {
    
    // MARK: - Initializer
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    // MARK: - Stored Properties
    private let navigationController: UINavigationController
    private let trackAPIService: TrackAPIService = TrackAPIService()
    
    // MARK: - Instance Methods
    public override func start() {
        super.start()
        
        self.trackAPIService.getTracks { (tracks: [Track]) -> Void in
            let vc: MainVC = MainVC(tracks: tracks)
            vc.delegate = self
            self.navigationController.setViewControllers([vc], animated: true)
            self.add(childCoordinator: self)
        }
    }
    
}


// MARK: - MainVCDelegate Methods
extension MainCoordinator: MainVCDelegate {
    public func goToDetail(track: Track) {
        
        let coordinator: DetailCoordinator = DetailCoordinator(
            navigationController: self.navigationController,
            track: track
        )
        
        self.navigationController.delegate = self

        coordinator.start()
        self.add(childCoordinator: coordinator)
    }
}

// MARK: - UINavigationControllerDelegate Methods
extension MainCoordinator: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard
            let fromViewController = navigationController.transitionCoordinator?.viewController(
                forKey: UITransitionContextViewControllerKey.from
            ),
            !navigationController.viewControllers.contains(fromViewController),
            fromViewController is DetailVC
        else { return }
        
        guard let coordinator = self.childCoordinators.filter({ $0 is DetailCoordinator }).first
            else { return }
        
        self.remove(childCoordinator: coordinator)
    }
}
