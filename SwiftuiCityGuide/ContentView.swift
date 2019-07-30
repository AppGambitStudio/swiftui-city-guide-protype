//
//  ContentView.swift
//  GridDemoSwiftUI
//
//  Created by dev on 22/07/19.
//  Copyright © 2019 appgambit. All rights reserved.
//

import SwiftUI
import Combine

extension Color {
    init(_ hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
struct City: Identifiable {
    let id: Int
    let name: String
    let image: String
}

let allCitys = [
    City(id: 0, name: "Lake Louise", image:"lakeLouise"),
    City(id: 1, name: "San Francisco", image:"sanFrancisco"),
    City(id: 2, name: "Ålesund", image:"alesund"),
    City(id: 3, name: "Paris", image:"paris")
]
struct SliderCell: View {
    var size: CGSize
    var city: City
    var body: some View {
        VStack(alignment: .leading) {
            Image(city.image)
                .resizable()
                .frame(minWidth: 0, maxWidth: (335 * size.height) / 818)
                .aspectRatio(1.7, contentMode: .fill)
                .clipped()
                .shadow(color: .clear, radius: 0, x: 0, y: 0)
            Text(city.name)
                .bold()
                .foregroundColor(Color.init(0x222222))
                .font(.largeTitle)
                .padding(.leading)
                .padding(.top, 10)
            Text("Grab your coat and a handful of glitter, and enter the land of fog and fabulousness.")
                .foregroundColor(.secondary)
                .font(.subheadline)
                .lineLimit(nil)
                .frame(minWidth: 0, maxWidth: (303 * size.height) / 818)
                .padding(.bottom, 80)
                .padding(.leading)
            HStack {
                Text("EXPLORE →")
                    .bold()
                    .foregroundColor(Color.init(0x222222))
                    .font(.system(size: 10))
                    .padding()
                Spacer()
            }
        }
        .background(Color.white)
            .cornerRadius(8)
            .shadow(color: Color.init(0xcccccc), radius: 10, x: 0, y: 15)
            .padding(.bottom, 50)
            //            .offset(x: 40, y: 10)
            .offset(CGSize(width: 0, height: 10))
        
    }
}
struct SliderView: View {
    var geometry: GeometryProxy
    var size: CGSize
    var link: NavigationDestinationLink<DetailGridView>
    var publisher: AnyPublisher<Void, Never>
    @EnvironmentObject var userData: UserData

    init(geometry: GeometryProxy) {
        let publisher = PassthroughSubject<Void, Never>()
        self.geometry = geometry
        self.size = geometry.size
        self.link = NavigationDestinationLink(
            DetailGridView(onDismiss: { publisher.send() }),
            isDetail: false
        )
        self.publisher = publisher.eraseToAnyPublisher()
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("DESTINATIONS")
                    .bold()
                    .foregroundColor(Color.init(0x444444))
                    .font(.subheadline)
                Image(systemName: "chevron.down")
                    .font(.system(size: 10))
                Spacer()
                Image(systemName: "slider.horizontal.3")
            }
            .foregroundColor(Color.init(0x888888))
                .padding()
                .padding([.leading, .trailing], 25)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(userData.citys) { city in
                        Button(action:{
                            self.userData.selectedCity = city
                            self.link.presented?.value = true
                        }) {
                            SliderCell(size: self.size, city: city)
                        }.buttonStyle(.plain).onReceive(self.publisher, perform: { _ in
                            self.link.presented?.value = false
                        })
                    }
                }.offset(CGSize(width: 40, height: 0))
                    .padding(.trailing, 80)
                
            }.frame(minWidth: 0, maxWidth: size.width, minHeight: 0, maxHeight: (550 * size.height) / 818)
            Spacer()
        }.padding(.top)
            .tapAction {
                print("Cell Tap")
        }
        
    }
}
struct SearchBar: View {
    @Binding var searchText: String
    var body: some View {
        VStack {
            HStack() {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding([.leading, .trailing])
                TextField($searchText, placeholder: Text("Where do you want to go?"))
                    .font(.subheadline)
            }
        }
        .padding()
            .background(Color.white)
            .cornerRadius(5)
            .shadow(color: Color(0xcccccc), radius: 20, x: 0, y: 15)
    }
}
struct BottomView: View {
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text("∙")
                    .offset(y: 8)
                Image(systemName: "safari.fill")
            }
            .foregroundColor(Color.init(0x666666))
            
            Spacer()
            Spacer()
            VStack {
                Text(" ")
                    .offset(y: 8)
                Image(systemName: "mappin.and.ellipse")
            }
            .foregroundColor(Color.init(0xaaaaaa))
            Spacer()
            Spacer()
            VStack {
                Text(" ")
                    .offset(y: 8)
                Image(systemName: "person.fill")
            }
            .foregroundColor(Color.init(0xaaaaaa))
            Spacer()
        }.padding()
    }
}
struct ContentView : View {
    @State var searchText: String

    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    VStack {
                        SearchBar(searchText: self.$searchText)
                            .padding()
                            .padding([.top, .leading, .trailing])
                        SliderView(geometry: geometry)
                        BottomView()
                    }.tapAction {
                        print(geometry.size)
                    }
                }
                .navigationBarHidden(true)
                    .navigationBarTitle(" ")
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView(searchText: "")
    }
}
#endif
