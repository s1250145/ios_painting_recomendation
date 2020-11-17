//
//  GarallyViewController.swift
//  Paint_Recommend
//
//  Created by 山口瑞歩 on 2020/11/17.
//  Copyright © 2020 山口瑞歩. All rights reserved.
//

// SkeltonView 確認用

import UIKit

class GarallyViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate {
    var paintDataSet = [PaintData]()
    let garally = CreateObject.collection()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.setHidesBackButton(true, animated: false)

        self.title = "Garally"
        self.navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.init(name: "AmericanTypewriter", size: 30) as Any]
        self.navigationController?.navigationBar.barTintColor = UIColor.q4.main

        let trashBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(trashButtonTapped(_:)))
        self.navigationItem.rightBarButtonItems = [trashBarButtonItem]
        navigationItem.rightBarButtonItem?.tintColor = .black

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black

        paintDataSet = PaintAction.get(key: "PaintDataSet")
        garally.delegate = self
        garally.dataSource = self
        view.addSubview(garally)

        NSLayoutConstraint.activate([
            garally.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            garally.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            garally.widthAnchor.constraint(equalToConstant: view.frame.width),
            garally.heightAnchor.constraint(equalToConstant: view.frame.height)
            ])
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    @objc func trashButtonTapped(_ sender: UIBarButtonItem) {
        // Reset evaluation data
        let alert = UIAlertController(title: "Data Reset", message: "Reset your all evaluation data", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) -> Void in
            // Reset process
            PaintAction.save([PaintEvaluationData](), key: "PaintEvaluationData")
        })
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true, completion:  nil)
    }

    func callBack() {
        // Update paint list
        DispatchQueue.main.sync {
            paintDataSet = PaintAction.get(key: "PaintDataSet")
            garally.reloadData()
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return paintDataSet.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Paint", for: indexPath as IndexPath)
        let paint = UIImageView(frame: .zero)
        paint.image = paintDataSet[indexPath.row].image.b64ToImage
        paint.translatesAutoresizingMaskIntoConstraints = false

        cell.contentView.addSubview(paint)

        NSLayoutConstraint.activate([
            paint.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
            paint.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 0),
            paint.heightAnchor.constraint(equalTo: cell.contentView.heightAnchor),
            paint.widthAnchor.constraint(equalTo: cell.contentView.widthAnchor)
            ])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width*0.475, height: 250 as CGFloat)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PaintDetailViewController()
        vc.name = paintDataSet[indexPath.row].title
        vc.date = paintDataSet[indexPath.row].date
        vc.artist = paintDataSet[indexPath.row].artist
        vc.born = paintDataSet[indexPath.row].born
        vc.age = paintDataSet[indexPath.row].age
        vc.paint.image = paintDataSet[indexPath.row].image.b64ToImage
        vc.imageName = paintDataSet[indexPath.row].imageName
        vc.childCallBack = { self.callBack() }
        self.show(vc, sender: nil)
    }
}
