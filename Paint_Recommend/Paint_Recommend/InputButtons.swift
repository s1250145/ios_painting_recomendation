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

        let loveBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 48, height: 0))
        loveBtn.setTitle("Love", for: .normal)
        loveBtn.setTitleColor(.black, for: .normal)
        loveBtn.setImage(UIImage(named: "Love"), for: .normal)
        loveBtn.centerVertically()
        loveBtn.translatesAutoresizingMaskIntoConstraints = false

        let goodBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 48, height: 0))
        goodBtn.setTitle("Good", for: .normal)
        goodBtn.setTitleColor(.black, for: .normal)
        goodBtn.setImage(UIImage(named: "Good"), for: .normal)
        goodBtn.centerVertically()
        goodBtn.translatesAutoresizingMaskIntoConstraints = false

        let badBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 48, height: 0))
        badBtn.setTitle("Bad", for: .normal)
        badBtn.setTitleColor(.black, for: .normal)
        badBtn.setImage(UIImage(named: "Bad"), for: .normal)
        badBtn.centerVertically()
        badBtn.translatesAutoresizingMaskIntoConstraints = false

        let dislikeBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 48, height: 0))
        dislikeBtn.setTitle("Dislike", for: .normal)
        dislikeBtn.setTitleColor(.black, for: .normal)
        dislikeBtn.setImage(UIImage(named: "Dislike"), for: .normal)
        dislikeBtn.centerVertically()
        dislikeBtn.translatesAutoresizingMaskIntoConstraints = false

        let likeButtons = GridLayoutView()
        likeButtons.backgroundColor = .white
        likeButtons.gridSize = 4
        likeButtons.addSubview(loveBtn)
        likeButtons.addSubview(goodBtn)
        likeButtons.addSubview(badBtn)
        likeButtons.addSubview(dislikeBtn)
        likeButtons.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(likeButtons)

        NSLayoutConstraint.activate([
            likeButtons.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            likeButtons.widthAnchor.constraint(equalToConstant: 300),
            likeButtons.heightAnchor.constraint(equalToConstant: 70)
            ])
    }
}

extension UIButton {
    func centerVertically() {
        guard let imageSize = self.imageView?.image?.size else { return }
        self.titleEdgeInsets.left = -imageSize.width * 1.75
        self.titleEdgeInsets.bottom = -imageSize.width
    }
}
