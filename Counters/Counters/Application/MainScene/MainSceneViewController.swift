//
//  MainSceneViewController.swift
//  Counters
//
//  Created by Râmede on 05/10/21.
//

import UIKit

class MainSceneViewController: UIViewController {
    private var contentView = MainSceneView()
    
    init() {
        super.init(nibName: nil, bundle: .main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
