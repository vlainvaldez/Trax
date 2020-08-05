//
//  Visit.swift
//  Trax
//
//  Created by alvin joseph valdez on 12/10/19.
//  Copyright © 2019 alvin joseph valdez. All rights reserved.
//

import Foundation
import RealmSwift

class Visit: Object {
  @objc dynamic var trackId: Int = 0
  @objc dynamic var date: Date = Date()
  
  override class func primaryKey() -> String? {
    return "trackId"
  }
}
