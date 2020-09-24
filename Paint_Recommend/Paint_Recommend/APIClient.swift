//
//  APIClient.swift
//  Paint_Recommend
//
//  Created by 山口瑞歩 on 2020/09/24.
//  Copyright © 2020 山口瑞歩. All rights reserved.
//

import Foundation
import SwiftyJSON

class APIClient {
    func request() {
        var paintDataSet = [PaintData]()
        guard let url = URL(string: "http://127.0.0.1:5000/") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            let json = JSON(data)
            json.forEach { (_, arr) in
                let paint = PaintData(id: arr["id"].intValue, title: arr["title"].stringValue, date: arr["date"].stringValue, artist: arr["artist"].stringValue, born: arr["born"].stringValue, age: arr["age"].stringValue, imageName: arr["imageName"].stringValue, image: arr["image"].stringValue)
                paintDataSet.append(paint)
            }
        }
        task.resume()
    }
}

struct PaintData: Codable {
    var id = 0
    var title = ""
    var date = ""
    var artist = ""
    var born = ""
    var age = ""
    var imageName = ""
    var image = ""
}