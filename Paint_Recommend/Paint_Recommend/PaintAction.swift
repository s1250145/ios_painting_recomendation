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

    static func makeRequestDataSet(_ data: [PaintEvaluationData]) -> Dictionary<String, [Evaluation]> {
        var feel = [Evaluation]()
        var like = [Evaluation]()
        for eva in data {
            let f = Evaluation(img: eva.imageName, rate: [eva.feelingScore])
            let l = Evaluation(img: eva.imageName, rate: [eva.likeScore])
            feel.append(f)
            like.append(l)
        }
        let dataSet: Dictionary<String, [Evaluation]> = ["Feel": feel, "Like": like]
        return dataSet
    }
}

struct Evaluation {
    var img = ""
    var rate = [Int]()
}
