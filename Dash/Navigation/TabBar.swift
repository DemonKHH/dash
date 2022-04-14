//
//  TabBar.swift
//  Dash
//
//  Created by demon on 2022/3/8.
//

import SwiftUI

struct TabBar: View {
    @State private var selectedTab = 2
    
    var body: some View {
        TabView(selection: $selectedTab) {
            PageOneUIView()
                .onTapGesture {
                    self.selectedTab = 1
                }
                .tabItem {
                    Image(systemName: "star")
                    Text("message")
                }
                .tag(0)

            PageTwoUIView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("task")
                }
                .tag(1)
            
            PageThreeUIView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("todo")
                }
                .tag(2)
        }
    }
}

struct PageOneUIView:View{
    var body: some View{
        VStack(alignment: .leading, content: {
            HomeView()
        })
        .background(Color.orange.opacity(0.3))
    }
}

struct PageTwoUIView: View {
    @StateObject var workersModel = WorkersModel()
    
    var body: some View {
        VStack(alignment: .leading, content: {
            TaskListView().environmentObject(self.workersModel)
         })
    }
}

struct PageThreeUIView: View {
    var body: some View {
        NavigationView{
            VStack(alignment: .leading, content: {
                HStack(alignment: .lastTextBaseline){
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: 40, height: 40)
                            
                    }
                }
                .padding(.trailing)
                TodoListView().environmentObject(TodoModel())
             }).navigationTitle(Text("Todo"))
        }
    }
}



struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
