//
//  TodoItemView.swift
//  Dash
//
//  Created by hetao11 on 2022/4/13.
//


import SwiftUI

struct TodoItemView: View {
    var todo: Todo
    var body: some View {
        Text("text \(todo.id)")
    }
}


struct TodoItemView_PreViews: PreviewProvider {
    static var previews: some View {
        TodoItemView(todo: TodoModel().todo)
    }
}
