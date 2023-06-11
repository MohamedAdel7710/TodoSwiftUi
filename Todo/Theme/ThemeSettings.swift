//
//  ThemeSettings.swift
//  Todo
//
//  Created by Mohamed Ali on 11/06/2023.
//

import SwiftUI

class ThemeSettings :ObservableObject{
    private init() {}
    public static let shared = ThemeSettings()
    
    @Published public var themeSettings: Int = UserDefaults.standard.integer(forKey: "theme") {
        didSet {
          UserDefaults.standard.set(self.themeSettings, forKey: "theme")
        }
    }
}
