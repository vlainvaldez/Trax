//
//  ViewController.swift
//  Trax
//
//  Created by alvin joseph valdez on 12/9/19.
//  Copyright © 2019 alvin joseph valdez. All rights reserved.
//

import UIKit

public final class MainVC: UIViewController {
    
    // MARK: Delegate Declarations
    public weak var delegate: MainVCDelegate?
    
    // MARK: - Initializer
    public init(tracks: [Track]) {
        self.tracks = tracks
        super.init(nibName: nil, bundle: nil)
        self.dataSource = MainDataSource(
            collectionView: self.rootView.collectionView,
            tracks: tracks
        )
        
        self.rootView.collectionView.delegate = self
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Deinitializer
    deinit {
        print("\(type(of: self)) was deallocated")
    }
    
    // MARK: - LifeCycle Methods
    public override func loadView() {
        super.loadView()
        self.view = MainView()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Trax"
    }
    
    // MARK: - Stored Properties
    private let tracks: [Track]
    private var dataSource: MainDataSource!
}

// MARK: - Views
extension MainVC {
    public var rootView: MainView { return self.view as! MainView }
}

// MARK: - UICollectionViewDelegateFlowLayout Functions
extension MainVC: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           self.cellTapped(track: self.tracks[indexPath.item])
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(
            width: self.rootView.collectionView.frame.width - 30.0,
            height: (self.rootView.collectionView.frame.height) / 3.5
        )
    }
}

// MARK: - MainVCDelegate Methods
extension MainVC {
    private func cellTapped(track: Track) {
        self.delegate?.goToDetail(track: track)
    }
}
