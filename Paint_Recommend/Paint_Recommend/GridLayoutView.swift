//
//  GridLayoutView.swift
//  Paint_Recommend
//
//  Created by 山口瑞歩 on 2020/09/16.
//  Copyright © 2020 山口瑞歩. All rights reserved.
//

import UIKit

class GridLayoutView: UIView {
    var gridSize: Int = 4
    var borderWidth: CGFloat = 20
    var insets: UIEdgeInsets = .zero

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = .white

        let margin = borderWidth

        let w = (bounds.width - CGFloat(gridSize - 1) * margin - insets.left - insets.right) / CGFloat(gridSize)
        let h = (bounds.height - CGFloat(gridSize - 1) * margin - insets.top - insets.bottom) / CGFloat(gridSize)

        let startX = insets.left
        let startY = insets.top

        var x = startX
        var y = startY

        subviews.enumerated().forEach { index, view in
            view.frame.origin = CGPoint(x: x, y: y)
            view.frame.size = CGSize(width: w, height: h)

            x += w + margin
            if index % gridSize == gridSize - 1 {
                x = startX
                y += h + margin
            }
        }
    }
}
