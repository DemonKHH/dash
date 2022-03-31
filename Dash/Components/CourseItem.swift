//
//  CourseItem.swift
//  Dash
//
//  Created by 流年划过颜夕 on 2022/3/9.
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
                    .font(.title3)
                    .matchedGeometryEffect(id: "title\(course.instId)", in: namespace)
                .frame(maxWidth:.infinity, alignment:  .leading)
                Text("收益：\(course.upl)")
                    .font(.title3)
                    .matchedGeometryEffect(id: "subtitle\(course.upl)", in: namespace)
                Text("收益率：\(Float64(course.uplRatio) ?? 0 * 100)%")
                    .font(.title3)
                    .matchedGeometryEffect(id: "text\(course.uplRatio)", in: namespace)
                Text("持仓量：\(Float64(course.pos) ?? 0 * 10)")
                    .font(.title3)
                    .matchedGeometryEffect(id: "subtitle\(course.pos)", in: namespace)
                Text("保证金余额：\(course.margin)")
                    .font(.title3)
                    .matchedGeometryEffect(id: "text\(course.margin)", in: namespace)
            }
            .padding(20)
            .background(
                Rectangle().fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .blur(radius: 30)
                    .matchedGeometryEffect(id: "blur\(course.instId)", in: namespace))

        }

        .foregroundColor(.white)
        .background(
            Image(courses[0].image)
                .resizable().aspectRatio(contentMode: .fit)
                .padding(20)
                .matchedGeometryEffect(id: "image\(course.instId)", in: namespace)
        )
        .background(
            Image(courses[0].background)
                .resizable().aspectRatio(contentMode: .fill).matchedGeometryEffect(id: "background\(course.instId)", in: namespace)
        )                .mask(RoundedRectangle(cornerRadius: 30, style: .continuous)
                                .matchedGeometryEffect(id: "mask\(course.instId)", in: namespace))
        .frame(height:300)
        .padding(20)
    }
}

struct CourseItem_Previews: PreviewProvider {
    @Namespace static var namespace

    static var previews: some View {
        CourseItem(namespace: namespace, show: .constant(true), course: PositionModel().positions[0])
    }
}
