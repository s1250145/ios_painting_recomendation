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
    static func getPaintDataSet() -> [PaintData] {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = UserDefaults.standard.data(forKey: "PaintDataSet"), let paintDataSet = try? jsonDecoder.decode([PaintData].self, from: data) else {
            return [PaintData]()
        }
        return paintDataSet
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
