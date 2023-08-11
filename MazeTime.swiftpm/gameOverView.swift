//
//  gameOverView.swift
//  testMaze
//
//  Created by Maria Berliana on 14/04/23.
//

import SwiftUI

struct gameOverView: View {
    @State var currentLevel: Int = UserDefaults.standard.integer(forKey: "Level")
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView{
            VStack{
                VStack{
                    StrokeText(text: "GAME OVER", width: 5, color: .black)
                        .font(.system(size: 100, weight: .bold))
                        .foregroundColor(Color.orange)
                        .padding(.bottom, 40.0)
                        .foregroundStyle(
                            .linearGradient(
                                colors: [.yellow, .orange, .red],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        ).padding()
                    HStack{
                        NavigationLink(destination: ContentView()) {
                            StrokeText(text: "Back to Home", width: 2, color: .black)
                                        .foregroundColor(.white)
                                        .font(.system(size: 30, weight: .heavy))
                            
                        }.background(Image("button bg").resizable().frame(width: 300.0, height: 120.0))
                            .padding(.leading, -20.0)
                        NavigationLink(destination: MazeGameView()) {
                            StrokeText(text: "Play again", width: 2, color: .black)
                                        .foregroundColor(.white)
                                        .font(.system(size: 30, weight: .heavy))
                            
                        }.background(Image("button bg").resizable().frame(width: 300.0, height: 120.0))
                            .padding(.leading, 120.0)
                        
                    }
                    
                }.background(Image("pop up bg").resizable().frame(width: 800.0, height: 750.0))
            }.background(Image("bgHome"))
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
        
    }
    
}

struct gameOverView_Previews: PreviewProvider {
    static var previews: some View {
        gameOverView()
    }
}
