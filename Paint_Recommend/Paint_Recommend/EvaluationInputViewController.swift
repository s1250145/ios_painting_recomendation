//
//  EvaluationInputViewController.swift
//  Paint_Recommend
//
//  Created by 山口瑞歩 on 2020/10/08.
//  Copyright © 2020 山口瑞歩. All rights reserved.
//

import UIKit

class EvaluationInputViewController: UIViewController, UIGestureRecognizerDelegate {
    let popupView = UIView(frame: CGRect(x: 0, y: 0, width: 340, height: 490))

    let happy = CreateObject.feelInputButton(title: "Happy")
    let fear = CreateObject.feelInputButton(title: "Fear")
    let surprise = CreateObject.feelInputButton(title: "Surprise")
    let sad = CreateObject.feelInputButton(title: "Sad")
    let disgust = CreateObject.feelInputButton(title: "Disgust")
    let angry = CreateObject.feelInputButton(title: "Angry")

    let slider = CreateObject.slider(minEmoji: "🚫", maxEmoji: "💓")

    let likePercent = CreateObject.normalLabel("???", size: 18, frame: CGRect(x: 0, y: 0, width: 50, height: 18))

    // Fro send to API
    var feelingScore = 0
    var likeScore = 0.0

    // from DetailVC
    var paintName = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 0.6)

        // Gesture for tapped out of popup view
        let closeTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tappedGrayArea(_:)))
        self.view.addGestureRecognizer(closeTap)

        closeTap.cancelsTouchesInView = false
        closeTap.delegate = self

        // popup view
        popupView.center.x = view.bounds.width/2
        popupView.center.y = view.bounds.height/2
        popupView.backgroundColor = .white
        popupView.layer.cornerRadius = 20
        view.addSubview(popupView)

        let popup_w = popupView.bounds.width

        let title = CreateObject.normalLabel("How do you like feel?", size: 24, frame: CGRect(x: 0, y: 20, width: 0, height: 24))
        title.sizeToFit()
        title.center.x = popup_w/2
        popupView.addSubview(title)

        let feelAttention = CreateObject.normalLabel("please choose one.", size: 14, frame: CGRect(x: 0, y: title.bottom+20, width: 0, height: 14))
        feelAttention.sizeToFit()
        feelAttention.center.x = popup_w/2
        popupView.addSubview(feelAttention)

        let likeAttention = CreateObject.normalLabel("please select your like percentage", size: 14, frame: CGRect(x: 0, y: 300, width: 0, height: 14))
        likeAttention.sizeToFit()
        likeAttention.center.x = popup_w/2
        popupView.addSubview(likeAttention)

        likePercent.center.x = popup_w/2
        likePercent.center.y = likeAttention.bottom+15
        likePercent.textAlignment = .center
        popupView.addSubview(likePercent)

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

        slider.center.x = popup_w/2
        slider.center.y = likePercent.bottom+15
        popupView.addSubview(slider)

        popupView.isUserInteractionEnabled = true

        NSLayoutConstraint.activate([
            submitButton.heightAnchor.constraint(equalToConstant: 45),
            submitButton.widthAnchor.constraint(equalToConstant: 260),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

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

            submitButton.topAnchor.constraint(equalTo: popupView.bottomAnchor, constant: -100)
        ])
    }

    @objc func didTappedSubmitButton(_ sender: UIButton) {
        // 評価情報の記録
        if feelingScore == 0 || likePercent.text == "???" {
            showAlert("Please input all", 0.5)
        } else {
            var paintEvaluationData :[PaintEvaluationData] = PaintAction.get(key: "PaintEvaluationData")
            paintEvaluationData.append(PaintEvaluationData(imageName: paintName, feelingScore: feelingScore, likeScore: likeScore))
            PaintAction.save(paintEvaluationData, key: "PaintEvaluationData")
            dismiss(animated: true, completion: nil)
        }
    }

    func showAlert(_ msg: String, _ time: Double) {
        let alert = UIAlertController(title: msg, message: "", preferredStyle: .alert)
        self.present(alert, animated: true, completion: { () in
            DispatchQueue.main.asyncAfter(deadline: .now() + time, execute: {
                alert.dismiss(animated: true, completion: nil)
            })
        })
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

extension UISlider {
    override open func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        return true
    }

    override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        bounds.size.height += 10
        return bounds.contains(point)
    }
}
