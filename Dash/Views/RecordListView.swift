//
//  RecordListView.swift
//  Dash
//
//  Created by hetao11 on 2022/4/14.
//

import SwiftUI

struct RecordListView: View {
    @State var todo: Todo
    var body: some View {
    
        ScrollView{
            VStack(alignment: .leading){
                ForEach(self.todo.operations, id: \.self) { record in
                    RecordItemView(todoOperationRecord: record)
                }
            }
        }
        .navigationTitle(self.todo.name)
    }
}


struct RecordListView_PreViews: PreviewProvider {
    static var previews: some View {
        RecordListView(todo: TodoModel().todo)
    }
}
