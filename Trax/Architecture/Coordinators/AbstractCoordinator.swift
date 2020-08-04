//
//  AbstractCoordinator.swift
//  Trax
//
//  Created by alvin joseph valdez on 12/9/19.
//  Copyright © 2019 alvin joseph valdez. All rights reserved.
//

import UIKit

open class AbstractCoordinator: NSObject, Coordinator {
  
  override public init() {
    guard
      type(of: self) != AbstractCoordinator.self
    else {
      fatalError(
        "AbstractCoordinator instances cannot be created. Use subclasses instead"
      )
    }
    super.init()
  }

  // MARK: Stored Properties
  
  /// Instance variable of an array of childCoordinators
  private var _childCoordinators: [Coordinator] = []
  
  /// Boolean to trigger a crash if start method is called multiple times in the lifetime of the instance.
  private(set) var hasStarted: Bool = false

  // MARK: Computed Properties
  var childCoordinators: [Coordinator] {
    return _childCoordinators
  }

  // MARK: Instance Methods
  open func start() {
    switch hasStarted {
    case true:
      fatalError(
        """
        \(#function) has already been called once in the lifetime of this coordinator.
        \(#function) is only intended to be called once.
        """
      )
    case false:
      hasStarted = true
    }
  }

  func add(childCoordinator coordinator: Coordinator) {
    _childCoordinators.append(coordinator)
  }

  func remove(childCoordinator coordinator: Coordinator) {
    _childCoordinators = childCoordinators.filter { $0 !== coordinator }
  }
}
