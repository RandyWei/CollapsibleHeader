//
//  CollapsibleHeaderScrollView.swift
//  CollapsibleHeader
//
//  Created by RandyWei on 2021/9/3.
//

import SwiftUI

struct CollapsibleHeaderScrollView: View {
    
    //获取安全区域
    private let safeAreaInsets = UIApplication.shared.windows.first?.safeAreaInsets
    
    //导航栏上下 Padding
    private let padding: CGFloat = 8.0
    
    //导航栏的高度
    private var navigationBarHeight: CGFloat {
        //导航栏假定是45，具体可以通过代码来获取真实高度
        //导航栏高度 + 流海 + 定义的上下 padding
        45 + (safeAreaInsets?.top ?? 0) + padding * 2
    }
    
    //定义顶部伸缩区域的最大大小，这里设定为350，具体可以根据需要进行设置
    private let collapsibleHeaderMaxHeight: CGFloat = 350
    
    //接下来需要计算 ScrollView 的滚动偏移量
    //偏移量
    @State var offset: CGFloat = 0
    
    //可伸缩区域透明度
    private var collapsibleHeaderOpacity: Double{
        //根据偏移量进行计算达到渐变透明效果:1、要从不透明到透明，因此需要1-计算值；2、可以增加导航栏高度达到比较好的效果
        1 - Double(-offset / (collapsibleHeaderMaxHeight + navigationBarHeight))
    }
    
    //导航栏左侧透明度
    private var navLeftViewOpacity:Double{
        Double(-offset / (collapsibleHeaderMaxHeight + navigationBarHeight))
    }
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack{
                //顶部可以伸缩区域内容
                GeometryReader{proxy in
                    
                    VStack{
                        //大头像
                        Image("avatar")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                        //昵称
                        Text("韦爵爷")
                            .font(.title)
                            .bold()
                        
                        //个性签名
                        Text("这个人很懒，什么都没留下")
                        
                    }
                    .foregroundColor(.white)
                    .padding(.bottom)
                    .frame(maxWidth: .infinity)
                    .frame(height: calcNavHeight(),alignment: .bottom)
                    .opacity(collapsibleHeaderOpacity)
                    .background(Color.blue)
                    //导航条
                    .overlay(
                        HStack{
                            //放错位置了
                            //小头像
                            Image("avatar")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 40, height: 40, alignment: .center)
                                .clipShape(Circle())
                                .opacity(navLeftViewOpacity)
                            
                            Text("韦爵爷")
                                .opacity(navLeftViewOpacity)
                            
                            Spacer()
                            Image(systemName: "gearshape")
                        }
                        .padding(.top, (safeAreaInsets?.top ?? 0) + padding)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .frame(height: navigationBarHeight),
                        alignment: .top
                    )
                    
                }
                .frame(height: collapsibleHeaderMaxHeight)
                .offset(y: -offset)
                .zIndex(1)
                
                //滚动内容
                VStack{
                    
                    ForEach(0..<50){_ in
                        
                        HStack{
                            
                            //左侧图标
                            Image(systemName: "person")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80, alignment: .center)
                            
                            VStack(alignment: .leading){
                                Text("titletitletitletitletitle")
                                    .font(.title)
                                    
                                Spacer()
                                
                                Text("bodybodybodybodybodybody")
                                    .font(.body)
                                
                            }
                            .frame(maxWidth: .infinity,alignment: .leading)
                            
                        }
                        .padding(.horizontal)
                    }
                    
                }
                //仅做占位符演示使用，具体情况以实际项目数据为准
                .redacted(reason: .placeholder)
            }
            .modifier(OffsetViewModifier(offset: $offset))
            
        }
        //定义 scroll view 坐标空间名字
        .coordinateSpace(name: "CollapsibleScrollView")
        
    }
    ///计算伸缩区域大小
    func calcNavHeight() -> CGFloat {
        let height = collapsibleHeaderMaxHeight + offset
        return height < navigationBarHeight ? navigationBarHeight : height
    }
}

struct CollapsibleHeaderScrollView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
