//
//  MainMapView.swift
//  shazamMapProject
//
//  Created by Dmitriy Marchenkov on 08.10.2021.
//

import MapKit
import UIKit

final class MainMapView: UIView {
    
    public var topContentViewConstraint = NSLayoutConstraint()
    public var centerXDiskViewConstraint = NSLayoutConstraint()
    public var centerYDiskViewConstraint = NSLayoutConstraint()
    
    public let mapView: MKMapView = {
        let view = MKMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public let bottomInfoContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .backgroundColor
        return view
    }()
    
    public let diskView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "DiskImage"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()

    init() {
        super.init(frame: UIScreen.main.bounds)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    public func setContraints() {
        addSubview(mapView)
        addSubview(bottomInfoContainerView)
        addSubview(diskView)

        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        centerXDiskViewConstraint = diskView.centerXAnchor.constraint(equalTo: bottomInfoContainerView.trailingAnchor)
        centerYDiskViewConstraint = diskView.centerYAnchor.constraint(equalTo: bottomInfoContainerView.topAnchor)
        
        NSLayoutConstraint.activate([
            centerXDiskViewConstraint,
            centerYDiskViewConstraint,
            diskView.widthAnchor.constraint(equalToConstant: 211),
            diskView.heightAnchor.constraint(equalToConstant: 211)
        ])

        topContentViewConstraint = bottomInfoContainerView.topAnchor.constraint(
            equalTo: topAnchor,
            constant: abs(UIScreen.main.bounds.height - 216)
        )

        NSLayoutConstraint.activate([
            topContentViewConstraint,
            bottomInfoContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomInfoContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomInfoContainerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
