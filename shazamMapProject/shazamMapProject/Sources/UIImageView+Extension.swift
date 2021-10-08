//
//  UIImageView+Extension.swift
//  StoneRecognizer
//
//  Created by Ivan on 01.06.2021.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}

extension UIImageView {
    
    /// Универсальный метод загрузки фоток, все происходит с анимацией через KingFisher, фотка сразу же кешируется после первого запроса
    /// - Parameter imageURL: URL на зазгрузку фотки
    /// - Parameter animateShowAfterCache: По дефолту отключаем анимацию после кеша
    /// - Returns: возвращаем метод с загрузкой. Актуально для ячеек, так как сетевой запрос может идти долго и в итоге ячейка после prepareForReuse будет показывать неправильную картинку
    @discardableResult func downloadImage(
        imageURL: URL,
        animateShowAfterCache: Bool = false
    ) -> DownloadTask? {
        
        var options: KingfisherOptionsInfo? = [
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(0.3)),
            .cacheOriginalImage,
        ]
        
        if animateShowAfterCache {
            options?.append(.forceTransition)
        }
        
        self.kf.indicatorType = .activity
                
        let task = self.kf.setImage(
            with: imageURL,
            options: options
        )
        
        return task
    }
    
}
