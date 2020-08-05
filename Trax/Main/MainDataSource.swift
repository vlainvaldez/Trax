//
//  MainDataSource.swift
//  Trax
//
//  Created by alvin joseph valdez on 12/10/19.
//  Copyright © 2019 alvin joseph valdez. All rights reserved.
//

import UIKit

class MainDataSource: NSObject {
  
  // MARK: - Stored Properties
  unowned let collectionView: UICollectionView
  var tracks: [Track]
  private var numberOfCells: Int
  private var page: Int = 1
    
  // MARK: - Initializer
  init(collectionView: UICollectionView, tracks: [Track]) {
    self.collectionView = collectionView
    self.tracks = tracks
    numberOfCells = tracks.count
    super.init()
      
    collectionView.register(
      TrackCell.self,
      forCellWithReuseIdentifier: TrackCell.identifier
    )
    collectionView.dataSource = self
  }
}

extension MainDataSource: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return tracks.count
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell: TrackCell = collectionView.dequeueReusableCell(
      withReuseIdentifier: TrackCell.identifier,
      for: indexPath) as! TrackCell
    
    cell.configure(with: tracks[indexPath.row])
    return cell
  }
}
