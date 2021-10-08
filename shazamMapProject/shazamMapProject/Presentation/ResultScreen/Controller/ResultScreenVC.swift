//
//  ResultScreenVC.swift
//  shazamMapProject
//
//  Created by Dmitriy Marchenkov on 08.10.2021.
//

import UIKit

final class ResultScreenViewController: UIViewController {
    
    private let mainView = ResultScreenView()
    private let shazamMedia: ShazamMedia
    
    init(shazamMedia: ShazamMedia) {
        self.shazamMedia = shazamMedia
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.setConstraints(shazamMedia: shazamMedia)
    }
    
}

