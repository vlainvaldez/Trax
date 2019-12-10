//
//  Track.swift
//  Trax
//
//  Created by alvin joseph valdez on 12/10/19.
//  Copyright © 2019 alvin joseph valdez. All rights reserved.
//

import Foundation

public struct Search: Decodable {
    let results: [Track]
}

public final class Track: NSObject, Decodable {
    
    // MARK: - Enums
    public enum CodingKeys: String, CodingKey {
        case trackId
        case trackName
        case artworkUrl60
        case collectionPrice
        case trackPrice
        case trackRentalPrice
        case collectionHdPrice
        case trackHdPrice
        case trackHdRentalPrice
        case longDescription
    }
    
    // MARK: - Initializer
    public init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Track.CodingKeys> = try decoder.container(
            keyedBy: Track.CodingKeys.self
        )
        
        self.trackId = try container.decode(Int.self, forKey: Track.CodingKeys.trackId)
        self.trackName = try container.decode(String.self, forKey: Track.CodingKeys.trackName)
        self.artworkUrl60 = try container.decode(URL.self, forKey: Track.CodingKeys.artworkUrl60)
        
        if let collectionPrice = try container.decodeIfPresent(Double.self, forKey: Track.CodingKeys.collectionPrice) {
            self.collectionPrice = collectionPrice
        } else {
            self.collectionPrice = 0.0
        }
        
        if let trackPrice = try container.decodeIfPresent(Double.self, forKey: Track.CodingKeys.trackPrice) {
            self.trackPrice = trackPrice
        } else {
            self.trackPrice = 0.0
        }
        
        if let trackRentalPrice = try container.decodeIfPresent(Double.self, forKey: Track.CodingKeys.trackRentalPrice) {
            self.trackRentalPrice = trackRentalPrice
        } else {
            self.trackRentalPrice = 0.0
        }
        
        if let collectionHdPrice = try container.decodeIfPresent(Double.self, forKey: Track.CodingKeys.collectionHdPrice) {
            self.collectionHdPrice = collectionHdPrice
        } else {
            self.collectionHdPrice = 0.0
        }
        
        if let trackHdPrice = try container.decodeIfPresent(Double.self, forKey: Track.CodingKeys.trackHdPrice) {
            self.trackHdPrice = trackHdPrice
        } else {
            self.trackHdPrice = 0.0
        }
        
        if let trackHdRentalPrice = try container.decodeIfPresent(Double.self, forKey: Track.CodingKeys.trackHdRentalPrice) {
            self.trackHdRentalPrice = trackHdRentalPrice
        } else {
            self.trackHdRentalPrice = 0.0
        }
        
        self.longDescription = try container.decode(String.self, forKey: Track.CodingKeys.longDescription)

        super.init()
    }
    
    // MARK: Stored Properties
    public let trackId: Int
    public let trackName: String
    public let artworkUrl60: URL
    public let collectionPrice: Double
    public let trackPrice: Double
    public let trackRentalPrice: Double
    public let collectionHdPrice: Double
    public let trackHdPrice: Double
    public let trackHdRentalPrice: Double
    public let longDescription: String
}
