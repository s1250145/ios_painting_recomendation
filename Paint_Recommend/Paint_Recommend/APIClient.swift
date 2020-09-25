//
//  APIClient.swift
//  Paint_Recommend
//
//  Created by 山口瑞歩 on 2020/09/24.
//  Copyright © 2020 山口瑞歩. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol Requestable {
    associatedtype Model
    var url: String { get }
    var httpMethod: String { get }
    var headers: [String: String] { get }

    func decode(from data: Data) throws -> Model
}

extension Requestable {
    var urlRequest: URLRequest? {
        guard let url = URL(string: url) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        headers.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
        return request
    }
}

class APIClient {
    func request<T: Requestable>(_ requestable: T, closure: @escaping(T.Model?) -> ()) {
        guard let request = requestable.urlRequest else { return }
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            let model = try? requestable.decode(from: data)
            closure(model)
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

struct PaintDataAPIRequest: Requestable {
    typealias Model = [PaintData]

    func decode(from data: Data) throws -> [PaintData] {
        var paintDataSet = [PaintData]()
        JSON(data).forEach { (_, l) in
            let paint = PaintData(id: l["id"].intValue, title: l["title"].stringValue, date: l["date"].stringValue, artist: l["artist"].stringValue, born: l["born"].stringValue, age: l["age"].stringValue, imageName: l["imageName"].stringValue, image: l["image"].stringValue)
            paintDataSet.append(paint)
        }
        return paintDataSet
    }

    var url: String {
        return "http://127.0.0.1:5000/"
    }

    var httpMethod: String {
        return "GET"
    }

    var headers: [String : String] {
        return [:]
    }
}
