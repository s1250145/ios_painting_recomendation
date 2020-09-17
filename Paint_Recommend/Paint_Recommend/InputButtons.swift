//
//  InputButtons.swift
//  Paint_Recommend
//
//  Created by 山口瑞歩 on 2020/09/16.
//  Copyright © 2020 山口瑞歩. All rights reserved.
//

import UIKit

class InputButtons: UIView {
    override func draw(_ rect: CGRect) {
        self.layer.backgroundColor = UIColor.white.cgColor

        let love = CreateObject.inputButton(title: "Love")
        let good = CreateObject.inputButton(title: "Good")
        let bad = CreateObject.inputButton(title: "Bad")
        let dislike = CreateObject.inputButton(title: "Dislike")

        let likeButtons = GridLayoutView(frame: CGRect(x: 0, y: 0, width: 242, height: 70))
        likeButtons.backgroundColor = .white
        likeButtons.gridSize = 4
        likeButtons.addSubview(love)
        likeButtons.addSubview(good)
        likeButtons.addSubview(bad)
        likeButtons.addSubview(dislike)
        likeButtons.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(likeButtons)

        NSLayoutConstraint.activate([
            likeButtons.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            likeButtons.widthAnchor.constraint(equalToConstant: 300),
            likeButtons.heightAnchor.constraint(equalToConstant: 70),
            love.heightAnchor.constraint(equalToConstant: 70)
            ])
    }
}
