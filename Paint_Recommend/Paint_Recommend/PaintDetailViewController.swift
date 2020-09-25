//
//  PaintDetailViewController.swift
//  Paint_Recommend
//
//  Created by 山口瑞歩 on 2020/09/15.
//  Copyright © 2020 山口瑞歩. All rights reserved.
//

import UIKit

class PaintDetailViewController: UIViewController {
    let disable = UIColor(red: 187/256, green: 188/256, blue: 222/256, alpha: 1.0)

    var paint = UIImageView(frame: .zero)

    var name: String = "Unknown"
    var date: String = "2021"
    var artist: String = "mixufo"
    var born: String = "Japan"
    var age: String = "1998-2028"

    let love = CreateObject.inputButton(title: "Love")
    let good = CreateObject.inputButton(title: "Good")
    let bad = CreateObject.inputButton(title: "Bad")
    let dislike = CreateObject.inputButton(title: "Dislike")
    let happy = CreateObject.inputButton(title: "Happy")
    let sad = CreateObject.inputButton(title: "Sad")
    let anger = CreateObject.inputButton(title: "Anger")
    let move = CreateObject.inputButton(title: "Move")

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

        let artistBorn = CreateObject.createLabel(title: born+", "+age, size: 18)
        view.addSubview(artistBorn)

        // input like value
        let likeLabel = CreateObject.createLabel(title: "you like this?", size: 22)
        view.addSubview(likeLabel)
        view.addSubview(love)
        view.addSubview(good)
        view.addSubview(bad)
        view.addSubview(dislike)
        love.addTarget(self, action: #selector(didTappedLikeButton(_:)), for: .touchUpInside)
        good.addTarget(self, action: #selector(didTappedLikeButton(_:)), for: .touchUpInside)
        bad.addTarget(self, action: #selector(didTappedLikeButton(_:)), for: .touchUpInside)
        dislike.addTarget(self, action: #selector(didTappedLikeButton(_:)), for: .touchUpInside)

        // input feeling value
        let feelLabel = CreateObject.createLabel(title: "your feel?", size: 22)
        view.addSubview(feelLabel)
        view.addSubview(happy)
        view.addSubview(sad)
        view.addSubview(anger)
        view.addSubview(move)
        happy.addTarget(self, action: #selector(didTappedFeelButton(_:)), for: .touchUpInside)
        sad.addTarget(self, action: #selector(didTappedFeelButton(_:)), for: .touchUpInside)
        anger.addTarget(self, action: #selector(didTappedFeelButton(_:)), for: .touchUpInside)
        move.addTarget(self, action: #selector(didTappedFeelButton(_:)), for: .touchUpInside)

        NSLayoutConstraint.activate([
            paint.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            paint.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            paint.heightAnchor.constraint(equalToConstant: 400),
            paint.widthAnchor.constraint(equalToConstant: view.frame.width*0.95),
            artTitle.topAnchor.constraint(equalTo: paint.bottomAnchor, constant: 20),
            artTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            artDate.topAnchor.constraint(equalTo: artTitle.bottomAnchor, constant: 0),
            artDate.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),

            artistName.topAnchor.constraint(equalTo: artDate.bottomAnchor, constant: 20),
            artistName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            artistBorn.topAnchor.constraint(equalTo: artistName.bottomAnchor, constant: 0),
            artistBorn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),

            likeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            likeLabel.topAnchor.constraint(equalTo: artistBorn.bottomAnchor, constant: 20),
            love.topAnchor.constraint(equalTo: likeLabel.bottomAnchor, constant: 15),
            love.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            good.topAnchor.constraint(equalTo: likeLabel.bottomAnchor, constant: 15),
            good.leftAnchor.constraint(equalTo: love.rightAnchor, constant: 20),
            bad.topAnchor.constraint(equalTo: likeLabel.bottomAnchor, constant: 15),
            bad.leftAnchor.constraint(equalTo: good.rightAnchor, constant: 20),
            dislike.topAnchor.constraint(equalTo: likeLabel.bottomAnchor, constant: 15),
            dislike.leftAnchor.constraint(equalTo: bad.rightAnchor, constant: 20),

            feelLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            feelLabel.topAnchor.constraint(equalTo: love.bottomAnchor, constant: 40),
            happy.topAnchor.constraint(equalTo: feelLabel.bottomAnchor, constant: 15),
            happy.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            sad.topAnchor.constraint(equalTo: feelLabel.bottomAnchor, constant: 15),
            sad.leftAnchor.constraint(equalTo: happy.rightAnchor, constant: 20),
            anger.topAnchor.constraint(equalTo: feelLabel.bottomAnchor, constant: 15),
            anger.leftAnchor.constraint(equalTo: sad.rightAnchor, constant: 20),
            move.topAnchor.constraint(equalTo: feelLabel.bottomAnchor, constant: 15),
            move.leftAnchor.constraint(equalTo: anger.rightAnchor, constant: 20),
            ])
    }

    @objc func didTappedLikeButton(_ sender: UIButton) {
        setDisableColorAllLikeButton()
        sender.tintColor = .black
        sender.setTitleColor(.black, for: .normal)
    }

    @objc func didTappedFeelButton(_ sender: UIButton) {
        setDisableColorAllFeelButton()
        sender.tintColor = .black
        sender.setTitleColor(.black, for: .normal)
    }

    func setDisableColorAllLikeButton() {
        love.tintColor = disable
        love.setTitleColor(disable, for: .normal)

        good.tintColor = disable
        good.setTitleColor(disable, for: .normal)

        bad.tintColor = disable
        bad.setTitleColor(disable, for: .normal)

        dislike.tintColor = disable
        dislike.setTitleColor(disable, for: .normal)
    }

    func setDisableColorAllFeelButton() {
        happy.tintColor = disable
        happy.setTitleColor(disable, for: .normal)

        sad.tintColor = disable
        sad.setTitleColor(disable, for: .normal)

        anger.tintColor = disable
        anger.setTitleColor(disable, for: .normal)

        move.tintColor = disable
        move.setTitleColor(disable, for: .normal)
    }
}
