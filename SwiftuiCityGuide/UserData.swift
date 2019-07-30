//
//  Test.swift
//  GridDemoSwiftUI
//
//  Created by dev on 25/07/19.
//  Copyright © 2019 appgambit. All rights reserved.
//

import SwiftUI
import Combine

final class UserData: BindableObject {
  let willChange = PassthroughSubject<UserData, Never>()

    var citys: [City] = allCitys {
    willSet {
      willChange.send(self)
    }
        
  }
    var selectedCity: City = allCitys[0] {
        willSet {
            willChange.send(self)
        }
    }
}
