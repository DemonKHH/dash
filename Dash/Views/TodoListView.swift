//
//  TodoListView.swift
//  Dash
//
//  Created by hetao11 on 2022/4/13.
//

import SwiftUI

struct TodoListView: View {
    @EnvironmentObject var todoModel: TodoModel
    var body: some View {
        ForEach(todoModel.todos, id: \.self) { todo in
            TodoItemView(todo: todo)
        }
    }
}


struct TodoListView_PreViews: PreviewProvider {
    static var previews: some View {
        TodoListView().environmentObject(TodoModel())
    }
}
