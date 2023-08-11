//
//  HowToView.swift
//  MazeTimer
//
//  Created by Maria Berliana on 15/04/23.
//

import SwiftUI

struct HowToView: View {
    @State var appeared: Double = 0
    @State var text: String = ""
    let finalText: String = "Welcome to MAZETIME \n \n In this game, you will learn about time management \n You should do your homework first before playing games or going hangout"
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    NavigationLink(destination: ContentView()) {
                        StrokeText(text: "Back to Home", width: 2, color: .black)
                                    .foregroundColor(.white)
                                    .font(.system(size: 30, weight: .heavy))
                        
                    }.background(Image("button bg").resizable().frame(width: 300.0, height: 120.0))
                    
                    Spacer()
                    NavigationLink(destination: HowToView2()) {
                        StrokeText(text: "Next", width: 2, color: .black)
                                    .foregroundColor(.white)
                                    .font(.system(size: 40, weight: .heavy))
                        
                    }.background(Image("button bg").resizable().frame(width: 300.0, height: 120.0))
                    
                    
                }.padding(.horizontal, 150.0)
                
                ZStack{
                    ZStack{
                        Image("pop up bg")
                            .resizable()
                            .frame(width: 900.0, height: 800.0)
                        
                        StrokeText(text: text, width: 3, color: .black)
                            .padding(.leading, -60.0)
                            .foregroundColor(Color.white)
                            .frame(width: 450.0, height: 600.0)
                            .font(.system(size: 40, weight: .heavy))
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
        .opacity(appeared)
        .animation(Animation.easeIn(duration: 1.0), value: appeared)
        .onAppear {self.appeared = 1.0}
        .onDisappear {self.appeared = 0.0}
        
    }
    
    init(){
            UINavigationBar.setAnimationsEnabled(false)
        }
    
    func typeWriter(at position: Int = 0) {
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

struct HowToView2: View {
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    NavigationLink(destination: HowToView()) {
                        StrokeText(text: "Previous", width: 2, color: .black)
                                    .foregroundColor(.white)
                                    .font(.system(size: 40, weight: .heavy))
                        
                    }.background(Image("button bg").resizable().frame(width: 300.0, height: 120.0))
                    
                    Spacer()
                    NavigationLink(destination: HowToView3()) {
                        StrokeText(text: "Next", width: 2, color: .black)
                                    .foregroundColor(.white)
                                    .font(.system(size: 40, weight: .heavy))
                        
                    }.background(Image("button bg").resizable().frame(width: 300.0, height: 120.0))
                    
                    
                }.padding(.horizontal, 150.0)
                
                ZStack{
                    ZStack{
                        Image("pop up bg")
                            .resizable()
                            .frame(width: 900.0, height: 800.0)
                        VStack(alignment: .leading){
                            HStack{
                                Image("study").resizable()
                                    .frame(width: 80.0, height: 80.0)
                                StrokeText(text: "This icon means your homework", width: 3, color: .black)
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 35, weight: .heavy))
                            }.padding(.leading, -240.0)
                            HStack{
                                Image("games").resizable()
                                    .frame(width: 80.0, height: 80.0)
                                StrokeText(text: "This icon means your games room", width: 3, color: .black)
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 35, weight: .heavy))
                            }
                            .padding(.leading, -240.0)
                            HStack{
                                Image("hangout").resizable()
                                    .frame(width: 80.0, height: 80.0)
                                StrokeText(text: "This icon means going hangout", width: 3, color: .black)
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 35, weight: .heavy))
                            }
                        }.frame(width: 500.0, height: 800.0)
                            .offset(x:130.0, y: -90.0)
                        
                    }
                    Image("boy full")
                        .resizable()
                        .frame(width: 400.0, height: 650.0)
                        .offset(x: -300.0,y: 280.0)
                }
            }.background(Image("bgHome"))
        }.navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
    }
    
    init(){
            UINavigationBar.setAnimationsEnabled(false)
        }
    
}

struct HowToView3: View {
    
    @State var text: String = ""
    let finalText: String = "You should go from the start position to your homework as fast as possible before the time runs out. The time at the top of the game indicates your deadline to finish your homework."
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    NavigationLink(destination: HowToView2()) {
                        StrokeText(text: "Previous", width: 2, color: .black)
                                    .foregroundColor(.white)
                                    .font(.system(size: 40, weight: .heavy))
                        
                    }.background(Image("button bg").resizable().frame(width: 300.0, height: 120.0))
                    
