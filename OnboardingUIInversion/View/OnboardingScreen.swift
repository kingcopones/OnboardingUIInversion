//
//  OnboardingScreen.swift
//  OnboardingUIInversion
//
//  Created by King Copones on 11/3/21.
//

import SwiftUI

struct OnboardingScreen: View {
    @State var currentIndex: Int = 0
    var body: some View {
        ZStack{
            InvertingUI(currentIndex: $currentIndex)
                .ignoresSafeArea()
            
            //indicators
            HStack(spacing: 10){
                ForEach(tabs.indices, id:\.self){ index in
                    
                    Circle()
                        .fill(.black)
                        .frame(width: 8, height: 8)
                        .opacity(currentIndex == index ? 1 : 0.3)
                        .scaleEffect(currentIndex == index ? 1.1 : 0.8)
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                .padding(25)
            
            Button("Skip"){
                
            }.font(.system(size: 18, weight: .bold))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreen()
    }
}
