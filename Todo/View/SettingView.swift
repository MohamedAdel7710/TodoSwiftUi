//
//  SettingView.swift
//  Todo
//
//  Created by Mohamed Ali on 11/06/2023.
//

import SwiftUI

struct SettingView: View {
    
    //MARK: - PROPPERTIES
    @Environment(\.dismiss) var dismissView
    let themes = themeData
    let theme = ThemeSettings.shared
    @State private var themeChanged: Bool = false
    //MARK: - BODY
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        List{
                            ForEach(themes, id: \.id) { theme in
                                Button {
                                    self.theme.themeSettings = theme.id
                                    UserDefaults.standard.set(self.theme.themeSettings, forKey: "theme")
                                    themeChanged.toggle()
                                } label: {
                                    HStack {
                                        Circle()
                                            .frame(width: 15, height: 15, alignment: .center)
                                            .foregroundColor(theme.color)
                                        Text(theme.name)
                                    }// HSTACK
                                    .tint(Color.primary)
                                }// BUTTON
                            }// LIST
                        }
                    } header: {
                        HStack {
                            Text("choose the app theme")
                            Circle()
                                .frame(width: 12, height: 12, alignment: .center)
                                .foregroundColor(themes[theme.themeSettings].color)
                        }
                    }// THEME SECTION
                            
                    Section("about the application") {
                        FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Todo")
                        FormRowStaticView(icon: "checkmark.seal", firstText: "Compatibility", secondText: "iPhone, iPad")
                        FormRowStaticView(icon: "flag", firstText: "Version", secondText: "1.5.0")
                    }// INFO SECTION
                    .padding(.vertical, 3)
                }// FORM
                
                Text("Copyright © All rights reserved.\nBetter Apps ♡ Less Code")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(.top, 6)
                    .padding(.bottom, 8)
                    .foregroundColor(Color.secondary)
                
            }// VSTACK
            
            .background(Color("ColorBackground").edgesIgnoringSafeArea(.all))
            
            .navigationTitle("Setting")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismissView()
                    } label: {
                        Image(systemName: "xmark")
                    }

                }
            }// TOOLBAR
        }// NAVIGATION VIEW
        .navigationViewStyle(StackNavigationViewStyle())
        .alert(isPresented: $themeChanged) {
          Alert(
            title: Text("SUCCESS!"),
            message: Text("App has been changed to the \(themes[self.theme.themeSettings].name)!"),
            dismissButton: .default(Text("OK"))
          )
      }// ALERT
        .accentColor(themes[self.theme.themeSettings].color)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
