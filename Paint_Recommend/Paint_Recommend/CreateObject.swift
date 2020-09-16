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
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 48, height: 0))
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: title), for: .normal)
        button.centerVertically()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}

extension UIButton {
    func centerVertically() {
        guard let imageSize = self.imageView?.image?.size else { return }
        self.titleEdgeInsets.left = -imageSize.width * 1.75
        self.titleEdgeInsets.bottom = -imageSize.width
    }
}
