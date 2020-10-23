//
//  PaintDetailViewController.swift
//  Paint_Recommend
//
//  Created by 山口瑞歩 on 2020/09/15.
//  Copyright © 2020 山口瑞歩. All rights reserved.
//

import UIKit

class PaintDetailViewController: UIViewController, UINavigationControllerDelegate {
    let disable = UIColor(red: 187/256, green: 188/256, blue: 222/256, alpha: 1.0)

    var paint = UIImageView(frame: .zero)

    var name: String = ""
    var date: String = ""
    var artist: String = ""
    var born: String = ""
    var age: String = ""
    var imageName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self

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

    // Handling from detailView to CollectionView
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        // 評価の送信とレコメンデーション結果からリスト更新
        if viewController is PaintCollectionViewController {
            // 評価データを取得
            JSONDecoder().keyDecodingStrategy = .convertFromSnakeCase
            guard let data = UserDefaults.standard.data(forKey: "PaintEvaluationData"), let paintEvaluationData = try? JSONDecoder().decode([PaintEvaluationData].self, from: data) else { return }

            if paintEvaluationData.count > 4 {
                // POSTリクエスト送信
                var request = PaintEvaluationDataAPIRequest()
                request.evaluations = PaintAction.makeRequestDataSet(paintEvaluationData)
                print(request.evaluations)
                APIClient().request(request) { result in
                    switch(result) {
                    case let .success(model):
                        // レコメンデーション結果からリストを上書き
                        JSONEncoder().keyEncodingStrategy = .convertToSnakeCase
                        guard let list = try? JSONEncoder().encode(model) else { return }
                        UserDefaults.standard.set(list, forKey: "PaintDataSet")

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
