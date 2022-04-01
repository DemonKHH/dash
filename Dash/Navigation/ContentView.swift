//
//  ContentView.swift
//  Dash
//
//  Created by zw on 2022/3/7.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: Model

    var body: some View {
        ZStack(alignment: .bottom) {
            HomeView()
//            switch selectedTab {
//            case .home:
//                HomeView()
//            case .explore:
////                AccountView()
//                HomeView()
//             case .notification:
////                AccountView()
//                HomeView()
//            case .library:
////                AccountView()
//                HomeView()
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
