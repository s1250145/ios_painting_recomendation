//
//  CustomViewController.swift
//  Paint_Recommend
//
//  Created by 山口瑞歩 on 2020/11/27.
//  Copyright © 2020 山口瑞歩. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController {
    @IBOutlet weak var happy: UIButton!
    @IBOutlet weak var fear: UIButton!
    @IBOutlet weak var surprise: UIButton!
    @IBOutlet weak var sad: UIButton!
    @IBOutlet weak var disgust: UIButton!
    @IBOutlet weak var angry: UIButton!

    @IBOutlet weak var percent: UILabel!
    @IBOutlet weak var slider: UISlider!

    var feel: Int = 0
    var like: Double = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonLayout()
        setSliderLayout()
    }

    private func setButtonLayout() {
        happy.centerVertically()
        fear.centerVertically()
        surprise.centerVertically()
        sad.centerVertically()
        disgust.centerVertically()
        angry.centerVertically()
    }

    private func setSliderLayout() {
        slider.minimumValue = 0.0
        slider.maximumValue = 1.0
        slider.value = 0.5
        slider.minimumValueImage = "❌".emojiToImage
        slider.maximumValueImage = "💘".emojiToImage
    }

    @IBAction func didChangeValue(_ sender: UISlider) {
        percent.text = String(floor(sender.value*100))
        like = Double(sender.value)
    }


    @IBAction func didTappedFeelButton(_ sender: UIButton) {
        setDisableColorAllFeelButton()
        sender.tintColor = .black
        sender.setTitleColor(.black, for: .normal)
        feel = sender.tag
    }

    private func setDisableColorAllFeelButton() {
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
