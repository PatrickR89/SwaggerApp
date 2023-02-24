//
//  UIImage+Extensions.swift
//  Swagger
//
//  Created by Patrick on 22.02.2023..
//

import UIKit

extension UIImage {
    /// Method to resize input image to new dimensions
    /// - Parameter newWidth: value of width to which image has to be resized
    /// - Returns: resized image
    func resizeImage(_ newWidth: CGFloat) -> UIImage {

        let scale = newWidth / size.width
        let newHeight = size.height * scale
        let renderRect = CGRect(
            origin: .zero,
            size: CGSize(width: newWidth, height: newHeight))

        return renderResizedImage(in: renderRect)
    }

    /// Helper method to ``resizeImage`` which renders image in new given CGRect
    /// - Parameter renderRect: rect defined by ``resizeImage`` method
    /// - Returns: new resized UIImage
    private func renderResizedImage(in renderRect: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: renderRect.size)
        let newImage = renderer.image { _ in
            self.draw(in: renderRect)
        }

        return newImage
    }
}
