//
//  PaintDetailViewController.swift
//  Paint_Recommend
//
//  Created by 山口瑞歩 on 2020/09/15.
//  Copyright © 2020 山口瑞歩. All rights reserved.
//

import UIKit
import MarqueeLabel

class PaintDetailViewController: UIViewController, UINavigationControllerDelegate {
    var paint = UIImageView(frame: CGRect(x: UIScreen.main.bounds.size.width*0.05, y: 100, width: UIScreen.main.bounds.size.width*0.9, height: 400))

    var name: String = ""
    var date: String = ""
    var artist: String = ""
    var born: String = ""
    var age: String = ""
    var imageName: String = ""

    var childCallBack: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self

        view.backgroundColor = .white

        paint.contentMode = .scaleAspectFit
        view.addSubview(paint)

        let w = paint.bounds.size.width

        let artTitle = MarqueeLabel.init(frame: CGRect(x: 20.0, y: paint.bottom+130, width: w, height: 36), duration: 8.0, fadeLength: 10.0)
        artTitle.text = name
        artTitle.font = UIFont(name: "Palatino-Roman", size: 36)!
        view.addSubview(artTitle)

        let artDate = UILabel(frame: CGRect(x: 20, y: artTitle.bottom+5, width: w, height: 24))
        artDate.text = date
        artDate.font = UIFont(name: "Palatino-Roman", size: 24)!
        view.addSubview(artDate)

        let artistName = MarqueeLabel.init(frame: CGRect(x: 20.0, y: artDate.bottom+5, width: w, height: 28), duration: 8.0, fadeLength: 10.0)
        artistName.text = artist
        artistName.font = UIFont(name: "Palatino-Roman", size: 28)!
        view.addSubview(artistName)

        let artistBorn = CreateObject.label(title: born+", "+age, size: 18)
        view.addSubview(artistBorn)

        let inputButton = CreateObject.roundButton(title: "Input evaluation")
        inputButton.addTarget(self, action: #selector(didTappedInputButton(_:)), for: .touchUpInside)
        view.addSubview(inputButton)

        NSLayoutConstraint.activate([
            artistBorn.topAnchor.constraint(equalTo: artistName.bottomAnchor, constant: 0),
            artistBorn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            inputButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inputButton.topAnchor.constraint(equalTo: artistBorn.bottomAnchor, constant: 50),
            inputButton.heightAnchor.constraint(equalToConstant: 45),
            inputButton.widthAnchor.constraint(equalToConstant: 260)
            ])
    }

    @objc func didTappedInputButton(_ sender: UIButton) {
        let vc = EvaluationInputViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.paintName = imageName
        self.present(vc, animated: true, completion: nil)
    }

    // Handling from detailView to collectionView
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        // 評価の送信とレコメンデーション結果からリスト更新
        if viewController is PaintCollectionViewController {
            let paintEvaluationData: [PaintEvaluationData] = PaintAction.get(key: "PaintEvaluationData")

            if paintEvaluationData.count > 4 {
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
