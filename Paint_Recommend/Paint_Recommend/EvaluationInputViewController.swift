//
//  EvaluationInputViewController.swift
//  Paint_Recommend
//
//  Created by 山口瑞歩 on 2020/10/08.
//  Copyright © 2020 山口瑞歩. All rights reserved.
//

import UIKit

class EvaluationInputViewController: UIViewController {
    let disable = UIColor(red: 187/256, green: 188/256, blue: 222/256, alpha: 1.0)

    let happy = CreateObject.inputButton(title: "Happy")
    let fear = CreateObject.inputButton(title: "Fear")
    let surprise = CreateObject.inputButton(title: "Surprise")
    let sad = CreateObject.inputButton(title: "Sad")
    let disgust = CreateObject.inputButton(title: "Disgust")
    let angry = CreateObject.inputButton(title: "Angry")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 0.6)

        // popup view
        let popupView = UIView(frame: CGRect(x: 0, y: 0, width: 340, height: 490))
        popupView.backgroundColor = .white
        popupView.layer.cornerRadius = 20
        popupView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(popupView)

        let heading = CreateObject.createLabel(title: "How do you like feel?", size: 24)
        popupView.addSubview(heading)
        let feelAttention = CreateObject.createLabel(title: "please choose one.", size: 14)
        popupView.addSubview(feelAttention)
        let likeAttention = CreateObject.createLabel(title: "please select your like percentage", size: 14)
        popupView.addSubview(likeAttention)
        let likePercent = CreateObject.createLabel(title: "", size: 18)
        popupView.addSubview(likePercent)
        let submitAttention = CreateObject.createLabel(title: "you can try it more", size: 14)
        popupView.addSubview(submitAttention)

        let submitButton = CreateObject.roundButton(title: "Submit")
        submitButton.addTarget(self, action: #selector(didTappedSubmitButton(_:)), for: .touchUpInside)
        popupView.addSubview(submitButton)

        happy.addTarget(self, action: #selector(didTappedFeelButton(_:)), for: .touchUpInside)
        fear.addTarget(self, action: #selector(didTappedFeelButton(_:)), for: .touchUpInside)
        surprise.addTarget(self, action: #selector(didTappedFeelButton(_:)), for: .touchUpInside)
        sad.addTarget(self, action: #selector(didTappedFeelButton(_:)), for: .touchUpInside)
        disgust.addTarget(self, action: #selector(didTappedFeelButton(_:)), for: .touchUpInside)
        angry.addTarget(self, action: #selector(didTappedFeelButton(_:)), for: .touchUpInside)

        popupView.addSubview(happy)
        popupView.addSubview(fear)
        popupView.addSubview(surprise)
        popupView.addSubview(sad)
        popupView.addSubview(disgust)
        popupView.addSubview(angry)

        NSLayoutConstraint.activate([
            popupView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popupView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            popupView.widthAnchor.constraint(equalToConstant: 340),
            popupView.heightAnchor.constraint(equalToConstant: 490),

            submitButton.heightAnchor.constraint(equalToConstant: 45),
            submitButton.widthAnchor.constraint(equalToConstant: 260),

            heading.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            feelAttention.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            likeAttention.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            likePercent.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitAttention.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            heading.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 20),
            feelAttention.topAnchor.constraint(equalTo: heading.bottomAnchor, constant: 20),
            happy.topAnchor.constraint(equalTo: feelAttention.bottomAnchor, constant: 20),
            fear.topAnchor.constraint(equalTo: feelAttention.bottomAnchor, constant: 20),
            surprise.topAnchor.constraint(equalTo: feelAttention.bottomAnchor, constant: 20),
            sad.topAnchor.constraint(equalTo: happy.bottomAnchor, constant: 60),
            disgust.topAnchor.constraint(equalTo: fear.bottomAnchor, constant: 60),
            angry.topAnchor.constraint(equalTo: surprise.bottomAnchor, constant: 60),

            happy.leftAnchor.constraint(equalTo: popupView.leftAnchor, constant: 50),
            fear.leftAnchor.constraint(equalTo: happy.rightAnchor, constant: 60),
            surprise.leftAnchor.constraint(equalTo: fear.rightAnchor, constant: 60),

            sad.leftAnchor.constraint(equalTo: popupView.leftAnchor, constant: 50),
            disgust.leftAnchor.constraint(equalTo: sad.rightAnchor, constant: 60),
            angry.leftAnchor.constraint(equalTo: disgust.rightAnchor, constant: 60),

            likeAttention.topAnchor.constraint(equalTo: disgust.bottomAnchor, constant: 70),
            likePercent.topAnchor.constraint(equalTo: likeAttention.bottomAnchor, constant: 10),

            submitButton.topAnchor.constraint(equalTo: likePercent.bottomAnchor, constant: 120),
            submitAttention.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 10)
        ])
    }

    @objc func didTappedSubmitButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func didTappedFeelButton(_ sender: UIButton) {
        setDisableColorAllFeelButton()
        sender.tintColor = .black
        sender.setTitleColor(.black, for: .normal)
    }

    func setDisableColorAllFeelButton() {
        happy.tintColor = disable
        happy.setTitleColor(disable, for: .normal)

        fear.tintColor = disable
        fear.setTitleColor(disable, for: .normal)

        surprise.tintColor = disable
        surprise.setTitleColor(disable, for: .normal)

        sad.tintColor = disable
        sad.setTitleColor(disable, for: .normal)

        disgust.tintColor = disable
        disgust.setTitleColor(disable, for: .normal)

        angry.tintColor = disable
        angry.setTitleColor(disable, for: .normal)
    }
}
