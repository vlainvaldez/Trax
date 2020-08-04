//
//  UIView+Extensions.swift
//  Trax
//
//  Created by alvin joseph valdez on 12/10/19.
//  Copyright © 2019 alvin joseph valdez. All rights reserved.
//
import UIKit


extension UIView {
  func subview(forAutoLayout subview: UIView) {
    addSubview(subview)
    subview.translatesAutoresizingMaskIntoConstraints = false
  }

  func subviews(forAutoLayout subviews: UIView...) {
    self.subviews(forAutoLayout: subviews)
  }

  func subviews(forAutoLayout subviews: [UIView]) {
    subviews.forEach(self.subview)
  }
  
  func setRadius(radius: CGFloat? = nil) {
    layer.cornerRadius = radius ?? frame.width / 2
    layer.masksToBounds = true
  }
}
