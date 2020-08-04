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
  public let trackId: Int
  public let trackName: String
  public let artworkUrl100: URL
  public let collectionPrice: Double
  public let trackPrice: Double
  public let trackRentalPrice: Double
  public let collectionHdPrice: Double
  public let trackHdPrice: Double
  public let trackHdRentalPrice: Double
  public let longDescription: String
  public let primaryGenreName: String

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
