//
//  EmptyView.swift
//  Todo
//
//  Created by Mohamed Ali on 10/06/2023.
//

import SwiftUI

struct EmptyView: View {
    
    let images: [String] = [
      "illustration-no1",
      "illustration-no2",
      "illustration-no3"
    ]
    
    let tips: [String] = [
      "Use your time wisely.",
      "Slow and steady wins the race.",
      "Keep it short and sweet.",
      "Put hard tasks first.",
      "Reward yourself after work.",
      "Collect tasks ahead of time.",
      "Each night schedule for tomorrow."
    ]
    @ObservedObject var theme = ThemeSettings.shared
    let themes = themeData
    
    var body: some View {
        VStack(alignment:.center, spacing: 20) {
            Image(images.randomElement() ?? images[0])
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(minWidth: 256, idealWidth: 280, maxWidth: 360, minHeight: 256, idealHeight: 280, maxHeight: 360, alignment: .center)
                .layoutPriority(1)
            
            
            Text(tips.randomElement() ?? tips[0])
                .layoutPriority(0.5)
                .font(.system(.headline, design: .rounded))
            
        }
        .foregroundColor(themes[self.theme.themeSettings].color)
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
