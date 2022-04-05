//
//  FeaturedItem.swift
//  Dash
//
//  Created by zw on 2022/3/9.
//

import SwiftUI


struct FeaturedItem: View {
    var valuation: Valuation
    var body: some View {
        VStack(alignment: .leading, spacing:8){
//            Spacer()
//                .strokeStyle(cornerRadius: 16 )
            Text("资产：\(valuation.totalBal)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .lineLimit(1)
            Text("涨幅：23%")
                .font(.title3)
                .fontWeight(.bold)
                .lineLimit(1)

        }
        .padding(/*@START_MENU_TOKEN@*/.all, 20.0/*@END_MENU_TOKEN@*/)
//        .padding(.vertical, 20)
        .frame(height: 100.0, alignment: .topLeading)
//        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
//        .strokeStyle()
//        .padding(.horizontal, 0)

    }
}


struct FeaturedItem_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedItem(valuation: valuationsMock)
    }
}
