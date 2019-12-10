//
//  MainDataSource.swift
//  Trax
//
//  Created by alvin joseph valdez on 12/10/19.
//  Copyright © 2019 alvin joseph valdez. All rights reserved.
//

import UIKit

public final class MainDataSource: NSObject {
    
    // MARK: - Initializer
    public init(collectionView: UICollectionView, tracks: [Track]) {
        self.collectionView = collectionView
        self.tracks = tracks
        self.numberOfCells = tracks.count
        super.init()
        
        self.collectionView.register(
            TrackCell.self,
            forCellWithReuseIdentifier: TrackCell.identifier
        )
        
        self.collectionView.dataSource = self
    }
    
    // MARK: - Stored Properties
    public unowned let collectionView: UICollectionView
    public var tracks: [Track]
    private var numberOfCells: Int
    private var page: Int = 1
    
}

extension MainDataSource: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tracks.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TrackCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TrackCell.identifier,
            for: indexPath) as! TrackCell
        
        cell.configure(with: self.tracks[indexPath.row])
        
        return cell
    }
    
}
