//
//  DetailVC.swift
//  Trax
//
//  Created by alvin joseph valdez on 12/10/19.
//  Copyright © 2019 alvin joseph valdez. All rights reserved.
//

import UIKit
import RealmSwift

public final class DetailVC: UIViewController {
    
    // MARK: - Initializer
    public init(track: Track) {
        self.track = track
        super.init(nibName: nil, bundle: nil)
    }
    
    public required  init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController Lifecycle Methods
    
    public override func loadView() {
        self.view = DetailView()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView.configure(track: self.track)
        self.restorationIdentifier = "DetailVC"
        self.restorationClass = DetailVC.self
    }
    
    // MARK: - Stored Properties
    private let track: Track
}

// MARK: - Views
extension DetailVC {
    unowned var rootView: DetailView { return self.view as! DetailView }
}

extension DetailVC: UIViewControllerRestoration {
    public static func viewController(withRestorationIdentifierPath identifierComponents: [String], coder: NSCoder) -> UIViewController? {
        
        
        guard let vc: DetailVC = DetailVC(coder: coder) else { return UIViewController() }
        
        return vc
        
    }
}

