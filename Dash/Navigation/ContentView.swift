//
//  ContentView.swift
//  Dash
//
//  Created by zw on 2022/3/7.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: Model
//    @StateObject var workersModel = WorkersModel()

    var body: some View {
        ZStack(alignment: .bottom) {
            TabBar()
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            ContentView()
        }
        .environmentObject(Model())

    }
}
