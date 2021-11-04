//
//  InvertingUI.swift
//  OnboardingUIInversion
//
//  Created by King Copones on 11/4/21.
//

import SwiftUI

struct InvertingUI: View {
    
    @State var dotState: DotState = .normal
    @State var dotScale: CGFloat = 1
    @State var dotRotation: Double = 0
    @State var isAnimating = false
    @Binding var currentIndex: Int 
    @State var nextIndex: Int = 1
    
    
    var body: some View {
        ZStack{
            ZStack{
                //Change color based on state...
                (dotState == .normal ? tabs[currentIndex].color : tabs[nextIndex].color)
                
                if dotState == .normal {
                    MinimizedView()
                       
                }else {
                    ExpandedView()
                      
                }
            }.animation(.none, value: dotState)
            
            Rectangle()
                .fill(dotState != .normal ? tabs[currentIndex].color : tabs[nextIndex].color)
                .overlay(
                    ZStack{
                        if dotState != .normal {
                            MinimizedView()
                                
                        }else {
                            ExpandedView()
                               
                        }
                    }
                )
                .animation(.none, value: dotState)
                .mask(
                    GeometryReader { proxy in
                        
                        Circle()
                            .frame(width: 80, height: 80)
                            .scaleEffect(dotScale)
                            .rotation3DEffect(.init(degrees: dotRotation), axis: (x: 0, y: 1, z: 0), anchorZ: dotState == .flipped ? -10 : 10, perspective: 1)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                            .offset(y: -(getSafeArea().bottom  + 25))
                        
                    }
                )
            //for tap gesture
            Circle()
                .foregroundColor(Color.black.opacity(0.01))
                .frame(width: 80, height: 80)
                .overlay(
                Image(systemName: "chevron.right")
                    .font(.title)
                    .foregroundColor(.black)
                    .opacity(dotRotation == -180 ? 0 : 1)
                    .animation(.easeInOut(duration: 0.4), value: dotRotation)
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .onTapGesture (perform: {
                    
                    if isAnimating {return}
                    
                    isAnimating = true
                    
                    withAnimation(.linear(duration: 1.5)){
                        dotRotation = -180
                        dotScale = 8
                        
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.725){
                        withAnimation(.easeInOut(duration: 0.71)){
                            dotState = .flipped
                            
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
                        withAnimation(.easeInOut(duration: 0.5)){
                            dotScale = 1
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.3){
                        withAnimation(.easeInOut(duration: 0.3)){
                            dotRotation = 0
                            dotState = .normal
                            
                            //updating current index
                            currentIndex = nextIndex
                            //updating next index
                            nextIndex = getNextIndex()
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                            isAnimating = false
                        }
                    }
                })
                .offset(y: -(getSafeArea().bottom  + 25))
            
        }.ignoresSafeArea()
    }
    @ViewBuilder
    func Onboarding(tab: Tab)-> some View {
        VStack{
            Image(tab.image)
                .resizable()
                .frame(width: 220, height: 220)
                .aspectRatio(contentMode: .fit)
                .padding(40)
            
            VStack(alignment: .leading, spacing: 0){
                Text(tab.title)
                    .font(.system(size: 40))
                    .foregroundColor(.black)
                Text(tab.subTitle)
                    .font(.system(size: 45, weight: .bold))
                    .foregroundColor(.black)
                Text(tab.description)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding(.top)
                    .frame(width: getRect().width - 80, alignment: .leading)

            }
            .foregroundColor(.white)
            .frame(width: .infinity, alignment: .leading)
            .padding(.leading, 20)
            .padding([.trailing, .top])
        }
    }
    
    func getNextIndex() -> Int{
        let index = (nextIndex + 1) > (tabs.count - 1) ? 0 : (nextIndex + 1)
        
        return index
    }
    
    //Expanded and Minimized
    @ViewBuilder
    func ExpandedView()-> some View {
        Onboarding(tab: tabs[nextIndex])
            .offset(y: -50)
    }
    
    @ViewBuilder
    func MinimizedView()-> some View {
        Onboarding(tab: tabs[currentIndex])
            .offset(y: -50)
    }
}

//struct InvertingUI_Previews: PreviewProvider {
//    static var previews: some View {
//        InvertingUI()
//    }
//}

//Enum
enum DotState{
    case normal
    case flipped
}

extension View {
    func getRect()-> CGRect{
        return UIScreen.main.bounds
    }
    
    func getSafeArea()->UIEdgeInsets{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return.zero
        }
        return safeArea
    }
}
