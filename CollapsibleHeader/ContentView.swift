//
//  ContentView.swift
//  CollapsibleHeader
//
//  Created by RandyWei on 2021/9/3.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        CollapsibleHeaderScrollView()
            .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
