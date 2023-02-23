//
//  UIImage+Extensions.swift
//  Swagger
//
//  Created by Patrick on 22.02.2023..
//

import UIKit

extension UIImage {
    func resizeImage(_ newWidth: CGFloat) -> UIImage {

        let scale = newWidth / size.width
        let newHeight = size.height * scale

        let renderRect = CGRect(
            origin: .zero,
            size: CGSize(width: newWidth, height: newHeight))
        return renderResizedImage(in: renderRect)
    }

    private func renderResizedImage(in renderRect: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: renderRect.size)

        let newImage = renderer.image { _ in
            self.draw(in: renderRect)
        }

        return newImage
    }
}
