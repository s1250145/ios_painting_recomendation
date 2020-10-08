//
//  EvaluationInputViewController.swift
//  Paint_Recommend
//
//  Created by 山口瑞歩 on 2020/10/08.
//  Copyright © 2020 山口瑞歩. All rights reserved.
//

import UIKit

class EvaluationInputViewController: UIViewController {
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
        let submitAttention = CreateObject.createLabel(title: "you can try it more", size: 11)
        popupView.addSubview(submitAttention)

        let submitButton = CreateObject.roundButton(title: "Submit")
        submitButton.addTarget(self, action: #selector(didTappedSubmitButton(_:)), for: .touchUpInside)
        popupView.addSubview(submitButton)

        let happy = CreateObject.inputButton(title: "Happy")
        popupView.addSubview(happy)
        let fear = CreateObject.inputButton(title: "Fear")
        popupView.addSubview(fear)
        let surprise = CreateObject.inputButton(title: "Surprise")
        popupView.addSubview(surprise)
        let sad = CreateObject.inputButton(title: "Sad")
        popupView.addSubview(sad)
        let disgust = CreateObject.inputButton(title: "Disgust")
        popupView.addSubview(disgust)
        let angry = CreateObject.inputButton(title: "Angry")
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
            happy.topAnchor.constraint(equalTo: feelAttention.bottomAnchor, constant: 10),
            fear.topAnchor.constraint(equalTo: feelAttention.bottomAnchor, constant: 10),
            surprise.topAnchor.constraint(equalTo: feelAttention.bottomAnchor, constant: 10),
            sad.topAnchor.constraint(equalTo: happy.bottomAnchor, constant: 10),
            disgust.topAnchor.constraint(equalTo: fear.bottomAnchor, constant: 10),
            angry.topAnchor.constraint(equalTo: surprise.bottomAnchor, constant: 10),

            happy.leftAnchor.constraint(equalTo: popupView.leftAnchor, constant: 30),
            fear.leftAnchor.constraint(equalTo: happy.rightAnchor, constant: 30),
            surprise.leftAnchor.constraint(equalTo: fear.rightAnchor, constant: 30),

            sad.leftAnchor.constraint(equalTo: popupView.leftAnchor, constant: 30),
            disgust.leftAnchor.constraint(equalTo: sad.rightAnchor, constant: 30),
            angry.leftAnchor.constraint(equalTo: disgust.rightAnchor, constant: 30),

            likeAttention.topAnchor.constraint(equalTo: disgust.bottomAnchor, constant: 20),
            likePercent.topAnchor.constraint(equalTo: likeAttention.bottomAnchor, constant: 10),

            submitButton.topAnchor.constraint(equalTo: likePercent.bottomAnchor, constant: 10),
            submitAttention.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 10)
        ])
    }

    @objc func didTappedSubmitButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
