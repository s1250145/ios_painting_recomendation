//
//  PaintAction.swift
//  Paint_Recommend
//
//  Created by 山口瑞歩 on 2020/09/25.
//  Copyright © 2020 山口瑞歩. All rights reserved.
//

import Foundation
import SwiftyJSON

class PaintAction {
    static func get<T: Decodable>(key: String) -> [T] {
        JSONDecoder().keyDecodingStrategy = .convertFromSnakeCase
        guard let data = UserDefaults.standard.data(forKey: key), let dataSet = try? JSONDecoder().decode([T].self, from: data) else {
            return [T]()
        }
        return dataSet
    }

    static func save<T: Encodable>(_ saveData: T, key: String) {
        JSONEncoder().keyEncodingStrategy = .convertToSnakeCase
        guard let data = try? JSONEncoder().encode(saveData) else { return }
        UserDefaults.standard.set(data, forKey: key)
    }
    
    static func makeRequestDataSet(_ data: [PaintEvaluationData]) -> Dictionary<String, Any> {
        var feel: [[String: Any]] = []
        var like: [[String: Any]] = []
        for eva in data {
            let f = ["img": eva.imageName, "rate": [eva.feelingScore]] as [String : Any]
            let l = ["img": eva.imageName, "rate": [eva.likeScore]] as [String : Any]
            feel.append(f)
            like.append(l)
        }
        let dataSet: Dictionary<String, Any> = ["Feel": feel, "Like": like]
        return dataSet
    }
}
