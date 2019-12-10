//
//  MainVCDelegate.swift
//  Trax
//
//  Created by alvin joseph valdez on 12/9/19.
//  Copyright © 2019 alvin joseph valdez. All rights reserved.
//

import Foundation

public protocol MainVCDelegate: class {
    func goToDetail(track: Track)
}
