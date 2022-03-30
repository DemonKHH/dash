//
//  DashApp.swift
//  Dash
//
//  Created by zw on 2022/3/7.
//

import SwiftUI

@main
struct DashApp: App {
    @StateObject var model = Model()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
    }
}
