//
//  Valuations.swift
//  Dash
//
//  Created by demon on 2022/3/30.
//

import SwiftUI

struct ValuationRsp: Decodable {
    var code: Int
    var data: [Valuation]
}

struct Valuation: Decodable, Hashable {
    var details: ValuationDetail
    var totalBal: String
    var ts: String
    var timeStamp: String
}

struct ValuationDetail: Decodable, Hashable {
    var classic: String
    var earn: String
    var funding: String
    var trading: String
}


var valuationsMock = Valuation(
    details: ValuationDetail(
        classic: "0",
        earn: "0",
        funding: "2.46",
        trading: "1438.79"
    ),
    totalBal: "1441.25",
    ts: "1643219843939",
    timeStamp: "2022-01-26T17:57:24.019Z"
)

class ValuationModel: ObservableObject {
    @Published var valuations: [Valuation] = []
    @Published var positionRsp: ValuationRsp = ValuationRsp(
        code: 0,
        data: []
    )

    init() {
        print("model init")
        fetchValuations()
    }
    func fetchValuations() {
            // https://img.umcoder.com/api/v5/asset/asset-valuation
            let url = URL(string:
                            "http://127.0.0.1:4523/mock/605385/api/v5/asset/asset-valuation")!
            // 创建一个会话，这个会话可以复用
            let session = URLSession(configuration: .default)
            let UrlRequest = URLRequest(url: url)
            // 创建一个网络任务
            let task = session.dataTask(with: UrlRequest) {(data, response, error) in
                do {
                    // 返回的是一个json，将返回的json转成字典r
//                    let r = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                    print("解析内容")
                    let r = try JSONDecoder().decode(ValuationRsp.self, from: data!)
                    print(r.data)
                    self.valuations = r.data
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
