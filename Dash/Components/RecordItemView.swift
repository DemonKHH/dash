//
//  RecordItemView.swift
//  Dash
//
//  Created by hetao11 on 2022/4/14.
//

import SwiftUI

struct RecordItemView: View {
    @State var todoOperationRecord: TodoOperationRecord
    var body: some View {
        ScrollView{
            HStack(alignment: .top){
                VStack(alignment: .leading){
                    Text("id \(self.todoOperationRecord.instId)")
                        .font(.title2)
                        .fontWeight(.bold)
                }
                Spacer()
            }
            .frame(height: 80)
            .padding()
            .onTapGesture {
                print("跳转到详情页面")
            }
        }
    }
}


struct RecordItemView_PreViews: PreviewProvider {
    static var previews: some View {
        ForEach(TodoModel().todo.operations, id: \.self) { operation in
            RecordItemView(todoOperationRecord: operation)
        }
    }
}
