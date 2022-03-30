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

    @MainActor
    func fetchPositions() async{
        do {
            let url = URL(string:
                            "https://img.umcoder.com/api/v5/account/positions")!
            let (data, _) = try await URLSession.shared.data(from: url)
            positionRsp = try JSONDecoder().decode(PositionRsp.self, from: data)
            positions = positionRsp.data
        }catch{
            print("error")
        }
    }
}
