//
//  BottomInfoScreenViewController.swift
//  shazamMapProject
//
//  Created by Dmitriy Marchenkov on 08.10.2021.
//

import UIKit

enum Fonts: String {
    case pragmaticaExtended = "PragmaticaExtended-Book"
    case pragmaticaExtendedBold = "PragmaticaExtended-Bold"
}

final class TestView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Твои открытые жанры:"
        label.textColor = .white
        label.font = UIFont(name: Fonts.pragmaticaExtended.rawValue, size: 20)
        return label
    }()
    
    override func hitTest(
        _ point: CGPoint,
        with event: UIEvent?
    ) -> UIView? {
        let view = super.hitTest(point, with: event)
        if view === self {
            return nil
        }
        return view
    }
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: +37),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: +18),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18)
        ])
    }
}

final class BottomInfoScreenViewController: UIViewController {
//
//    let testView = TestView()
//    
//    override func loadView() {
//        view = testView
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .backgroundColor
//    }

}
