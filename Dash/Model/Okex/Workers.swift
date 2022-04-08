//
//  Workerss.swift
//  Dash
//
//  Created by demon on 2022/3/30.
//

import SwiftUI

struct WorkersRsp: Decodable {
    var code: Int
    var data: [Worker]!
}

struct WorkerRsp: Decodable {
    var code: Int
    var data: Worker!
}



struct Worker: Decodable, Hashable {
    var id: Int?
    var stopLoss: String
    var status: String?
    var instId: String
}


var workersMock = [
    Worker(id: 1, stopLoss: "0.01", status: "waiting", instId: "BTC-USDT-SWAP")
]

class WorkersModel: ObservableObject {
    @Published var workers: [Worker] = []
    @Published var workersRsp: WorkersRsp = WorkersRsp(
        code: 0,
        data: []
    )

    init() {
        print("model init")
        fetchWorkers()
    }
    func fetchWorkers() {
        let url = "https://img.umcoder.com/api/workers/get"
        let params = ["" : ""]
        bsRequest.requestWithUrl(url, param: params, get: true, token: "", success: addTaskSuccess, failure: addTaskFail)
    }
    
    func addTaskSuccess(data: Any) {
        do {
            let r = try JSONDecoder().decode(WorkersRsp.self, from: data as! Data)
            DispatchQueue.main.async {
                self.workers = r.data
            }
        } catch {
            // 如果连接失败就...
            print("无法连接到服务器")
            return
        }
    }
    
    func addTaskFail(res: Any) {
        print("fail======== \(res)")
    }
}

