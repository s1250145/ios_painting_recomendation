//
//  PaintDetailViewController.swift
//  Paint_Recommend
//
//  Created by 山口瑞歩 on 2020/09/15.
//  Copyright © 2020 山口瑞歩. All rights reserved.
//

import UIKit

class PaintDetailViewController: UIViewController, UINavigationControllerDelegate {
    var paint = UIImageView(frame: .zero)

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
        paint.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(paint)

        let artTitle = CreateObject.label(title: name, size: 36)
        let titleLen = artTitle.intrinsicContentSize.width
        view.addSubview(artTitle)

        // Long title label animation
        if titleLen > view.bounds.width {
            UIView.animate(withDuration: 8.5, delay: 0.0, options: .repeat, animations: {
                artTitle.frame.origin.x += titleLen
            }, completion: nil)
        }

        let artDate = CreateObject.label(title: date, size: 24)
        view.addSubview(artDate)

        let artistName = CreateObject.label(title: artist, size: 28)
        let nameLen = artistName.intrinsicContentSize.width
        view.addSubview(artistName)

        // Long artist name animation
        if nameLen > view.bounds.width {
            UIView.animate(withDuration: 8.5, delay: 0.0, options: .repeat, animations: {
                artistName.frame.origin.x += nameLen
            }, completion: nil)
        }

        let artistBorn = CreateObject.label(title: born+", "+age, size: 18)
        view.addSubview(artistBorn)

        let inputButton = CreateObject.roundButton(title: "Input evaluation")
        inputButton.addTarget(self, action: #selector(didTappedInputButton(_:)), for: .touchUpInside)
        view.addSubview(inputButton)

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
