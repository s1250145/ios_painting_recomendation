//
//  PaintAction.swift
//  Paint_Recommend
//
//  Created by 山口瑞歩 on 2020/09/25.
//  Copyright © 2020 山口瑞歩. All rights reserved.
//

import Foundation

class PaintAction {
    static func getPaintDataSet() -> [PaintData] {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = UserDefaults.standard.data(forKey: "PaintDataSet"), let paintDataSet = try? jsonDecoder.decode([PaintData].self, from: data) else {
            return [PaintData]()
        }
        return paintDataSet
    }
}
