//
//  PaintCollectionViewController.swift
//  Paint_Recommend
//
//  Created by 山口瑞歩 on 2020/09/15.
//  Copyright © 2020 山口瑞歩. All rights reserved.
//

import UIKit

class PaintCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate {
    var paintDataSet = [PaintData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        self.title = "Garally"
        self.navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.init(name: "AmericanTypewriter", size: 30) as Any]
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 187/256, green: 188/256, blue: 222/256, alpha: 1.0)

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black

        paintDataSet = PaintAction.getPaintDataSet()

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 10, right: 5)

        let garally = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        garally.backgroundColor = .white
        garally.translatesAutoresizingMaskIntoConstraints = false
        garally.delegate = self
        garally.dataSource = self
        garally.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Paint")
        view.addSubview(garally)

        NSLayoutConstraint.activate([
            garally.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            garally.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            garally.widthAnchor.constraint(equalToConstant: view.frame.width),
            garally.heightAnchor.constraint(equalToConstant: view.frame.height)
            ])
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
        self.show(vc, sender: nil)
    }
}

extension String {
    private func base64ToImage(imageString: String) -> UIImage? {
        let decodeBase64: NSData? = NSData(base64Encoded: imageString, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
        if decodeBase64 != nil {
            let image = UIImage(data: decodeBase64! as Data)
            return image
        }
        return nil
    }
    var b64ToImage: UIImage? {
        return base64ToImage(imageString: self)
    }
}
