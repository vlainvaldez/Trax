//
//  AppMainCoordinator.swift
//  Trax
//
//  Created by alvin joseph valdez on 12/9/19.
//  Copyright © 2019 alvin joseph valdez. All rights reserved.
//

import UIKit

open class AppMainCoordinator: AbstractCoordinator {
    
    // MARK: Initializer
    public init(window: UIWindow, rootViewController: UINavigationController) {
        self.window = window
        self.rootViewController = rootViewController
        super.init()
        
        self.window.rootViewController = self.rootViewController
        self.window.makeKeyAndVisible()
        
    }
    
    // MARK: Stored Properties
    private unowned let rootViewController: UINavigationController
    private unowned let window: UIWindow
    private let trackAPIService: TrackAPIService = TrackAPIService()
    
    // MARK: Instance Methods
    public override func start() {
        super.start()
        
        self.trackAPIService.getTracks { (tracks: [Track]) -> Void in
            tracks.forEach { (track: Track) in
                print(track.trackId)
            }
        }
    
        let coordinator: MainCoordinator = MainCoordinator(
            navigationController: self.rootViewController
        )
        
        coordinator.start()
        self.add(childCoordinator: self)
    }
}
