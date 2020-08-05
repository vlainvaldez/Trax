//
//  TrackAPIService.swift
//  Trax
//
//  Created by alvin joseph valdez on 12/10/19.
//  Copyright © 2019 alvin joseph valdez. All rights reserved.
//

import Foundation
import Moya

struct TrackAPIService {
    
  // MARK: - Store Properties
  
  private let trackProvider: MoyaProvider = MoyaProvider<SearchRequest>()
  
  func getTracks(completion: @escaping SingleResult<[Track]> ) {
    trackProvider.request(SearchRequest.search) { (result) in
      switch result {
      case .success(let response):
        do{
          let search: Search = try JSONDecoder().decode(
            Search.self,
            from: response.data)
          completion(search.results)
        } catch {
          debugPrint("decoding failed with error: \(error)")
        }
      case .failure(let error):
        debugPrint(error)
      }
    }
  }
}
