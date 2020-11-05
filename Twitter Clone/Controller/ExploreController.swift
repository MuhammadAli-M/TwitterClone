//
//  ExploreController.swift
//  Twitter Clone
//
//  Created by Muhammad Adam on 7/20/20.
//  Copyright © 2020 MA. All rights reserved.
//

import UIKit

class ExploreController: UIViewController {
    
    // MARK: Properties
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: Helpers
    func configureUI(){
        view.backgroundColor = .systemBlue
        navigationItem.title = "Explore"
    }
    
}
