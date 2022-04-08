//
//  Tasks.swift
//  Dash
//
//  Created by hetao11 on 2022/4/1.
//

import SwiftUI



struct TasksView: View {
    @State var instId = "BTC-USDT-SWAP"
    @State var stopLoss = "0.01"
    @State private var showAlert = false
    @EnvironmentObject var workersModel: WorkersModel
    @Environment(\.presentationMode) var persentationMode
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                Text("产品")
                TextField(
                            "BTC-USDT-SWAP",
                            text: $instId,
                            onCommit: {
                                print("用户输入:\(self.instId)")
                            })
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                Text("资金率")
                TextField(
                            "0.01",
                            text: $stopLoss,
                            onCommit: {
                                print("用户输入:\(self.stopLoss)")
                            })
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    print("提交内容: \(self.instId) \n \(self.stopLoss)")
                    let worker = Worker(
                        stopLoss: self.stopLoss,
                        instId: self.instId
                    )
                    addTask(worker: worker)
                }, label: {
                    Text("submit")
                })
                .foregroundColor(Color.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(5)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("tips"), message: Text("新增任务成功"))
                }
                
                Button(action: {
                    toggleMode()
                }) {
                    Text("关闭")
                }
            }
            .navigationTitle(Text("Add Task"))
            .padding()
        }
    }
    
    func addTask(worker: Worker) {
        let url = "https://img.umcoder.com/api/workers/add"
        let params = [
            "instId": self.instId,
            "stopLoss": self.stopLoss
        ]
        bsRequest.requestWithUrl(url, param: params, get: false, token: "", success: addTaskSuccess, failure: addTaskFail)
    }
    
    func addTaskSuccess(data: Any) {
        do {
            let r = try JSONDecoder().decode(WorkerRsp.self, from: data as! Data)
            print("add task 解析内容\(r)")
//            self.showAlert.toggle()
            DispatchQueue.main.async {
                self.workersModel.workers.append(Worker(
                    id: r.data.id,
                    stopLoss: r.data.stopLoss,
                    status: r.data.status,
                    instId: r.data.instId
                ))
            }
            toggleMode()
        } catch {
            // 如果连接失败就...
            print("无法连接到服务器 \(error)")
            return
        }
    }
    
    func addTaskFail(res: Any) {
        print("fail======== \(res)")
    }
    
    func toggleMode() {
        self.persentationMode.wrappedValue.dismiss()
    }
}

struct Tasks_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
    }
}
