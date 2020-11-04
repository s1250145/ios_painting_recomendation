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

    static func savePaintDataSet(_ saveData: PaintEvaluationDataAPIRequest.Model) {
        JSONEncoder().keyEncodingStrategy = .convertToSnakeCase
        guard let data = try? JSONEncoder().encode(saveData) else { return }
        UserDefaults.standard.set(data, forKey: "PaintDataSet")
    }

    static func getEvaluationData() -> [PaintEvaluationData] {
        JSONDecoder().keyDecodingStrategy = .convertFromSnakeCase
        guard let data = UserDefaults.standard.data(forKey: "PaintEvaluationData"), let paintEvaluationData = try? JSONDecoder().decode([PaintEvaluationData].self, from: data) else {
            return [PaintEvaluationData]()
        }
        return paintEvaluationData
    }

    static func saveEvaluationData(_ submitData: [PaintEvaluationData]) {
        JSONEncoder().keyEncodingStrategy = .convertToSnakeCase
        guard let data = try? JSONEncoder().encode(submitData) else { return }
        UserDefaults.standard.set(data, forKey: "PaintEvaluationData")
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
