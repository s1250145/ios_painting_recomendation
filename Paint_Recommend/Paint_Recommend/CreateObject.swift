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
        button.setImage(UIImage(named: title)?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = UIColor(red: 187/256, green: 188/256, blue: 222/256, alpha: 1.0)
        button.centerVertically()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}

extension UIButton {
    func centerVertically() {
        guard let imageSize = self.imageView?.image?.size else { return }
        self.imageEdgeInsets.bottom = -imageSize.width * 0.75
        self.titleEdgeInsets.left = -imageSize.width * 1.25
        self.titleEdgeInsets.bottom = -imageSize.width * 1.75
    }
}
