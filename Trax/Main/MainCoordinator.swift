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
            self.navigationController.setViewControllers([vc], animated: true)
            self.add(childCoordinator: self)
        }
    }
    
}
