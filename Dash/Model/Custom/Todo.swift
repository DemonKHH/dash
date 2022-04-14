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
    var id: Int = 0
    var name: String = ""
    var money: String = ""
    var timeStamp: String = ""
    var maxStopLoss: String = ""
    var notes: String = ""
    var operations: [TodoOperationRecord] = []
}

struct TodoOperationRecord: Decodable, Hashable  {
    var instId: String = ""
    var timeStamp: String = ""
    var posSide: String = ""
    var avgPx: String = ""
    var count: String = ""
    var positions: String = ""
    var presentPrice: String = ""
    var profitLoss: String = ""
    var avgPxUpdate: String = ""
    var stopLossAmount: String = ""
}

class TodoModel: ObservableObject {
    @Published var todo: Todo = Todo(
        id: 10011,
        name: "todo1",
        money: "123",
        timeStamp: "14321312321",
        maxStopLoss: "0.2",
        notes: "test test",
        operations: [
            TodoOperationRecord(
                instId: "todo-instId", timeStamp: "123213141", posSide: "long", avgPx: "1", count: "10", positions: "222", presentPrice: "1.1", profitLoss: "20", avgPxUpdate: "1.05", stopLossAmount: "100"
            ),
            TodoOperationRecord(
                instId: "todo-instId12", timeStamp: "123213141", posSide: "long", avgPx: "1", count: "10", positions: "222", presentPrice: "1.1", profitLoss: "20", avgPxUpdate: "1.05", stopLossAmount: "100"
            )
        ]
    )
    @Published var todos: [Todo] = [
        Todo(
            id: 10011,
            name: "todo1",
            money: "123",
            timeStamp: "14321312321",
            maxStopLoss: "0.2",
            notes: "test test",
            operations: [
                TodoOperationRecord(
                    instId: "todo-instId", timeStamp: "123213141", posSide: "long", avgPx: "1", count: "10", positions: "222", presentPrice: "1.1", profitLoss: "20", avgPxUpdate: "1.05", stopLossAmount: "100"
                )
            ]
        ),
        Todo(
            id: 10022,
            name: "todo2",
            money: "123",
            timeStamp: "14321312321",
            maxStopLoss: "0.2",
            notes: "test test",
            operations: [
                TodoOperationRecord(
                    instId: "todo-instId", timeStamp: "123213141", posSide: "long", avgPx: "1", count: "10", positions: "222", presentPrice: "1.1", profitLoss: "20", avgPxUpdate: "1.05", stopLossAmount: "100"
                ),
                TodoOperationRecord(
                    instId: "todo-instId12", timeStamp: "123213141", posSide: "long", avgPx: "1", count: "10", positions: "222", presentPrice: "1.1", profitLoss: "20", avgPxUpdate: "1.05", stopLossAmount: "100"
                )
            ]
        )
    ]
    @Published var todoRsp: TodoRsp = TodoRsp(
        code: 0,
        data: []
    )
    
//    init() {
//        print("model init")
//        fetchTodos()
//    }
//    func fetchTodos() {
//        let url = "https://img.umcoder.com/api/workers/get"
//        let params = ["" : ""]
//        bsRequest.requestWithUrl(url, param: params, get: true, token: "", success: reqSuccess, failure: reqFail)
//    }
//
//    func reqSuccess(data: Any) {
//        do {
//            let r = try JSONDecoder().decode(TodoRsp.self, from: data as! Data)
//            DispatchQueue.main.async {
//                self.todos = r.data
//            }
//        } catch {
//            // 如果连接失败就...
//            print("无法连接到服务器")
//            return
//        }
//    }
    
    func reqFail(res: Any) {
        print("fail======== \(res)")
    }
}
