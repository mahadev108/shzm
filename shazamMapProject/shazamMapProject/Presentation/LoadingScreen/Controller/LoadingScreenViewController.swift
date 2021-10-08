//
//  LoadingScreenViewController.swift
//  shazamMapProject
//
//  Created by Dmitriy Marchenkov on 08.10.2021.
//

import UIKit

final class LoadingScreenViewController: UIViewController {
    
    let mainView = LoadingScreenView()

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backgroundColor = .backgroundColor
    }
    
    override func loadView() {
        view = mainView
    }

}

