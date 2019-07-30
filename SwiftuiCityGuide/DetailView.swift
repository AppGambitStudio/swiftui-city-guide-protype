//
//  DetailView.swift
//  GridDemoSwiftUI
//
//  Created by dev on 25/07/19.
//  Copyright © 2019 appgambit. All rights reserved.
//

import SwiftUI

struct DetailView : View {
    var onDismiss: () -> Void

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    Text("Article Circle and Fjords by Rail")
                        .bold()
                        .font(.largeTitle)
                        .foregroundColor(.init(0x333333))
                        .lineLimit(nil)
                        .padding()
                    Text("The Artical Circle may sound like a chilly destination, but when you go in the summer, there's planty to see and do by the light of the midnight sun.")
                        .foregroundColor(.secondary)
                        .font(.system(size: 15))
                        .lineLimit(nil)
                        .padding([.leading, .trailing])
                    Image("icybay")
                        .resizable()
                        .aspectRatio(1.3, contentMode: .fill)
                        .frame(minHeight: 230, maxHeight: 230)
                        .cornerRadius(5)
                        .clipped()
                        .padding()
                    Text("Day 1. Trondheim")
                        .bold()
                        .foregroundColor(.init(0x333333))
                        .padding()
                    Text("Travel by bus to Andalsnes. Transfer to a train and take the Dovre and Rouma railways through the mountains, valleys and rivers of this region.")
                        .foregroundColor(.secondary)
                        .font(.system(size: 17))
                        .lineLimit(nil)
                        .padding([.leading, .trailing])
                    Image("icybay")
                        .resizable()
                        .aspectRatio(1.3, contentMode: .fill)
                        .frame(minHeight: 230, maxHeight: 230)
                        .cornerRadius(5)
                        .clipped()
                        .padding()
                    
                    Spacer()
                }.padding()
                    .frame(width: geometry.size.width, height: geometry.size.height * 2, alignment: .center)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarItems(leading: Button(action: self.onDismiss, label: {
                        Image(systemName: "arrow.left").foregroundColor(.gray).padding().padding(.top)
                    }), trailing: HStack{
                        Image(systemName: "heart")
                            .offset(y: 4)
                            .padding(.trailing, 40)
                        Image(systemName: "square.and.arrow.up")
                    }.foregroundColor(.gray).padding().padding(.top)
                ).font(.system(size: 18))
            }
                HStack {
                    Spacer()
                    Text("\n\n\n\n").lineLimit(nil)
                }.background(Color.clear)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(0xffffff, opacity: 0.01), Color.white]), startPoint: .top, endPoint: .bottom), cornerRadius: 0)

            }.edgesIgnoringSafeArea(.bottom)
        }
    }
}

//#if DEBUG
//struct DetailView_Previews : PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
//#endif