                    Spacer()
                    NavigationLink(destination: HowToView4()) {
                        StrokeText(text: "Next", width: 2, color: .black)
                                    .foregroundColor(.white)
                                    .font(.system(size: 40, weight: .heavy))
                        
                    }.background(Image("button bg").resizable().frame(width: 300.0, height: 120.0))
                    
                    
                }.padding(.horizontal, 150.0)
                
                ZStack{
                    ZStack{
                        Image("pop up bg")
                            .resizable()
                            .frame(width: 900.0, height: 800.0)
                        
                        StrokeText(text: text, width: 3, color: .black)
                            .padding(.leading, -60.0)
                            .foregroundColor(Color.white)
                            .frame(width: 450.0, height: 600.0)
                            .font(.system(size: 40, weight: .heavy))
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
    init(){
            UINavigationBar.setAnimationsEnabled(false)
        }
    
}

struct HowToView4: View {

    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    NavigationLink(destination: HowToView3()) {
                        StrokeText(text: "Previous", width: 2, color: .black)
                                    .foregroundColor(.white)
                                    .font(.system(size: 40, weight: .heavy))
                        
                    }.background(Image("button bg").resizable().frame(width: 300.0, height: 120.0))
                    
                    Spacer()
                    NavigationLink(destination: HowToView5()) {
                        StrokeText(text: "Next", width: 2, color: .black)
                                    .foregroundColor(.white)
                                    .font(.system(size: 40, weight: .heavy))
                        
                    }.background(Image("button bg").resizable().frame(width: 300.0, height: 120.0))
                    
                    
                }.padding(.horizontal, 150.0)
                
   
                ZStack{
                    Image("pop up bg")
                        .resizable()
                        .frame(width: 900.0, height: 800.0)
                    VStack{
                        StrokeText(text: "If during your journey to finish your homework, you go to games room, your time will decrease by 20 seconds. If you going hangout, your time will decrease by 25 seconds.", width: 3, color: .black)
                            .padding(.leading, -60.0)
                            .padding(.top, -150.0)
                            .foregroundColor(Color.white)
                            .frame(width: 450.0, height: 600.0)
                            .font(.system(size: 40, weight: .heavy))
                        
                        Image("minus time").resizable()
                            .frame(width: 400.0, height: 150.0)
                            .padding(.top, -200.0)
                        
                    }
                    
                }
                
            }.background(Image("bgHome"))
        }.navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
    }
    init(){
            UINavigationBar.setAnimationsEnabled(false)
        }
    
}

struct HowToView5: View {
    
    @State var text: String = ""
    let finalText: String = "If the time is up, you failed to complete your homework. You can play again if you failed, enjoy the journey."
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    NavigationLink(destination: HowToView4()) {
                        StrokeText(text: "Previous", width: 2, color: .black)
                                    .foregroundColor(.white)
                                    .font(.system(size: 40, weight: .heavy))
                        
                    }.background(Image("button bg").resizable().frame(width: 300.0, height: 120.0))
                    
                    Spacer()
                    NavigationLink(destination: ContentView()) {
                        StrokeText(text: "Back to Home", width: 2, color: .black)
                                    .foregroundColor(.white)
                                    .font(.system(size: 30, weight: .heavy))
                        
                    }.background(Image("button bg").resizable().frame(width: 300.0, height: 120.0))
                    
                    
                }.padding(.horizontal, 150.0)
                
                ZStack{
                    ZStack{
                        Image("pop up bg")
                            .resizable()
                            .frame(width: 900.0, height: 800.0)
                        
                        StrokeText(text: text, width: 3, color: .black)
                            .padding(.leading, -60.0)
                            .foregroundColor(Color.white)
                            .frame(width: 350.0, height: 600.0)
                            .font(.system(size: 40, weight: .heavy))
                            .offset(x:130.0, y: -100.0)
                            .onAppear{typeWriter()}
                            
                    }
                    Image("boy full")
                        .resizable()
                        .frame(width: 400.0, height: 650.0)
                        .offset(x: -300.0,y: 280.0)
                }
            }.background(Image("bgHome"))
        }.navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
    }
    
    func typeWriter(at position: Int = 0) {
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
    init(){
            UINavigationBar.setAnimationsEnabled(false)
        }
    
}

extension String {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}

struct HowToView_Previews: PreviewProvider {
    static var previews: some View {
        HowToView()
    }
}
