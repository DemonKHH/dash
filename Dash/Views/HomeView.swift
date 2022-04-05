//
//  HomeView.swift
//  Dash
//
//  Created by zw on 2022/3/9.
//

import SwiftUI

struct HomeView: View {
    @State var hasScrolled = false
    @Namespace var namespace
    @State var show = false
    @State var showStatusBar = true
    @State var selectdID = ""
    @State var showCourse = false
    @State var selectedIndex = 0;
    @EnvironmentObject var model:Model
    @AppStorage("isLiteMode") var isLiteMode = true
    @ObservedObject var positionModel = PositionModel()
    @ObservedObject var valuationModel = ValuationModel()

    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()

            ScrollView {
                scrollDetection
//                navigationBar
                featured
                Text("持仓信息".uppercased())
                    .font(.title3)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment:  .leading)
                    .padding(.horizontal ,20)

                LazyVGrid(columns: [GridItem(.adaptive(minimum: 300),spacing: 20)],spacing: 20){
                    if !show{
                       cards
                    }else{
                        ForEach(positionModel.positions, id: \.self){position in
                            Rectangle()
                                .fill(.white)
                                .frame(height:300)
                                .cornerRadius(30)
                                .shadow(color: Color("Shadow"), radius: 20, x: 0, y: 0)
                                .opacity(0.3)
                            .padding(.horizontal, 30)
                        }
                    }
                }
                .padding(.horizontal , 20)


            }
            .coordinateSpace(name: "scroll")
        }
        .statusBar(hidden: !showStatusBar)
        .onChange(of: show){ newValue in
            withAnimation(.closeCard)
            {
                if newValue{
                    showStatusBar = false
                }else{
                    showStatusBar = true
                }
            }


        }
    }

    var scrollDetection: some View{
        GeometryReader{ proxy1 in
            Color.clear.preference(key: ScrollPerferenceKey.self, value: proxy1.frame(in: .named("scroll")).minY)
        }
        .frame(height: 0)
        .onPreferenceChange(ScrollPerferenceKey.self, perform: { value in
            withAnimation(.easeOut) {
                if value < 0{
                    hasScrolled = true
                }else{
                    hasScrolled = false
                }
            }

        })
    }
    var featured: some View{
        TabView{
            ForEach(valuationModel.valuations, id: \.self){ valuation in
                GeometryReader { proxy in
                    let minX = proxy.frame(in: .global).minX

                    FeaturedItem(valuation: valuation)
                        .frame(maxWidth: 500, alignment: .topLeading)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 40)
                        .rotation3DEffect(.degrees(minX / (-10)), axis: (x: 0, y: 1, z: 0)  )
                        .shadow(color: Color("Shadow").opacity(isLiteMode ? 0 : 0.3), radius: 5, x: 0, y: 3)
                        .blur(radius: abs(minX / 40))
                        .onTapGesture{
                            showCourse = true
//                            selectedIndex = index
                        }
                }
            }

        }
        .tabViewStyle(.page(indexDisplayMode:.never))
        .frame(height:200)
        .background(Image("Blob 1").offset(x: 250, y: -100) )
    }

    var cards: some View{
        ForEach(positionModel.positions, id: \.self){position in

            CourseItem(namespace: namespace, show: $show, course: position)
                .onTapGesture {
                    withAnimation(.openCard)
                    {
//                        show.toggle()
//                        model.showDetail.toggle()
//                        showStatusBar = false
//                        selectdID = position.instId
                    }
            }
        }
    }

    var detail:some View{
        ForEach(positionModel.positions, id: \.self){position in
            if position.instId == selectdID{
                CourseView(namespace: namespace, course: position, show: $show)
                    .zIndex(1)
                .transition(.asymmetric(insertion: .opacity.animation(.easeInOut(duration: 0.1)), removal: .opacity.animation(.easeInOut(duration: 0.3).delay(0.2))))
            }

        }
    }
    var navigationBar:some View{
        NavigationBar(title: "Featured", hasScrolled: .constant(false))
    }
}

struct HomeView_Previews: PreviewProvider {

    static var previews: some View {
        HomeView()
            .environmentObject(Model())

    }
}
