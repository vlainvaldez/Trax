//
//  ViewController.swift
//  Trax
//
//  Created by alvin joseph valdez on 12/9/19.
//  Copyright © 2019 alvin joseph valdez. All rights reserved.
//

import UIKit
import RealmSwift

class MainVC: UIViewController {
    
  // MARK: - Stored Properties
  let tracks: [Track]
  var dataSource: MainDataSource!
  
  // MARK: Delegate Declarations
  weak var delegate: MainVCDelegate?
    
  // MARK: - Initializer
  init(tracks: [Track]) {
    self.tracks = tracks
    super.init(nibName: nil, bundle: nil)
    dataSource = MainDataSource(
        collectionView: rootView.collectionView,
        tracks: tracks
    )
    
    rootView.collectionView.delegate = self
    restorationIdentifier = "MainVC"
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Deinitializer
  deinit {
    debugPrint("\(type(of: self)) was deallocated")
  }
  
  // MARK: - LifeCycle Methods
  override func loadView() {
    super.loadView()
    view = MainView()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "VideoCity"
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    rootView.collectionView.reloadData()
  }
}

// MARK: - Views
extension MainVC {
  var rootView: MainView { return self.view as! MainView }
}

// MARK: - UICollectionViewDelegateFlowLayout Functions
extension MainVC: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
    let track = tracks[indexPath.item]
      
    cellTapped(track: track)
    let visit = Visit()
    visit.trackId = track.trackId
    visit.date = Date()
      
    do {
      let realm = try Realm()
      try realm.write {
        realm.add(visit, update: Realm.UpdatePolicy.all)
      }
    } catch {
      debugPrint("realm failed: \(error.localizedDescription)")
    }
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    
    return CGSize(
      width: rootView.collectionView.frame.width - 30.0,
      height: (rootView.collectionView.frame.height) / 2.5
    )
  }
}

// MARK: - MainVCDelegate Methods
extension MainVC {
  func cellTapped(track: Track) {
    delegate?.goToDetail(track: track)
  }
}
