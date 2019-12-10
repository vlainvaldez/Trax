//
//  TrackAPIService.swift
//  Trax
//
//  Created by alvin joseph valdez on 12/10/19.
//  Copyright © 2019 alvin joseph valdez. All rights reserved.
//

import Foundation
import Moya

public struct TrackAPIService {
    
    // MARK: - Store Properties
    private let trackProvider: MoyaProvider = MoyaProvider<SearchRequest>()
    
    public func getTracks(completion: @escaping ([Track]) -> Void ) {
        
        self.trackProvider.request(SearchRequest.search) { (result) in
            switch result {
            case .success(let response):
                
                do{
                    let search: Search = try JSONDecoder().decode(
                        Search.self,
                        from: response.data
                    )
                    completion(search.results)
                    
                } catch {
                    print("decoding failed with error: \(error)")
                }

            case .failure(let error):
                print(error)
            }
        }
    }
}
