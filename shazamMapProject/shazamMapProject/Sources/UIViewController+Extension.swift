//
//  UIViewController+Extension.swift
//  Highlights
//
//  Created by Дмитрий Марченков on 07.04.2021.
//

import UIKit
import SafariServices

extension UIViewController {
    func showAlert(alertText: String,
                   alertMessage: String? = nil,
                   buttonTitle: String? = "ОK",
                   action: (() -> Void)? = nil) {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default) { _ in
            if let action = action { action() }
        })
        
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: - Present Safari
extension UIViewController {
    func presentSafari(with link: String) {
        guard let url = URL(string: link) else { return }
        let safariVC = SFSafariViewController(url: url)
        self.present(safariVC, animated: true, completion: nil)
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension UIViewController {
    var navBarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}

//MARK: - Helpful Childs Extension
extension UIViewController {
    func addChild (controller: UIViewController, rootView: UIView) {
        addChild(controller)
        rootView.addSubview(controller.view)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            controller.view.topAnchor.constraint(equalTo: rootView.topAnchor),
            controller.view.leadingAnchor.constraint(equalTo: rootView.leadingAnchor),
            controller.view.trailingAnchor.constraint(equalTo: rootView.trailingAnchor),
            controller.view.bottomAnchor.constraint(equalTo: rootView.bottomAnchor)
        ])
        controller.didMove(toParent: self)
    }
    
    func removeChild(childController: UIViewController) {
        childController.willMove(toParent: nil)
        childController.view.removeFromSuperview()
        childController.removeFromParent()
    }
    
    func addChildControllerToScrollView(child: UIViewController, scrollView: UIScrollView) {
        child.willMove(toParent: self)
        addChild(child)
        child.didMove(toParent: self)
        scrollView.addSubview(child.view)
    }
    
    func addChild(child: UIViewController, stackView: UIStackView) {
        child.willMove(toParent: self)
        addChild(child)
        child.didMove(toParent: self)
        stackView.addArrangedSubview(child.view)
    }
}

// MARK: - Keyboard Notifications

extension UIViewController {
        
    func registerKeyboardNotifications() {
        let center = NotificationCenter.default
        center.addObserver(
            self,
            selector: #selector(keyboardWillBeShown),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        center.addObserver(
            self,
            selector: #selector(keyboardWillBeHidden),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )

    }

    @objc
    func keyboardWillBeShown(notification: Notification) {}

    @objc
    func keyboardWillBeHidden(notification: Notification) {}

}
