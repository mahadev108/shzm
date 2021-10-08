//
//  UIView+Extension.swift
//  shazamMapProject
//
//  Created by Dmitriy Marchenkov on 08.10.2021.
//

import UIKit

public protocol NibRepresentable: AnyObject {

    static var className: String { get }

    static var nib: UINib { get }
}

public extension NibRepresentable {

    static var className: String {
        String(describing: self)
    }

    static var nib: UINib {
        UINib(nibName: className, bundle: Bundle(for: self))
    }
}


// periphery:ignore
/// Базовый класс для вью с загрузкой из xib
open class NibLoadableView: View, NibLoadable {
    
    private var view: UIView!
    
    override open func commonInit() {
        backgroundColor = .clear
        removeAllSubviews()
        
        view = loadViewFromNib()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        view.fillToSuperview()
        viewDidLoad()
    }
    
    private func removeAllSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
    
    private func loadViewFromNib() -> UIView {
        let object = type(of: self)
        let nib = UINib(nibName: String(describing: object), bundle: Bundle(for: object))
        
        // swiftlint:disable:next force_cast
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView

        return nibView
    }
    
    /// Метод будет вызван после того как вью полностью инициализирована
    open func viewDidLoad() {}
}


public protocol NibLoadable: NibRepresentable {}

public extension NibLoadable where Self: UIView {

    /// Загружаем вьюху из .xib файла и кастим к нужному типу
    static func loadFromNib() -> Self {
        let results: [Any] = nib.instantiate(withOwner: self, options: nil)
        for result in results {
            if let view = result as? Self {
                return view
            }
        }
        fatalError("\(self) not found")
    }
}

/// Базовая вью.
open class View: UIView {
    
    public init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    /// Настройка после инициализации.
    open func commonInit() {}
}

public extension UIView {

    func fillToSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            let left = leftAnchor.constraint(equalTo: superview.leftAnchor)
            let right = rightAnchor.constraint(equalTo: superview.rightAnchor)
            let top = topAnchor.constraint(equalTo: superview.topAnchor)
            let bottom = bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            NSLayoutConstraint.activate([left, right, top, bottom])
        }
    }
}
