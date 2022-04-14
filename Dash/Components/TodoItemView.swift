//
//  TodoItemView.swift
//  Dash
//
//  Created by hetao11 on 2022/4/13.
//


import SwiftUI

struct TodoItemView: View {
    @State var todo: Todo
    var body: some View {
            NavigationLink(
                destination: RecordListView(todo: self.todo), label: {
                    HStack{
                        VStack(alignment: .leading){
                            Text("name \(self.todo.name)")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        .padding()
                        Spacer()
                    }
                    .frame(height: 120)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(25)
                    .padding()
                }
            )
    }
}


struct TodoItemView_PreViews: PreviewProvider {
    static var previews: some View {
        TodoItemView(todo: TodoModel().todo)
    }
}
