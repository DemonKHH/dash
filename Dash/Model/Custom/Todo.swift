//
//  Todo.swift
//  Dash
//
//  Created by hetao11 on 2022/4/13.
//

import Foundation

struct TodoRsp: Decodable {
    var code: Int
    var data: [Todo]
}

struct Todo: Decodable, Hashable {
    var id: Int
    var name: String?
    var money: String?
    var timeStamp: String?
    var maxStopLoss: String?
    var notes: String?
    var operations: [TodoOperationRecord]?
}

struct TodoOperationRecord: Decodable, Hashable  {
    var instId: String?
    var timeStamp: String?
    var posSide: String?
    var avgPx: String?
    var count: String?
    var positions: String?
    var presentPrice: String?
    var profitLoss: String?
    var avgPxUpdate: String?
    var stopLossAmount: String?
}

class TodoModel: ObservableObject {
    @Published var todo: Todo = Todo(id: 1)
    @Published var todos: [Todo] = [Todo(id: 2)]
    @Published var todoRsp: TodoRsp = TodoRsp(
        code: 0,
        data: []
    )
    
    init() {
        print("model init")
        fetchTodos()
    }
    func fetchTodos() {
        let url = "https://img.umcoder.com/api/workers/get"
        let params = ["" : ""]
        bsRequest.requestWithUrl(url, param: params, get: true, token: "", success: reqSuccess, failure: reqFail)
    }
    
    func reqSuccess(data: Any) {
        do {
            let r = try JSONDecoder().decode(TodoRsp.self, from: data as! Data)
            DispatchQueue.main.async {
                self.todos = r.data
            }
        } catch {
            // 如果连接失败就...
            print("无法连接到服务器")
            return
        }
    }
    
    func reqFail(res: Any) {
        print("fail======== \(res)")
    }
}
