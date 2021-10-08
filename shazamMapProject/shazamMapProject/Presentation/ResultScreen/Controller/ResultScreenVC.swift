//
//  ResultScreenVC.swift
//  shazamMapProject
//
//  Created by Dmitriy Marchenkov on 08.10.2021.
//

import UIKit

final class ResultScreenViewController: UIViewController {
    
    private let mainView = ResultScreenView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

