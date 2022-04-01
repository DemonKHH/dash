//
//  AvatarView.swift
//  Dash
//
//  Created by zw on 2022/3/15.
//

import SwiftUI



struct AvatarView: View {
    @State private var remoteImage : UIImage? = nil
    @AppStorage("isLogged") var isLogged = true
    
    init(){
        fetchRemoteImage()
    }
    
    func fetchRemoteImage() //用来下载互联网上的图片
    {
        guard let url = URL(string: "https://picsum.photos/200") else { return } //初始化一个字符串常量，作为网络图片的地址
        URLSession.shared.dataTask(with: url){ (data, response, error) in //执行URLSession单例对象的数据任务方法，以下载指定的图片
            if let image = UIImage(data: data!){
                self.remoteImage = image //当图片下载成功之后，将下载后的数据转换为图像，并存储在remoteImage属性中
            }
            else{
                print(error ?? "") //如果图片下载失败之后，则在控制台输出错误信息
            }
        }.resume() //通过执行resume方法，开始下载指定路径的网络图片
    }

    var body: some View {
        Group {
            if isLogged {
                Image(uiImage: remoteImage!)
            }else{
                Image("Avatar Default")
                    .resizable()
            }
        }

        .frame(width: 26, height: 26)
        .cornerRadius(10)
        .padding(8)
//        .background(.ultraThinMaterial, in:RoundedRectangle(cornerRadius: 18, style: .continuous))
        .strokeStyle(cornerRadius:18)
    }
}


struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView()
    }
}
