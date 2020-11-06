//
//  EvaluationInputViewController.swift
//  Paint_Recommend
//
//  Created by 山口瑞歩 on 2020/10/08.
//  Copyright © 2020 山口瑞歩. All rights reserved.
//

import UIKit

class EvaluationInputViewController: UIViewController, UIGestureRecognizerDelegate {
    let disable = UIColor(red: 187/256, green: 188/256, blue: 222/256, alpha: 1.0)

    var paintName = ""

    let happy = CreateObject.inputButton(title: "Happy")
    let fear = CreateObject.inputButton(title: "Fear")
    let surprise = CreateObject.inputButton(title: "Surprise")
    let sad = CreateObject.inputButton(title: "Sad")
    let disgust = CreateObject.inputButton(title: "Disgust")
    let angry = CreateObject.inputButton(title: "Angry")

    var feelingScore = 0

    let likePercent = CreateObject.label(title: "", size: 18)
    let slider = CreateObject.slider(minEmoji: "🚫", maxEmoji: "💓")

    var likeScore = 0.0

    let popupView = UIView(frame: CGRect(x: 0, y: 0, width: 340, height: 490))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 0.6)

        // Gesture for tapped out of popup view
        let closeTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tappedGrayArea(_:)))
        self.view.addGestureRecognizer(closeTap)

        closeTap.cancelsTouchesInView = false
        closeTap.delegate = self

        // popup view
        popupView.backgroundColor = .white
        popupView.layer.cornerRadius = 20
        popupView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(popupView)

        let heading = CreateObject.label(title: "How do you like feel?", size: 24)
        popupView.addSubview(heading)
        let feelAttention = CreateObject.label(title: "please choose one.", size: 14)
        popupView.addSubview(feelAttention)
        let likeAttention = CreateObject.label(title: "please select your like percentage", size: 14)
        popupView.addSubview(likeAttention)
        popupView.addSubview(likePercent)
        let submitAttention = CreateObject.label(title: "you can try it more", size: 14)
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

        slider.addTarget(self, action: #selector(sliderDidChangeValue(_:)), for: .valueChanged)

        popupView.addSubview(happy)
        happy.tag = 1
        popupView.addSubview(fear)
        fear.tag = 2
        popupView.addSubview(surprise)
        surprise.tag = 3
        popupView.addSubview(sad)
        sad.tag = 4
        popupView.addSubview(disgust)
        disgust.tag = 5
        popupView.addSubview(angry)
        angry.tag = 6

        popupView.addSubview(slider)

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
            slider.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            heading.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 20),
            feelAttention.topAnchor.constraint(equalTo: heading.bottomAnchor, constant: 20),
            happy.topAnchor.constraint(equalTo: feelAttention.bottomAnchor, constant: 20),
            fear.topAnchor.constraint(equalTo: feelAttention.bottomAnchor, constant: 20),
            surprise.topAnchor.constraint(equalTo: feelAttention.bottomAnchor, constant: 20),
            sad.topAnchor.constraint(equalTo: happy.bottomAnchor, constant: 40),
            disgust.topAnchor.constraint(equalTo: fear.bottomAnchor, constant: 40),
            angry.topAnchor.constraint(equalTo: surprise.bottomAnchor, constant: 40),

            fear.centerXAnchor.constraint(equalTo: popupView.centerXAnchor),
            disgust.centerXAnchor.constraint(equalTo: popupView.centerXAnchor),

            happy.rightAnchor.constraint(equalTo: fear.leftAnchor, constant: 10),
            sad.rightAnchor.constraint(equalTo: disgust.leftAnchor, constant: 10),

            surprise.leftAnchor.constraint(equalTo: fear.rightAnchor, constant: -10),
            angry.leftAnchor.constraint(equalTo: disgust.rightAnchor, constant: -10),

            likeAttention.topAnchor.constraint(equalTo: disgust.bottomAnchor, constant: 30),
            likePercent.topAnchor.constraint(equalTo: likeAttention.bottomAnchor, constant: 10),
            slider.topAnchor.constraint(equalTo: likePercent.bottomAnchor, constant: 10),
            slider.widthAnchor.constraint(equalToConstant: 260),

            submitButton.topAnchor.constraint(equalTo: likePercent.bottomAnchor, constant: 50),
            submitAttention.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 10)
        ])
    }

    @objc func didTappedSubmitButton(_ sender: UIButton) {
        // 評価情報の記録
        if feelingScore == 0 || likePercent.text == "" {
            let alert = UIAlertController(title: "Please input all.", message: "", preferredStyle: .alert)
            self.present(alert, animated: true, completion: { () in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    alert.dismiss(animated: true, completion: nil)
                })
            })
        } else {
            var paintEvaluationData :[PaintEvaluationData] = PaintAction.get(key: "PaintEvaluationData")
            paintEvaluationData.append(PaintEvaluationData(imageName: paintName, feelingScore: feelingScore, likeScore: likeScore))
            PaintAction.save(paintEvaluationData, key: "PaintEvaluationData")
            dismiss(animated: true, completion: nil)
        }
    }

    // popupにタップしたときは反応させない
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if((touch.view?.isDescendant(of: popupView))!) {
            return false
        }
        return true
    }

    @objc func tappedGrayArea(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }

    @objc func sliderDidChangeValue(_ sender: UISlider) {
        likePercent.text = String(floor(sender.value*100))
        likeScore = Double(sender.value)
    }

    @objc func didTappedFeelButton(_ sender: UIButton) {
        setDisableColorAllFeelButton()
        sender.tintColor = .black
        sender.setTitleColor(.black, for: .normal)
        feelingScore = sender.tag
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

extension UISlider {
    override open func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        return true
    }

    override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        bounds.size.height += 10
        return bounds.contains(point)
    }
}
