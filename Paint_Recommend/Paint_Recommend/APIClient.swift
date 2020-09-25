//
//  APIClient.swift
//  Paint_Recommend
//
//  Created by 山口瑞歩 on 2020/09/24.
//  Copyright © 2020 山口瑞歩. All rights reserved.
//

import Foundation
import SwiftyJSON

enum APIError: Error {
    case server(Int)
    case decode(Error)
    case noResponse
    case unknown(Error)
}

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
    func request<T: Requestable>(_ requestable: T, closure: @escaping(Result<T.Model?, APIError>) -> ()) {
        guard let request = requestable.urlRequest else { return }
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                closure(.failure(APIError.unknown(error)))
                return
            }

            guard let data = data, let response = response as? HTTPURLResponse else {
                closure(.failure(APIError.noResponse))
                return
            }

            if case 200..<300 = response.statusCode {
                do {
                    let model = try requestable.decode(from: data)
                    closure(.success(model))
                } catch let decodeError {
                    closure(.failure(APIError.decode(decodeError)))
                }
            } else {
                closure(.failure(APIError.server(response.statusCode)))
            }
        }
        task.resume()
    }
}

// 1枚の絵画の情報を保持する構造体
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

// 絵画のデータセットを取得するAPIリクエスト
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
