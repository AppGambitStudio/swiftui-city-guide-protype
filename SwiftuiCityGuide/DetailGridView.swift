//
//  DetailGridView.swift
//  GridDemoSwiftUI
//
//  Created by dev on 24/07/19.
//  Copyright © 2019 appgambit. All rights reserved.
//

import SwiftUI
import Combine

struct DetailGridView : View {
//    @Binding var isOpen: Bool?
    var onDismiss: () -> Void
    @EnvironmentObject var userData: UserData
    var body: some View {
//        NavigationView {
        GeometryReader { geometry in
            ZStack {
                Image(self.userData.selectedCity.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, maxWidth: geometry.size.width, minHeight: 0, maxHeight: geometry.size.height)
                    .clipped()
                    .padding(0)
                    .tapAction {
                        print(geometry.size, (600 * geometry.size.height) / 896)
                }
                VStack() {
                    DetailHeader(userData: self.userData)
                    //Spacer()
                    DetailSlider(size: geometry.size)
                }.padding(.top, 100)
            }
        }.edgesIgnoringSafeArea(.all)
            .navigationBarItems(leading: Button(action: self.onDismiss, label: {
                Image(systemName: "xmark").foregroundColor(.white).padding().padding(.top)
            }), trailing: HStack{
                Image(systemName: "mappin.and.ellipse")
                    .padding(.trailing, 40)
                Image(systemName: "magnifyingglass")
            }.foregroundColor(.white).padding().padding(.top)
        )
        //}
    }
    struct DetailHeader: View {
        var userData: UserData
        var body: some View {
            VStack {
                HStack() {
                    Text(self.userData.selectedCity.name).font(.largeTitle).bold().foregroundColor(.white)
                    Spacer()
                    Image(systemName: "cloud.sun").offset(y: -5)
                    Text("17°C")
                }.padding()
                Text("Grab your coat and a handful of glitter, and enter the land of fog and fabulousness.").lineLimit(nil).padding()
                    .offset(x: -8)
            }.padding().foregroundColor(.init(white: 0.9))
        }
    }
    struct DetailSlider: View {
        var size: CGSize
        var link: NavigationDestinationLink<DetailView>
        var publisher: AnyPublisher<Void, Never>
        
        init(size: CGSize) {
            let publisher = PassthroughSubject<Void, Never>()
            self.link = NavigationDestinationLink(
                DetailView(onDismiss: { publisher.send() }),
                isDetail: false
            )
            self.publisher = publisher.eraseToAnyPublisher()
            self.size = size
        }

        var body: some View {
            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(0...5) {i in
                            Button(action:{
                                self.link.presented?.value = true
                            }) {
                                DetailSliderCell(size: self.size)
                                
                            }.buttonStyle(.plain).onReceive(self.publisher, perform: { _ in
                                self.link.presented?.value = false
                            })
                        }
                        Spacer()
                    }.offset(CGSize(width: 40, height: 0))
                        .padding(.trailing, 40)
                }.padding([.bottom, .top], 30)
                    .frame(minWidth: 0, maxWidth: geometry.size.width, minHeight: (600 * self.size.height) / 896, maxHeight: (600 * self.size.height) / 896)
            }
        }
    }
    struct DetailSliderCell: View {
        var size: CGSize
        var body: some View {
            VStack(alignment: .leading) {
                HStack {
                    Text("NATURE")
                        .padding(2)
                        .padding([.leading, .trailing], 2)
                        .font(.system(size: 10))
                        .background(LinearGradient(gradient: Gradient(colors: [Color.init(0x99FFBC), Color.init(0x00CCC1)]), startPoint: .leading, endPoint: .trailing), cornerRadius: 0)
                    Spacer()
                }.padding()
                Text("Arctic Circle and Fjords by Rail")
                    .bold()
                    .foregroundColor(.init(0x333333))
                    .padding([.leading, .trailing])
                    .font(.system(size: 19))
                    .lineLimit(nil)
                Text("The Artical Circle may sound like a chilly destination, but when you go in the summer, there's planty to see and do by the light of the midnight")
                    .foregroundColor(.secondary)
                    .font(.system(size: 13))
                    .lineLimit(nil)
                    .padding([.leading, .trailing])
                Spacer()
                Image("icybay")
                    .resizable()
                    .aspectRatio(1.3, contentMode: .fill)
                    .frame(minHeight: 130, maxHeight: 130)
                    .cornerRadius(5)
                    .clipped()
                    .padding([.leading, .trailing])
                    .padding(.bottom, 10)
                
                Divider().padding([.leading, .trailing])
                HStack {
                    Text("27").bold()
                        .foregroundColor(.init(0x333333))
                    Text("PLACES")
                        .font(.system(size: 11))
                    Spacer()
                    Image(systemName: "heart")
                        .offset(y: 2)
                    Image(systemName: "square.and.arrow.up")
                        .padding(.leading, 8)
                }.padding([.leading, .trailing, .bottom])
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
            }.frame(minWidth: 220, maxWidth: 220, minHeight: 400, maxHeight: 400).background(Color.white)
        }
    }
}

//#if DEBUG
//struct DetailGridView_Previews : PreviewProvider {
//    static var previews: some View {
//        DetailGridView()
//    }
//}
//#endif
