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
}
