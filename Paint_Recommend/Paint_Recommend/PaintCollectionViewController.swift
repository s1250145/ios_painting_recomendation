//
//  PaintCollectionViewController.swift
//  Paint_Recommend
//
//  Created by 山口瑞歩 on 2020/09/15.
//  Copyright © 2020 山口瑞歩. All rights reserved.
//

import UIKit

class PaintCollectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        self.title = "Garally"
        self.navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.init(name: "CourierNewPSMT", size: 30) as Any]
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 187/256, green: 188/256, blue: 222/256, alpha: 1.0)

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black
    }
}
