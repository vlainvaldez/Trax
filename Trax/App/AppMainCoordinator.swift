//
//  AppMainCoordinator.swift
//  Trax
//
//  Created by alvin joseph valdez on 12/9/19.
//  Copyright © 2019 alvin joseph valdez. All rights reserved.
//

import UIKit

open class AppMainCoordinator: AbstractCoordinator {
    
  // MARK: Stored Properties
  private unowned let rootViewController: UINavigationController
  private unowned let window: UIWindow
  private let trackAPIService: TrackAPIService = TrackAPIService()
  
  // MARK: Initializer
  init(window: UIWindow, rootViewController: UINavigationController) {
    self.window = window
    self.rootViewController = rootViewController
    super.init()
    
    UINavigationBar.appearance().isTranslucent = false
    UINavigationBar.appearance().barTintColor = AppUI.Color.sky
    UINavigationBar.appearance().tintColor = UIColor.white
    UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: AppUI.Color.lightYellow]
    
    window.rootViewController = self.rootViewController
    window.makeKeyAndVisible()
  }
  
  // MARK: Instance Methods
  open override func start() {
    super.start()

    let coordinator: MainCoordinator = MainCoordinator(
      navigationController: self.rootViewController
    )
    
    coordinator.start()
    self.add(childCoordinator: self)
  }
}
