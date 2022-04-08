//
//  Positions.swift
//  Dash
//
//  Created by demon on 2022/3/30.
//

import SwiftUI

struct PositionRsp: Decodable {
    var code: Int
    var data: [Position]
}

struct Position: Decodable, Hashable {
    var adl: String
    var availPos:String
    var avgPx: String
    var cTime: String
    var ccy: String
    var instId:String
    var instType:String
    var interest:String
    var last:String
    var lever:String
    var liqPx:String
    var margin:String
    var markPx:String
    var mgnMode:String
    var mgnRatio:String
    var mmr:String
    var notionalUsd:String
    var pos:String
    var posId:String
    var posSide:String
    var tradeId:String
    var uTime:String
    var upl:String
    var uplRatio:String
}

class PositionModel: ObservableObject {
    @Published var positions: [Position] = []
    @Published var positionRsp: PositionRsp = PositionRsp(
        code: 0,
        data: []
    )
    
    init() {
        print("model init")
        fetchPositions()
    }
    func fetchPositions() {
            // https://img.umcoder.com/api/v5/account/positions
            let url = URL(string:
                            "https://img.umcoder.com/api/v5/account/positions")!
            // 创建一个会话，这个会话可以复用
            let session = URLSession(configuration: .default)
            let UrlRequest = URLRequest(url: url)
            // 创建一个网络任务
            let task = session.dataTask(with: UrlRequest) {(data, response, error) in
                do {
                    let r = try JSONDecoder().decode(PositionRsp.self, from: data!)
                    DispatchQueue.main.async {
                        self.positions = r.data
                    }
                } catch {
                    // 如果连接失败就...
                    print("无法连接到服务器")
                    return
                }
            }
            // 运行此任务
            task.resume()
    }
}
