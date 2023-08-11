//
//  nextLevelView.swift
//  MazeTimer
//
//  Created by Maria Berliana on 15/04/23.
//

import SwiftUI

struct nextLevelView: View {
    var body: some View {
        NavigationView{
            VStack{
                VStack{
                    StrokeText(text: "CONGRATULATION", width: 5, color: .black)
                        .font(.system(size: 65, weight: .bold))
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
                            StrokeText(text: "Next Level", width: 2, color: .black)
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

struct nextLevelView_Previews: PreviewProvider {
    static var previews: some View {
        nextLevelView()
    }
}
