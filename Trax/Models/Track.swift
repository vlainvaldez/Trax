//
//  Track.swift
//  Trax
//
//  Created by alvin joseph valdez on 12/10/19.
//  Copyright © 2019 alvin joseph valdez. All rights reserved.
//
import Foundation

struct Search: Decodable {
  let results: [Track]
}


class Track: NSObject, Decodable {

  // MARK: Stored Properties
  
  let trackId: Int
  let trackName: String
  let artworkUrl100: URL
  let collectionPrice: Double
  let trackPrice: Double
  let trackRentalPrice: Double
  let collectionHdPrice: Double
  let trackHdPrice: Double
  let trackHdRentalPrice: Double
  let longDescription: String
  let primaryGenreName: String

  // MARK: - Enums
  
  enum CodingKeys: String, CodingKey {
  case trackId
  case trackName
  case artworkUrl100
  case collectionPrice
  case trackPrice
  case trackRentalPrice
  case collectionHdPrice
  case trackHdPrice
  case trackHdRentalPrice
  case longDescription
  case primaryGenreName
  }

  // MARK: - Initializer
  
  required init(from decoder: Decoder) throws {
    let container: KeyedDecodingContainer<Track.CodingKeys> = try
      decoder.container(
        keyedBy: Track.CodingKeys.self
      )
    trackId = try container.decode(
      Int.self,
      forKey: Track.CodingKeys.trackId)
    trackName = try container.decode(
      String.self,
      forKey: Track.CodingKeys.trackName)
    artworkUrl100 = try container.decode(
      URL.self,
      forKey: Track.CodingKeys.artworkUrl100)
        
    if let collectionPrice = try container.decodeIfPresent(
      Double.self,
      forKey: Track.CodingKeys.collectionPrice) {
      self.collectionPrice = collectionPrice
    } else {
      collectionPrice = 0.0
    }
        
    if let trackPrice = try container.decodeIfPresent(
      Double.self,
      forKey: Track.CodingKeys.trackPrice) {
      self.trackPrice = trackPrice
    } else {
      trackPrice = 0.0
    }
        
    if let trackRentalPrice = try container.decodeIfPresent(
      Double.self,
      forKey: Track.CodingKeys.trackRentalPrice) {
        self.trackRentalPrice = trackRentalPrice
    } else {
        trackRentalPrice = 0.0
    }
        
    if let collectionHdPrice = try container.decodeIfPresent(
      Double.self,
      forKey: Track.CodingKeys.collectionHdPrice) {
      self.collectionHdPrice = collectionHdPrice
    } else {
      collectionHdPrice = 0.0
    }
    
    if let trackHdPrice = try container.decodeIfPresent(
      Double.self,
      forKey: Track.CodingKeys.trackHdPrice) {
      self.trackHdPrice = trackHdPrice
    } else {
      trackHdPrice = 0.0
    }
    
    if let trackHdRentalPrice = try container.decodeIfPresent(
      Double.self,
      forKey: Track.CodingKeys.trackHdRentalPrice) {
      self.trackHdRentalPrice = trackHdRentalPrice
    } else {
      trackHdRentalPrice = 0.0
    }
    
    longDescription = try container.decode(
      String.self,
      forKey: Track.CodingKeys.longDescription)
    primaryGenreName = try container.decode(
      String.self,
      forKey: Track.CodingKeys.primaryGenreName)

    super.init()
  }
}
