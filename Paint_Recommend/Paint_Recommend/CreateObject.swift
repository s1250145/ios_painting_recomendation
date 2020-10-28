//
//  CreateObject.swift
//  Paint_Recommend
//
//  Created by 山口瑞歩 on 2020/09/15.
//  Copyright © 2020 山口瑞歩. All rights reserved.
//

import Foundation
import UIKit

class CreateObject {
    static func createLabel(title: String, size: CGFloat) -> UILabel {
        let label = UILabel(frame: .zero)
        label.text = title
        label.font = UIFont(name: "Palatino-Roman", size: size)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    static func inputButton(title: String) -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor(red: 187/256, green: 188/256, blue: 222/256, alpha: 1.0), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setImage(UIImage(named: title)?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = UIColor(red: 187/256, green: 188/256, blue: 222/256, alpha: 1.0) // disable button color
        button.imageView?.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.centerVertically()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }

    static func roundButton(title: String) -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 260, height: 45))
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "AmericanTypewriter", size: 15)
        button.backgroundColor = UIColor(red: 187/256, green: 188/256, blue: 222/256, alpha: 1.0)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }

    static func slider(minEmoji: String, maxEmoji: String) -> UISlider {
        let slider = UISlider(frame: CGRect(x: 0, y: 0, width: 0, height: 20))
        slider.minimumValueImage = minEmoji.emojiToImage
        slider.maximumValueImage = maxEmoji.emojiToImage
        slider.minimumValue = 0.0
        slider.maximumValue = 100.0
        slider.value = 50.0
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }
}

extension UIButton {
    func centerVertically() {
        guard let imageSize = self.imageView?.image?.size else { return }
        self.titleEdgeInsets.left = -imageSize.width
        self.titleEdgeInsets.bottom = -imageSize.width * 1.5
        self.contentEdgeInsets = UIEdgeInsets(top: -15, left: -15, bottom: -15, right: -15)
    }
}

extension String {
    private func emojiToImage(text: String, size: CGFloat) -> UIImage {

        let outputImageSize = CGSize.init(width: size, height: size)
        let baseSize = text.boundingRect(with: CGSize(width: 2048, height: 2048),
                                         options: .usesLineFragmentOrigin,
                                         attributes: [.font: UIFont.systemFont(ofSize: size / 2)], context: nil).size
        let fontSize = outputImageSize.width / max(baseSize.width, baseSize.height) * (outputImageSize.width / 2)
        let font = UIFont.systemFont(ofSize: fontSize)
        let textSize = text.boundingRect(with: CGSize(width: outputImageSize.width, height: outputImageSize.height),
                                         options: .usesLineFragmentOrigin,
                                         attributes: [.font: font], context: nil).size

        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.center
        style.lineBreakMode = NSLineBreakMode.byClipping

        let attr : [NSAttributedString.Key : Any] = [NSAttributedString.Key.font : font,
                                                     NSAttributedString.Key.paragraphStyle: style,
                                                     NSAttributedString.Key.backgroundColor: UIColor.clear ]

        UIGraphicsBeginImageContextWithOptions(outputImageSize, false, 0)
        text.draw(in: CGRect(x: (size - textSize.width) / 2,
                             y: (size - textSize.height) / 2,
                             width: textSize.width,
                             height: textSize.height),
                  withAttributes: attr)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }

    var emojiToImage: UIImage? {
        return emojiToImage(text: self, size: 20)
    }
}
