//
//  finishGameView.swift
//  MazeTimer
//
//  Created by Maria Berliana on 16/04/23.
//

import SwiftUI

struct finishGameView: View {
    @State var text: String = ""
    let finalText: String = "CONGRATULATION \n \n YOU FINISH THE GAMES \n You have not only succeeded in finishing the games, but you have also taken a step towards improving your time management skills. Well done!"
    @State var currentLevel: Int = UserDefaults.standard.integer(forKey: "Level")
    var body: some View {
            NavigationView{
                VStack{
                    
                        NavigationLink(destination: ContentView()) {
                            StrokeText(text: "Back to Home", width: 2, color: .black)
                                        .foregroundColor(.white)
                                        .font(.system(size: 30, weight: .heavy))
                            
                        }.background(Image("button bg").resizable().frame(width: 300.0, height: 120.0))
                        
                    
                    ZStack{
                        ZStack{
                            Image("pop up bg")
                                .resizable()
                                .frame(width: 900.0, height: 800.0)
                            
                            StrokeText(text: text, width: 3, color: .black)
                                .padding(.leading, -60.0)
                                .foregroundColor(Color.white)
                                .frame(width: 450.0, height: 600.0)
                                .font(.system(size: 30, weight: .heavy))
                                .offset(y: -80.0)
                                .onAppear{typeWriter()}
                                
                        }
                        Image("girl full")
                            .resizable()
                            .frame(width: 400.0, height: 650.0)
                            .offset(x: 300.0,y: 280.0)
                    }
                }.background(Image("bgHome"))
            }.navigationViewStyle(StackNavigationViewStyle())
            .navigationBarBackButtonHidden(true)
        }
    
    func typeWriter(at position: Int = 0) {
        currentLevel = 1
        UserDefaults.standard.set(currentLevel, forKey: "Level")
        if position == 0 {
            text = ""
        }
        if position < finalText.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                text.append(finalText[position])
                typeWriter(at: position + 1)
            }
        }
    }
    
}


struct finishGameView_Previews: PreviewProvider {
    static var previews: some View {
        finishGameView()
    }
}
