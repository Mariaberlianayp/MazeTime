import SwiftUI
import UIKit
import AVKit

class MusicPlayer: NSObject {
    static let shared = MusicPlayer()
    
    private var player: AVPlayer?
    private var playerItem: AVPlayerItem?
    private var isPlaying = false
    
    func playMusic() {
        guard let url = Bundle.main.url(forResource: "music1", withExtension: "mp3") else { return }
        playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        
        NotificationCenter.default.addObserver(self, selector: #selector(playFromStart), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        
        player?.play()
        isPlaying = true
    }
    
    @objc func playFromStart() {
        player?.seek(to: CMTime.zero)
        player?.play()
    }
    
    func stopMusic() {
        player?.pause()
        isPlaying = false
    }
    
    func isMusicPlaying() -> Bool {
        return isPlaying
    }
}

struct ContentView: View {
    @State var gender: String = UserDefaults.standard.string(forKey: "Gender") ?? "girl"
    @State private var isSelectedBoy = false
    @State private var isSelectedGirl = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

        
    
    var body: some View {
        NavigationView {
            VStack {
                
                Image("logo").resizable().frame(width: 800.0, height: 250.0)
                NavigationLink(destination: MazeGameView()) {
                    
                    StrokeText(text: "Start Game", width: 2, color: .black)
                                .foregroundColor(.white)
                                .font(.system(size: 40, weight: .heavy))
                                
                    
                }.background(Image("button bg").resizable().frame(width: 350.0, height: 150.0))
                    .padding(.bottom, 80.0)
                    .padding(.top, 20.0)
                NavigationLink(destination: HowToView()) {
                    StrokeText(text: "How to Play", width: 2, color: .black)
                                .foregroundColor(.white)
                                .font(.system(size: 40, weight: .heavy))
                    
                }.background(Image("button bg").resizable().frame(width: 350.0, height: 150.0))
                    .padding()
                HStack{
                   
                    Button(action: {isSelectedBoy.toggle(); gender = "boy" ; UserDefaults.standard.set(gender, forKey: "Gender")}) {
                        Image("boy full").resizable().frame(width: 400.0, height: 650.0)
                            .opacity(isSelectedBoy ? 1.0 : 0.5)
                            .colorMultiply(isSelectedBoy ? .white : .gray)
                    }
                    Button(action: {isSelectedGirl.toggle(); gender = "girl"; UserDefaults.standard.set(gender, forKey: "Gender")}) {
                        Image("girl full").resizable().frame(width: 400.0, height: 650.0)
                            .opacity(isSelectedGirl ? 1.0 : 0.5)
                            .colorMultiply(isSelectedGirl ? .white : .gray)
                    }
                }
               
            }
            .background(Image("bgHome"))
        }.navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
        .onReceive(timer) { _ in
            if gender == "girl"{
                isSelectedBoy = false
                isSelectedGirl = true
            }
            else{
                isSelectedBoy = true
                isSelectedGirl = false
            }
        }
        .onAppear {
            if !MusicPlayer.shared.isMusicPlaying() {
                MusicPlayer.shared.playMusic()
            }
        }
        .onDisappear {
            MusicPlayer.shared.stopMusic()
        }
    }
    
}
struct StrokeText: View {
    let text: String
    let width: CGFloat
    let color: Color

    var body: some View {
        ZStack{
            ZStack{
                Text(text).offset(x:  width, y:  width)
                Text(text).offset(x: -width, y: -width)
                Text(text).offset(x: -width, y:  width)
                Text(text).offset(x:  width, y: -width)
            }
            .foregroundColor(color)
            Text(text)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
