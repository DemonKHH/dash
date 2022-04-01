//
//  CourseItem.swift
//  Dash
//
//
//

import SwiftUI


struct CourseItem: View {
    var namespace: Namespace.ID
    @Binding var show: Bool
    var course: Position

    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 12)
            {
                Text("产品：\(course.instId)")
//                    .matchedGeometryEffect(id: "title\(course.instId)", in: namespace)
                .frame(maxWidth:.infinity, alignment:  .leading)
                Text("收益：\(String(format: "%.2f", Float64(course.upl) ?? 0/1000))")

//                    .matchedGeometryEffect(id: "text\(course.upl)", in: namespace)
                Text("收益率：\((Float64(course.uplRatio) ?? 0) * 100)%")

//                    .matchedGeometryEffect(id: "text\(course.uplRatio)", in: namespace)
                Text("开仓均价：\(course.avgPx)")

//                    .matchedGeometryEffect(id: "text\(course.avgPx)", in: namespace)
                Text("预估强行平价：\(course.liqPx)")

//                    .matchedGeometryEffect(id: "text\(course.liqPx)", in: namespace)
                Text("持仓量：\(Float64(course.pos) ?? 0 * 10)")

//                    .matchedGeometryEffect(id: "text\(course.pos)", in: namespace)
                Text("保证金余额：\(String(format: "%.2f", Float(course.margin) ?? 0/1000))")

//                    .matchedGeometryEffect(id: "text\(course.margin)", in: namespace)
                Text("保证金率：\(String(format: "%.2f", Float(course.mgnRatio) ?? 0/1000))")

//                    .matchedGeometryEffect(id: "text\(course.mgnRatio)", in: namespace)
            }
            .padding(20)
        }

        .foregroundColor(.black)
        .background(Color(red: 236, green: 240, blue: 241))
        .cornerRadius(15)
        .frame(height:300)
        .padding(.top, 20)
        .padding(.bottom, 5)
    }
}


struct CourseItem_Previews: PreviewProvider {
    @Namespace static var namespace

    static var previews: some View {
        CourseItem(namespace: namespace, show: .constant(true), course: PositionModel().positions[0])
    }
}
