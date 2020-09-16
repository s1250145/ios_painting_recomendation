//
//  FeelingInputButtons.swift
//  Paint_Recommend
//
//  Created by 山口瑞歩 on 2020/09/16.
//  Copyright © 2020 山口瑞歩. All rights reserved.
//

import UIKit

class FeelingInputButtons: UIView {
    override func draw(_ rect: CGRect) {
        self.layer.backgroundColor = UIColor.white.cgColor

        let happy = CreateObject.inputButton(title: "Happy")
        let sad = CreateObject.inputButton(title: "Sad")
        let anger = CreateObject.inputButton(title: "Anger")
        let move = CreateObject.inputButton(title: "Impression")

        let gridView = GridLayoutView()
        gridView.backgroundColor = .white
        gridView.gridSize = 4
        gridView.addSubview(happy)
        gridView.addSubview(sad)
        gridView.addSubview(anger)
        gridView.addSubview(move)
        gridView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(gridView)

        NSLayoutConstraint.activate([
            gridView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            gridView.widthAnchor.constraint(equalToConstant: 300),
            gridView.heightAnchor.constraint(equalToConstant: 70)
            ])
    }
}
