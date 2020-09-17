//
//  PaintDetailViewController.swift
//  Paint_Recommend
//
//  Created by 山口瑞歩 on 2020/09/15.
//  Copyright © 2020 山口瑞歩. All rights reserved.
//

import UIKit

class PaintDetailViewController: UIViewController {

    var paint = UIImageView(frame: .zero)

    var name: String = "Unknown"
    var date: String = "2021"
    var artist: String = "mixufo"
    var born: String = "Japan"
    var active: String = "1998-2028"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        paint.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(paint)

        let artTitle = CreateObject.createLabel(title: name, size: 36)
        view.addSubview(artTitle)

        let artDate = CreateObject.createLabel(title: date, size: 24)
        view.addSubview(artDate)

        let artistName = CreateObject.createLabel(title: artist, size: 28)
        view.addSubview(artistName)

        let artistBorn = CreateObject.createLabel(title: born+", "+active, size: 20)
        view.addSubview(artistBorn)

        // input like value
        let likeLabel = CreateObject.createLabel(title: "you like this?", size: 24)
        view.addSubview(likeLabel)

        let love = CreateObject.inputButton(title: "Love")
        let good = CreateObject.inputButton(title: "Good")
        let bad = CreateObject.inputButton(title: "Bad")
        let dislike = CreateObject.inputButton(title: "Dislike")

        let likeButtons = GridLayoutView(frame: CGRect(x: 0, y: 0, width: 242, height: 60))
        likeButtons.addSubview(love)
        likeButtons.addSubview(good)
        likeButtons.addSubview(bad)
        likeButtons.addSubview(dislike)
        likeButtons.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(likeButtons)

        // input feeling value
        let feelLabel = CreateObject.createLabel(title: "your feel?", size: 24)
        view.addSubview(feelLabel)

        let happy = CreateObject.inputButton(title: "Happy")
        let sad = CreateObject.inputButton(title: "Sad")
        let anger = CreateObject.inputButton(title: "Anger")
        let move = CreateObject.inputButton(title: "Move")

        let feelButtons = GridLayoutView(frame: CGRect(x: 0, y: 0, width: 242, height: 60))
        feelButtons.addSubview(happy)
        feelButtons.addSubview(sad)
        feelButtons.addSubview(anger)
        feelButtons.addSubview(move)
        feelButtons.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(feelButtons)

        NSLayoutConstraint.activate([
            paint.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            paint.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            paint.heightAnchor.constraint(equalToConstant: 400),
            paint.widthAnchor.constraint(equalToConstant: view.frame.width*0.95),
            artTitle.topAnchor.constraint(equalTo: paint.bottomAnchor, constant: 40),
            artTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            artDate.topAnchor.constraint(equalTo: artTitle.bottomAnchor, constant: 0),
            artDate.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),

            artistName.topAnchor.constraint(equalTo: artDate.bottomAnchor, constant: 20),
            artistName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            artistBorn.topAnchor.constraint(equalTo: artistName.bottomAnchor, constant: 0),
            artistBorn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),

            likeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            likeLabel.topAnchor.constraint(equalTo: artistBorn.bottomAnchor, constant: 20),
            likeButtons.topAnchor.constraint(equalTo: likeLabel.bottomAnchor, constant: 5),
            likeButtons.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            likeButtons.widthAnchor.constraint(equalToConstant: 242),
            likeButtons.heightAnchor.constraint(equalToConstant: 60),

            feelLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            feelLabel.topAnchor.constraint(equalTo: likeButtons.bottomAnchor, constant: 5),
            feelButtons.topAnchor.constraint(equalTo: feelLabel.bottomAnchor, constant: 5),
            feelButtons.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            feelButtons.widthAnchor.constraint(equalToConstant: 242),
            feelButtons.heightAnchor.constraint(equalToConstant: 60)
            ])
    }
}
