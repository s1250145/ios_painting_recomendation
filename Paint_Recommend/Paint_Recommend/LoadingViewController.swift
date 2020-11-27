//
//  LoadingViewController.swift
//  Paint_Recommend
//
//  Created by 山口瑞歩 on 2020/11/10.
//  Copyright © 2020 山口瑞歩. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class LoadingViewController: UIViewController {
    let indicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width/2, height: UIScreen.main.bounds.size.height/2), type: .ballScaleRippleMultiple, color: UIColor.q4.main, padding: 5.0)

    let greetingLabel = Generate.normalLabel("Now Downloading...", size: 15, frame: CGRect(x: 0, y: 0, width: 0, height: 15))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        greetingLabel.sizeToFit()
        greetingLabel.center.x = view.bounds.width/2
        greetingLabel.center.y = view.bounds.height/2
        view.addSubview(greetingLabel)

        indicator.center.x = view.bounds.width/2
        indicator.center.y = view.bounds.height/2
        view.addSubview(indicator)

        indicator.startAnimating()
        APIClient().request(PaintDataAPIRequest()) { result in
            switch(result) {
            case let .success(model):
                PaintAction.save(model, key: "PaintDataSet")
                PaintAction.save([PaintEvaluationData](), key: "PaintEvaluationData")
                DispatchQueue.main.sync {
                    self.indicator.stopAnimating()
                    self.navigationController?.pushViewController(PaintCollectionViewController(), animated: true)
                }
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

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
