//
//  TabCoordinator.swift
//  Trax
//
//  Created by alvin joseph valdez on 12/9/19.
//  Copyright © 2019 alvin joseph valdez. All rights reserved.
//

import class UIKit.UIViewController
import class UIKit.UITabBarItem

protocol TabCoordinator: Coordinator {

  /// UIViewController type to be managed by TabCoordinator
  associatedtype ViewController: UIViewController

  /// UIViewController instance being managed
  var viewController: ViewController { get }

  /// UITabBarItem for the UIViewController
  var tabBarItem: UITabBarItem { get }
}
