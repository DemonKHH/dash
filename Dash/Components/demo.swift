//
//  demo.swift
//  Dash
//
//  Created by hetao11 on 2022/4/1.
//

import SwiftUI

struct demo: View {
    @State var isPresented = false
    var body: some View {
        Button(action: {
            self.isPresented = true
        }, label: {
            Text("Present Modally")
        })
        .sheet(isPresented: $isPresented) {
            GCPresentedView()
                .frame(height: 200)
        }
    }
}

struct GCPresentedView: View {
    @Environment(\.presentationMode) var mode
    
    var body: some View {
        Button(action: {
            self.mode.wrappedValue.dismiss()
        }, label: {
            Text("Dismiss")
        })
    }
}

struct demo_Previews: PreviewProvider {
    static var previews: some View {
        demo()
    }
}
