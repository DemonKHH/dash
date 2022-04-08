//
//  Tasks.swift
//  Dash
//
//  Created by hetao11 on 2022/4/1.
//

import SwiftUI



struct TaskListView: View {
    @State var open: Bool = false
    @State var workerIndex: Int = 0
    @EnvironmentObject var workersModel: WorkersModel
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    self.open.toggle()
                }){
                    Text("Add Task")
                }
            }
            .sheet(isPresented: $open) {
                TasksView().environmentObject(self.workersModel)
            }
            .padding()
            List{
                Text("任务列表").font(.headline)
                ForEach(workersModel.workers, id: \.self) { worker in
//                    TaskView(worker: worker)
                    VStack(alignment: .leading){
                        Text("产品：\(worker.instId)")
                        Text("状态：\(worker.status ?? "unknow")")
                        Text("金额率：\(worker.stopLoss)")
                    }.padding()
                    
                }.onDelete(perform: deleteTask)
            }
        }
    }
    

    func deleteTask(offsets: IndexSet) {
        self.workerIndex = offsets.first!
        print("index \(self.workerIndex)")
        let worker:Worker = self.workersModel.workers[self.workerIndex]
        let url = "https://img.umcoder.com/api/workers/remove"
        let params = [
            "id": worker.id as Any,
            "status": worker.status as Any,
            "instId": worker.instId,
            "stopLoss": worker.stopLoss
        ] as [String : Any]
        bsRequest.requestWithUrl(url, param: params, get: false, token: "", success: deleteTaskSuccess, failure: deleteTaskFail)

    }

    func deleteTaskSuccess(data: Any) {
        do {
            let r = try JSONDecoder().decode(WorkersRsp.self, from: data as! Data)
            print("delete worker \(r)")
            if r.code == 0 {
                print("code is ok\(r.code)")
                DispatchQueue.main.async {
                    self.workersModel.workers.remove(at: self.workerIndex)
                }

            }
        } catch {
            // 如果连接失败就...
            print("无法连接到服务器 \(error.localizedDescription)")
            return
        }
    }

    func deleteTaskFail(res: Any) {
        print("fail======== \(res)")
    }
}

struct TaskView: View {
    @State var worker: Worker
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                Text("产品：\(worker.instId)")
                Text("状态：\(worker.status ?? "unknow")")
                Text("金额率：\(worker.stopLoss)")
            }
            .padding()
            Spacer()
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 3, x: 0, y: 5)
        .padding(.bottom)
    }
}

struct TaskList_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView().environmentObject(WorkersModel())
    }
}
