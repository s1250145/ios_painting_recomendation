//
//  InputView.swift
//  Paint_Recommend
//
//  Created by 山口瑞歩 on 2020/11/25.
//  Copyright © 2020 山口瑞歩. All rights reserved.
//

import UIKit

class InputView: UIView {
    let happy = CreateObject.feelInputButton(title: "Happy")
    let fear = CreateObject.feelInputButton(title: "Fear")
    let surprise = CreateObject.feelInputButton(title: "Surprise")
    let sad = CreateObject.feelInputButton(title: "Sad")
    let disgust = CreateObject.feelInputButton(title: "Disgust")
    let angry = CreateObject.feelInputButton(title: "Angry")

    let slider = CreateObject.slider(minEmoji: "🚫", maxEmoji: "💓")

    let likePercent = CreateObject.normalLabel("???", size: 18, frame: CGRect(x: 0, y: 0, width: 50, height: 18))

    // Send to API
    var feelingScore = 0
    var likeScore = 0.0

    override func draw(_ rect: CGRect) {
        self.backgroundColor = .white
        self.frame = CGRect(x: 0, y: 0, width: 340, height: 430)

        let w = self.frame.size.width

        let title = CreateObject.normalLabel("How do you like feel?", size: 24, frame: CGRect(x: 0, y: 20, width: 0, height: 24))
        title.sizeToFit()
        title.center.x = w/2-20
        self.addSubview(title)

        let feelAttention = CreateObject.normalLabel("please choose one.", size: 14, frame: CGRect(x: 0, y: title.bottom+20, width: 0, height: 14))
        feelAttention.sizeToFit()
        feelAttention.center.x = w/2-20
        self.addSubview(feelAttention)

        let likeAttention = CreateObject.normalLabel("please select your like percentage", size: 14, frame: CGRect(x: 0, y: 300, width: 0, height: 14))
        likeAttention.sizeToFit()
        likeAttention.center.x = w/2-20
        self.addSubview(likeAttention)

        likePercent.center.x = w/2-20
        likePercent.center.y = likeAttention.bottom+15
        likePercent.textAlignment = .center
        self.addSubview(likePercent)

        happy.addTarget(self, action: #selector(didTappedFeelButton(_:)), for: .touchUpInside)
        fear.addTarget(self, action: #selector(didTappedFeelButton(_:)), for: .touchUpInside)
        surprise.addTarget(self, action: #selector(didTappedFeelButton(_:)), for: .touchUpInside)
        sad.addTarget(self, action: #selector(didTappedFeelButton(_:)), for: .touchUpInside)
        disgust.addTarget(self, action: #selector(didTappedFeelButton(_:)), for: .touchUpInside)
        angry.addTarget(self, action: #selector(didTappedFeelButton(_:)), for: .touchUpInside)
        slider.addTarget(self, action: #selector(sliderDidChangeValue(_:)), for: .valueChanged)

        self.addSubview(happy)
        happy.tag = 1
        self.addSubview(fear)
        fear.tag = 2
        self.addSubview(surprise)
        surprise.tag = 3
        self.addSubview(sad)
        sad.tag = 4
        self.addSubview(disgust)
        disgust.tag = 5
        self.addSubview(angry)
        angry.tag = 6

        slider.center.x = w/2-20
        slider.center.y = likePercent.bottom+15
        self.addSubview(slider)

        self.isUserInteractionEnabled = true

        NSLayoutConstraint.activate([
            happy.topAnchor.constraint(equalTo: feelAttention.bottomAnchor, constant: 20),
            fear.topAnchor.constraint(equalTo: feelAttention.bottomAnchor, constant: 20),
            surprise.topAnchor.constraint(equalTo: feelAttention.bottomAnchor, constant: 20),
            sad.topAnchor.constraint(equalTo: happy.bottomAnchor, constant: 40),
            disgust.topAnchor.constraint(equalTo: fear.bottomAnchor, constant: 40),
            angry.topAnchor.constraint(equalTo: surprise.bottomAnchor, constant: 40),

            fear.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            disgust.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            happy.rightAnchor.constraint(equalTo: fear.leftAnchor, constant: 10),
            sad.rightAnchor.constraint(equalTo: disgust.leftAnchor, constant: 10),
            surprise.leftAnchor.constraint(equalTo: fear.rightAnchor, constant: -10),
            angry.leftAnchor.constraint(equalTo: disgust.rightAnchor, constant: -10),
            ])
    }

    @objc func didTappedFeelButton(_ sender: UIButton) {
        setDisableColorAllFeelButton()
        sender.tintColor = .black
        sender.setTitleColor(.black, for: .normal)
        feelingScore = sender.tag
    }

    @objc func sliderDidChangeValue(_ sender: UISlider) {
        likePercent.text = String(floor(sender.value*100))
        likeScore = Double(sender.value)
    }

    func setDisableColorAllFeelButton() {
        happy.tintColor = UIColor.q4.disable
        happy.setTitleColor(UIColor.q4.disable, for: .normal)

        fear.tintColor = UIColor.q4.disable
        fear.setTitleColor(UIColor.q4.disable, for: .normal)

        surprise.tintColor = UIColor.q4.disable
        surprise.setTitleColor(UIColor.q4.disable, for: .normal)

        sad.tintColor = UIColor.q4.disable
        sad.setTitleColor(UIColor.q4.disable, for: .normal)

        disgust.tintColor = UIColor.q4.disable
        disgust.setTitleColor(UIColor.q4.disable, for: .normal)

        angry.tintColor = UIColor.q4.disable
        angry.setTitleColor(UIColor.q4.disable, for: .normal)
    }
}
