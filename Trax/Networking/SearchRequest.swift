//
//  SearchRequest.swift
//  Trax
//
//  Created by alvin joseph valdez on 12/10/19.
//  Copyright © 2019 alvin joseph valdez. All rights reserved.
//

import Foundation
import Moya

enum SearchRequest {
  case search
}

extension SearchRequest: TargetType {
  var baseURL: URL {
    return URL(string: "https://itunes.apple.com")!
  }
    
  var path: String {
    switch self {
    case .search:
      return "/search"
    }
  }
    
  var method: Moya.Method {
    switch self {
    case .search:
      return Moya.Method.get
    }
  }
  
  var sampleData: Data {
    return Data()
  }
  
  var task: Task {
    switch self {
    case .search:
      return .requestParameters(
        parameters: [
          "term": "star",
          "country": "au",
          "media": "movie",
          "all": ""
        ],
        encoding: URLEncoding.queryString)
    }
  }

  var headers: [String : String]? {
    return [
      "Content-Type": "application/json"
    ]
  }
}
