//
//  OffsetViewModifier.swift
//  CollapsibleHeader
//
//  Created by RandyWei on 2021/9/3.
//

import SwiftUI


struct OffsetViewModifier:ViewModifier {
    
    @Binding var offset:CGFloat
    
    func body(content: Content) -> some View {
        
        content.overlay(
            GeometryReader{proxy -> Color in
                //需要获取是视图在 scrollview 中的偏移量，此处从指位置空间获取
                let minY = proxy.frame(in: .named("CollapsibleScrollView")).minY
                
                DispatchQueue.main.async {
                    self.offset = minY
                }
                
                return Color.clear
            },
            alignment: .top
        )
        
    }
}
