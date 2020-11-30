//
//  PaintDetailViewController.swift
//  Paint_Recommend
//
//  Created by 山口瑞歩 on 2020/09/15.
//  Copyright © 2020 山口瑞歩. All rights reserved.
//

import UIKit
import MarqueeLabel
import DJSemiModalViewController

class PaintDetailViewController: UIViewController, UINavigationControllerDelegate {
    var paint = UIImageView(frame: CGRect(x: UIScreen.main.bounds.size.width*0.05, y: 100, width: UIScreen.main.bounds.size.width*0.9, height: 400))

    // from CollectionVC
    var name: String = ""
    var date: String = ""
    var artist: String = ""
    var born: String = ""
    var age: String = ""
    var imageName: String = ""

    // check submit
    var isSubmit = false

    var childCallBack: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self

        view.backgroundColor = .white

        paint.contentMode = .scaleAspectFit
        view.addSubview(paint)

        let w = paint.bounds.size.width

        let artTitle = Generate.autoscrollLabel(name, size: 36, frame: CGRect(x: 20, y: paint.bottom+10, width: w, height: 36))
        view.addSubview(artTitle)

        let artDate = Generate.normalLabel(date, size: 24, frame: CGRect(x: 20, y: artTitle.bottom+5, width: w, height: 24))
        view.addSubview(artDate)

        let artistName = Generate.autoscrollLabel(artist, size: 28, frame: CGRect(x: 20, y: artDate.bottom+5, width: w, height: 28))
        view.addSubview(artistName)

        let bornIn = Generate.normalLabel(born+", "+age, size: 18, frame: CGRect(x: 20, y: artistName.bottom+5, width: w, height: 18))
        view.addSubview(bornIn)

        let inputButton = Generate.roundButton(title: "Input evaluation")
        inputButton.addTarget(self, action: #selector(didTappedInputButton(_:)), for: .touchUpInside)
        view.addSubview(inputButton)

        NSLayoutConstraint.activate([
            inputButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inputButton.topAnchor.constraint(equalTo: bornIn.bottomAnchor, constant: 50),
            inputButton.heightAnchor.constraint(equalToConstant: 45),
            inputButton.widthAnchor.constraint(equalToConstant: 260)
            ])
    }

    let customView = CustomViewController(nibName: "CustomViewController", bundle: nil)
    @objc func didTappedInputButton(_ sender: UIButton) {
        // 評価ポップアップの表示
        let controller = DJSemiModalViewController()
        controller.minHeight = 430
        controller.maxWidth = 340

        controller.closeButton.setTitle("SUBMIT", for: .normal)
        controller.closeButton.backgroundColor = UIColor.q4.main
        controller.closeButton.addTarget(self, action: #selector(didTappedSubmitButton(_:)), for: .touchUpInside)
        // 表示されるがbutton, sliderが反応しない
        controller.addArrangedSubview(view: customView.view, height: 430)

        controller.presentOn(presentingViewController: self, animated: true, onDismiss: nil)
    }

    @objc func didTappedSubmitButton(_ sender: UIButton) {
        // 評価情報の記録
        if customView.feel == 0 || customView.percent.text == "???" {
            showAlert("Failed.", "Please input all items.", 0.4)
        } else {
            var paintEvaluationData :[PaintEvaluationData] = PaintAction.get(key: "PaintEvaluationData")
            paintEvaluationData.append(PaintEvaluationData(imageName: imageName, feelingScore: customView.feel, likeScore: customView.like))
            PaintAction.save(paintEvaluationData, key: "PaintEvaluationData")
            isSubmit = true
            showAlert("Success!", "", 0.4)
        }
    }

    func showAlert(_ title: String, _ msg: String, _ time: Double) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        self.present(alert, animated: true, completion: { () in
            DispatchQueue.main.asyncAfter(deadline: .now() + time, execute: {
                alert.dismiss(animated: true, completion: nil)
            })
        })
    }

    // Handling from detailView to collectionView
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        // 評価の送信とレコメンデーション結果からリスト更新
        if isSubmit && viewController is PaintCollectionViewController {
            var paintEvaluationData: [PaintEvaluationData] = PaintAction.get(key: "PaintEvaluationData")

            if paintEvaluationData.count > 4 {
                if paintEvaluationData.count > 14 {
                    // Cleaning old evaluation data
                    paintEvaluationData.removeSubrange(0...4)
                    PaintAction.save(paintEvaluationData, key: "PaintEvaluationData")
                }
                // POSTリクエスト送信
                var request = PaintEvaluationDataAPIRequest()
                request.evaluations = PaintAction.makeRequestDataSet(paintEvaluationData)
                APIClient().request(request) { result in
                    switch(result) {
                    case let .success(model):
                        PaintAction.save(model!, key: "PaintDataSet")
                        self.childCallBack?()

                    case let .failure(error):
                        switch error {
                        case let .server(status):
                            print("Error status code: \(status)")
                        case .noResponse:
                            print("Error no response")
                        case let .unknown(e):
                            print("Error unknown \(e)")
                        default:
                            print("Error \(error)")
                        }
                    }
                }
            }
        }
    }
}
