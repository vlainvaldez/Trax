//
//  AnyTabCoordinator.swift
//  Trax
//
//  Created by alvin joseph valdez on 12/9/19.
//  Copyright © 2019 alvin joseph valdez. All rights reserved.
//

import class UIKit.UIViewController
import class UIKit.UITabBarItem


/// AnyTabCoordinator is a class for type erasure on a TabCoordinator instance
open class AnyTabCoordinator {

  // MARK: Initializer
    
  /// AnyTabCoordinator is a class for type erasure on a TabCoordinator instance
  /// parameter tabCoordinator: The TabCoordinator instance to be type erased.
  init<T: TabCoordinator>(_ tabCoordinator: T) {
    self.viewController = tabCoordinator.viewController
    self.tabBarItem = tabCoordinator.tabBarItem
  }

  // MARK: Stored Properties
    
  /// UIViewController instance being managed
  let viewController: UIViewController

    
  /// UITabBarItem for the UIViewController
  let tabBarItem: UITabBarItem
}
