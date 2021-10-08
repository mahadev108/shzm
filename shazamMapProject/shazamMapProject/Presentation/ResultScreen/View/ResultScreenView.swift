//
//  ResultScreenView.swift
//  shazamMapProject
//
//  Created by Dmitriy Marchenkov on 08.10.2021.
//

import UIKit

private final class TrackView: UIView {
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: 98)
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "FoilSilver"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    let artistLabel: UILabel = {
        let label = UILabel()
        label.text = "The Glitch Mob"
        label.font = UIFont(name: Fonts.pragmaticaExtended.rawValue, size: 16)
        return label
    }()
    
    let trackLabel: UILabel = {
        let label = UILabel()
        label.text = "We can make the world stop"
        label.font = UIFont(name: Fonts.pragmaticaExtended.rawValue, size: 20)
        return label
    }()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupStackView()
    }
    
    func setupStackView() {
        addSubview(imageView)
        addSubview(contentStackView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 98)
        ])
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        contentStackView.addArrangedSubview(artistLabel)
        contentStackView.addArrangedSubview(trackLabel)
    }
    
}

final class ResultScreenView: UIView {
    
    let fireLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "🔥 🔥 🔥"
        label.font = .systemFont(ofSize: 38)
        return label
    }()
    
    let resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Вы открыли \n2 новых\nжанра"
        label.numberOfLines = 0
        label.font = UIFont(name: Fonts.pragmaticaExtendedBold.rawValue, size: 38)
        return label
    }()
    
    let contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .backgroundColor
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    let genresScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    let genresStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let trackImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .orange
        return imageView
    }()
    
    private let trackView: TrackView = {
        let trackView = TrackView()
        return trackView
    }()
    
    private let genresLabel: UILabel = {
        let label = UILabel()
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
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        trackImageView.layer.cornerRadius = trackImageView.frame.height / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        addSubview(contentScrollView)
        contentScrollView.addSubview(contentStackView)
        
        NSLayoutConstraint.activate([
            contentScrollView.topAnchor.constraint(equalTo: topAnchor),
            contentScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentScrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentScrollView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: contentScrollView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor)
        ])
        
        contentStackView.addArrangedSubview(fireLabel)
        contentStackView.addArrangedSubview(resultLabel)
        
        contentStackView.addArrangedSubview(genresScrollView)
        
        genresScrollView.addSubview(genresStackView)
        
        NSLayoutConstraint.activate([
            genresScrollView.widthAnchor.constraint(equalTo: widthAnchor),
            genresStackView.topAnchor.constraint(equalTo: genresScrollView.topAnchor),
            genresStackView.leadingAnchor.constraint(equalTo: genresScrollView.leadingAnchor),
            genresStackView.trailingAnchor.constraint(equalTo: genresScrollView.trailingAnchor),
            genresStackView.bottomAnchor.constraint(equalTo: genresScrollView.bottomAnchor)
        ])
        
        
        contentStackView.addArrangedSubview(trackImageView)
        contentStackView.addArrangedSubview(trackView)
        
        NSLayoutConstraint.activate([
            trackImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.95),
            trackImageView.heightAnchor.constraint(equalTo: trackImageView.widthAnchor)
        ])

    }
    
}
