//
//  MazeGameView.swift
//  MazeTimer
//
//  Created by Maria Berliana on 15/04/23.
//

import SwiftUI

struct MazeGameView: View {

    // Previous position of the player in the maze
    @State var previousPosition = GridPosition(x: 0, y: 0)
    // Current position of the player in the maze
    @State var playerPosition = GridPosition(x: 3, y: 0)
    // Controller for moving the player
    let controller = MazeGameController()
    
    // Current level of the maze game
    @State var currentLevel: Int = UserDefaults.standard.integer(forKey: "Level")
//    @State var currentLevel: Int = 10
    
    //TIMER
    @State private var remainingTime: TimeInterval = 100 // 2 minutes and 30 seconds in seconds
    @State private var showAlert = false // to show the "Game Over" message
    @State private var showMinus = false // to show time minus
    @State private var showMinushangout = false // to show time minus
    @State private var nextLevel = false // to next level
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    func timeString(time: TimeInterval) -> String {
            let minutes = Int(time) / 60 % 60
            let seconds = Int(time) % 60
            return String(format: "%02d:%02d", minutes, seconds)
        }
   
    var body: some View {
        if let mazeData = searchLevel(level: currentLevel){
            NavigationView{
                VStack {
                    //TIMER
                    ZStack{
                        StrokeText(text: timeString(time: remainingTime), width: 3, color: .black)
                            .font(.system(size: 70, weight: .bold))
                            .padding(.top, 40.0)
                            .foregroundStyle(
                                .linearGradient(
                                    colors: [.yellow, .orange, .red],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                        if showMinus{
                            Text("-20")
                                .fontWeight(.semibold)
                                .foregroundStyle(
                                    .linearGradient(
                                        colors: [.orange, .red],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                .animation(.easeInOut(duration: 0.5))
                                .opacity(showMinus ? 1 : 0)
                                .font(.system(size: 50))
                                .padding(.leading, 300.0)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {withAnimation {showMinus.toggle()}}
                                    
                                }
                        }
                        if showMinushangout{
                            Text("-25")
                                .fontWeight(.semibold)
                                .foregroundStyle(
                                    .linearGradient(
                                        colors: [.orange, .red],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                .animation(.easeInOut(duration: 0.5))
                                .opacity(showMinushangout ? 1 : 0)
                                .font(.system(size: 50))
                                .padding(.leading, 300.0)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {withAnimation {showMinushangout.toggle()}}
                                    
                                }
                        }
                    }
                    StrokeText(text: "-  l e v e l  \(currentLevel) -", width: 2, color: .black)
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(Color.orange)
                        .padding(.bottom, 40.0)
                        .foregroundStyle(
                            .linearGradient(
                                colors: [.yellow, .orange, .red],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                    
                    
                    MazeGridView(gridSize: Int(mazeData.size), walls: mazeData.walls, playerPosition: playerPosition, previousPosition: previousPosition, startPosition: mazeData.startPosition, endPosition: mazeData.endPosition, Games: mazeData.gamesPosition, Hangout: mazeData.hangoutPosition)
                    
                    VStack(alignment: .center) {
                        Spacer()
                        Button(action: {
                            previousPosition = playerPosition
                            playerPosition = controller.movePlayer(currentPosition: playerPosition, walls: mazeData.walls, direction: .up)
                        }, label: {
                            Image("top").resizable()
                                .frame(width: 50.0, height: 50.0)
                        })
                        HStack{
                            Spacer()
                            Button(action: {
                                previousPosition = playerPosition
                                playerPosition = controller.movePlayer(currentPosition: playerPosition, walls: mazeData.walls, direction: .left)
                            }, label: {
                                Image("left").resizable()
                                    .frame(width: 50.0, height: 50.0)
                            })
                            Spacer()
                            Button(action: {
                                previousPosition = playerPosition
                                playerPosition = controller.movePlayer(currentPosition: playerPosition, walls: mazeData.walls, direction: .right)
                            }, label: {
                                Image("right").resizable()
                                    .frame(width: 50.0, height: 50.0)
                            })
                            
                            Spacer()
                        }
                        
                        
                        Button(action: {
                            previousPosition = playerPosition
                            playerPosition = controller.movePlayer(currentPosition: playerPosition, walls: mazeData.walls, direction: .down)
                        }, label: {
                            Image("down").resizable()
                                .frame(width: 50.0, height: 50.0)
                        })
                        
                        
                    }.padding(.top, 50.0)
                    
                    NavigationLink("", destination: gameOverView(), isActive: $showAlert)
                    NavigationLink("", destination: nextLevelView(), isActive: $nextLevel)
                }.background(Image("bgGames"))
            }.navigationViewStyle(StackNavigationViewStyle())
                .navigationBarBackButtonHidden(true)
                .onReceive(timer) { _ in
                    if playerPosition == mazeData.gamesPosition{
                        remainingTime -= 20
                        playerPosition = previousPosition
                        showMinus = true
                    }
                    if playerPosition == mazeData.hangoutPosition{
                        remainingTime -= 25
                        playerPosition = previousPosition
                        showMinushangout = true
                    }
                    if playerPosition == mazeData.endPosition{
                        nextLevel = true
                        currentLevel += 1
                        playerPosition = mazeData.startPosition
                        previousPosition = mazeData.startPosition
                        UserDefaults.standard.set(currentLevel, forKey: "Level")
                    }
                    
                    if remainingTime > 0 {
                        remainingTime -= 1
                    }
                    else {
                        if nextLevel == false{
                            timer.upstream.connect().cancel()
                            showAlert = true // Show the "Game Over" message
                        }
                        
                    }
                    
                }
        }
        else
        {
            finishGameView()
        }
    }
}

struct MazeGridView: View {
    let gridSize: Int
    let walls: [[Bool]]
    let playerPosition: GridPosition
    let previousPosition: GridPosition
    let startPosition: GridPosition
    let endPosition: GridPosition
    let Games: GridPosition
    let Hangout: GridPosition
    var currentLevel: Int = UserDefaults.standard.integer(forKey: "Level")
//    var currentLevel: Int = 10
    
    var body: some View {
        if let mazeData = searchLevel(level: currentLevel){
            VStack {
                ForEach(0..<Int(mazeData.size)) { row in
                    HStack {
                        ForEach(0..<Int(mazeData.size)) { column in
                            let position = GridPosition(x: column, y: row)
                            let isWall = mazeData.walls[row][column]
                            let isPlayer = playerPosition == position
                            let wasPlayer = previousPosition == position
                            let isStart = mazeData.startPosition == position
                            let isEnd = mazeData.endPosition == position
                            let isGames = mazeData.gamesPosition == position
                            let isHangout = mazeData.hangoutPosition == position
                            
                            MazeGridViewCell(isWall: isWall, isPlayer: isPlayer, wasPlayer: wasPlayer, isStart: isStart, isEnd: isEnd, isGames: isGames, isHangout: isHangout)
                                .padding(.all, -5.0)
                                .frame(width: mazeData.width, height: mazeData.width)
                        }
                    }
                }
            }
        }
        else
        {
            finishGameView()
        }
    }
}

struct MazeGridViewCell: View {
    @State var gender: String = UserDefaults.standard.string(forKey: "Gender") ?? "girl"
    let isWall: Bool
    let isPlayer: Bool
    let wasPlayer: Bool
    let isStart: Bool
    let isEnd: Bool
    let isGames: Bool
    let isHangout: Bool
    
    var body: some View {
        ZStack {
            if isWall {
                Image("white").resizable()
            } else if isPlayer {
                Image("\(gender)").resizable()
            }else if isEnd {
                Image("study").resizable()
            } else if isGames {
                Image("games").resizable()
            } else if isHangout {
                Image("hangout").resizable()
            } else {
                Image("black").resizable()
            }
        }
    }
}

struct GridPosition: Equatable {
    var x: Int
    var y: Int
}

enum MazeGameDirection {
    case up, down, left, right
}

class MazeGameController {
    func movePlayer(currentPosition: GridPosition, walls: [[Bool]], direction: MazeGameDirection) -> GridPosition {
        var newPosition = currentPosition
        
        switch direction {
        case .up:
            if currentPosition.y > 0 && !walls[currentPosition.y-1][currentPosition.x] {
                newPosition.y -= 1
            }
        case .down:
            if currentPosition.y < walls.count - 1 && !walls[currentPosition.y+1][currentPosition.x] {
                newPosition.y += 1
            }
        case .left:
            if currentPosition.x > 0 && !walls[currentPosition.y][currentPosition.x-1] {
                newPosition.x -= 1
            }
        case .right:
            if currentPosition.x < walls[0].count - 1 && !walls[currentPosition.y][currentPosition.x+1] {
                newPosition.x += 1
            }
        }
        
        return newPosition
    }
    
}
//LEVELING
struct MazeData {
    let startPosition: GridPosition
    let endPosition: GridPosition
    let gamesPosition: GridPosition
    let hangoutPosition: GridPosition
    let width: CGFloat
    let size: CGFloat
    let walls: [[Bool]]
    let remainingTime:TimeInterval
}
func searchLevel(level: Int) -> MazeData? {
    let startPosition: GridPosition
    let endPosition: GridPosition
    let gamesPosition: GridPosition
    let hangoutPosition: GridPosition
    let width: CGFloat
    let size: CGFloat
    let walls: [[Bool]]
    let remainingTime:TimeInterval
    
    if level == 1 {
        walls = [
            [true, true, true, false, true, true, true, true, true, true, true, true, true, true, true, true],
            [true, false, false, false, false, false, false, false, false, false, false, true, false, false, false, false],
            [true, true, true, true, true, true, true, true, true, true, false, true, false, false, false, true],
            [true, false, false, false, false, false, false, false, false, true, false, false, false, false, false, true],
            [true, false, false, false, false, false, false, false, false, true, true, true, true, false, false, true],
            [true, true, true, true, true, true, false, false, false, false, false, false, true, false, false, true],
            [true, false, false, false, false, true, false, false, true, true, true, true, true, false, false, true],
            [true, false, false, false, false, true, false, false, true, false, false, false, false, false, false, true],
            [true, true, true, false, false, true, false, false, true, false, true, true, true, true, true, true],
            [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, true],
            [true, false, false, true, true, false, false, false, false, false, true, false, false, true, false, true],
            [true, false, false, true, false, false, false, false, false, false, true, false, false, true, false, true],
            [true, false, true, true, true, true, true, true, true, true, true, false, true, true, false, true],
            [true, false, false, false, false, true, false, false, false, false, false, false, true, false, false, true],
            [true, false, false, false, false, true, false, false, false, true, true, true, true, false, false, true],
            [true, true, true, true, true, true, false, true, true, true, true, true, true, true, true, true]]
        startPosition = GridPosition(x: 3, y: 0)
        endPosition = GridPosition(x: 6, y: 15)
        gamesPosition = GridPosition(x: 0, y: 9)
        hangoutPosition = GridPosition(x: 15, y: 1)
        width = 34
        size = 16
        remainingTime = 200
        
        return MazeData(startPosition: startPosition, endPosition: endPosition, gamesPosition: gamesPosition, hangoutPosition: hangoutPosition,width: width, size: size, walls: walls, remainingTime: TimeInterval(remainingTime))
    }else if level == 2 {
        walls = [
            [true, true, true, false, true, true, true, false, false, false, false, true, true, true, true, true],
            [true, false, false, false, false, false, true, false, true, true, false, true, false, false, false, true],
            [true, false, true, true, true, false, true, false, false, true, false, false, false, true, false, true],
            [true, false, true, false, false, false, true, true, true, true, false, true, true, true, false, true],
            [true, true, true, false, true, false, false, true, false, false, false, false, false, false, false, true],
            [true, false, false, false, true, false, false, false, false, false, false, true, true, true, false, true],
            [true, false, true, true, true, true, true, true, true, true, false, true, false, true, false, true],
            [true, false, true, false, false, false, false, false, false, true, false, true, false, false, false, true],
            [true, false, true, true, true, true, true, true, false, true, false, true, true, true, true, true],
            [true, false, false, false, false, false, false, true, false, false, false, false, false, false, false, true],
            [true, false, true, true, true, true, false, true, true, true, false, false, true, true, true, true],
            [true, false, false, false, false, true, false, false, false, true, false, false, false, false, false, true],
            [true, false, true, false, false, true, true, true, false, true, false, true, false, true, true, true],
            [true, false, true, false, false, false, false, true, false, true, true, false, true, true, false, true],
            [false, false, true, false, true, false, false, true, false, true, false, true, false, false, false, true],
            [true, true, true, true, true, true, true, true, false, true, true, true, true, true, true, true]]
        startPosition = GridPosition(x: 3, y: 0)
        endPosition = GridPosition(x: 8, y: 15)
        gamesPosition = GridPosition(x: 8, y: 0)
        hangoutPosition = GridPosition(x: 0, y: 14)
        width = 34
        size = 16
        remainingTime = 200
        
        return MazeData(startPosition: startPosition, endPosition: endPosition, gamesPosition: gamesPosition, hangoutPosition: hangoutPosition,width: width, size: size, walls: walls, remainingTime: TimeInterval(remainingTime))
    }else if level == 3 {
        walls = [
            [true, true, true, false, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true],
            [true, false, true, false, false, false, false, false, false, false, false, false, true, false, false, true, true, false, false, false, false],
            [true, false, true, false, false, true, false, false, false, false, true, false, true, false, false, true, false, false, false, true, true],
            [true, false, true, true, false, true, true, false, true, true, true, false, true, false, false, false, false, true, false, false, true],
            [true, false, false, true, false, false, true, true, true, false, false, false, false, false, false, true, false, true, true, true, true],
            [true, false, false, true, false, false, false, false, true, false, false, false, false, true, false, true, false, false, true, false, true],
            [true, false, true, true, true, true, true, false, true, true, false, true, true, true, true, true, true, true, true, false, true],
            [true, false, true, false, false, false, false, false, false, true, false, true, false, false, false, false, true, false, false, false, true],
            [true, false, true, false, true, true, true, true, false, true, false, true, false, false, true, false, true, false, false, false, true],
            [true, false, true, false, false, false, false, true, false, true, true, true, false, false, true, false, true, true, true, false, false],
            [true, false, true, false, false, false, false, true, false, false, false, false, false, false, true, false, false, false, false, false, true],
            [true, false, true, false, false, false, false, true, true, true, true, false, true, true, true, false, false, true, true, true, true],
            [true, false, true, true, true, false, false, false, false, false, false, false, false, false, false, false, false, true, false, false, true],
            [true, false, false, false, false, false, true, false, true, true, true, false, true, true, true, true, false, false, false, false, true],
            [true, true, true, true, false, false, true, false, true, false, true, false, true, false, false, true, true, true, true, true, true],
            [true, false, false, false, false, false, true, false, true, false, true, false, true, false, false, false, true, false, false, false, true],
            [true, false, true, true, true, false, true, false, true, false, false, false, false, false, true, false, true, false, false, false, true],
            [true, false, true, false, false, false, false, false, true, false, false, false, false, false, true, false, true, false, false, false, true],
            [true, false, true, true, true, true, false, false, false, false, true, true, true, false, true, true, true, false, true, false, true],
            [false, false, false, false, false, false, false, false, false, false, false, false, true, false, false, false, false, false, true, false, true],
            [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true]]
        startPosition = GridPosition(x: 3, y: 0)
        endPosition = GridPosition(x: 20, y: 1)
        gamesPosition = GridPosition(x: 0, y: 19)
        hangoutPosition = GridPosition(x: 20, y: 9)
        width = 24
        size = 21
        remainingTime = 200
        
        return MazeData(startPosition: startPosition, endPosition: endPosition, gamesPosition: gamesPosition, hangoutPosition: hangoutPosition,width: width, size: size, walls: walls, remainingTime: TimeInterval(remainingTime))
    }else if level == 4 {
        walls = [
            [true, true, true, false, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true],
            [true, false, false, false, true, false, false, false, false, true, false, true, false, false, true, true, true, true, false, false, true, false, true],
            [true, false, false, false, false, false, false, false, false, false, false, true, false, false, false, false, false, false, false, false, true, false, true],
            [true, true, true, true, false, true, false, true, true, true, true, true, false, false, true, true, true, false, true, false, true, false, true],
            [true, false, false, false, false, true, false, true, false, false, true, false, false, false, true, false, false, false, true, false, false, false, true],
            [true, false, true, true, true, true, false, true, false, false, true, false, true, true, true, false, true, true, true, true, true, true, true],
            [true, false, false, false, true, false, false, false, false, false, true, false, false, false, true, false, true, false, false, false, false, false, true],
            [true, false, false, false, true, false, false, false, true, true, true, true, true, false, true, false, false, false, true, false, true, false, true],
            [true, false, false, false, true, true, true, false, false, false, false, false, false, false, true, false, false, false, true, false, true, false, true],
            [true, true, true, false, false, false, true, false, true, true, true, true, true, true, true, true, true, true, true, false, true, true, true],
            [true, false, true, false, false, false, true, false, false, false, false, true, false, false, false, false, false, false, false, false, true, false, false],
            [true, false, true, true, true, true, true, true, true, true, false, true, false, true, true, true, true, true, true, true, true, false, true],
            [false, false, false, false, false, false, false, false, false, true, false, true, false, false, false, false, false, true, false, false, false, false, true],
            [false, false, false, false, false, false, false, false, false, true, false, true, true, true, true, true, false, true, false, true, true, true, true],
            [true, true, true, true, true, false, false, true, false, false, false, true, false, false, false, true, false, false, false, true, false, false, true],
            [true, false, true, false, false, false, true, true, true, true, true, true, false, true, true, true, true, true, true, true, false, false, true],
            [true, false, true, false, false, true, true, false, false, false, false, true, false, false, true, false, false, true, false, false, false, true, true],
            [true, false, false, false, false, false, true, false, false, false, false, true, false, false, false, false, false, true, false, false, false, false, true],
            [true, false, true, true, true, true, true, false, true, false, true, true, true, true, false, true, false, true, true, true, true, false, true],
            [true, false, false, false, true, false, false, false, true, false, false, false, false, true, false, true, false, false, false, false, false, false, true],
            [true, false, true, false, true, false, true, true, true, true, true, false, false, true, false, true, false, true, true, true, true, true, true],
            [true, false, true, false, false, false, true, false, false, false, false, false, false, false, false, true, false, false, false, false, false, false, true],
            [true, true, true, true, true, true, true, true, false, true, true, true, true, true, true, true, true, true, true, true, true, true, true]]
        startPosition = GridPosition(x: 3, y: 0)
        endPosition = GridPosition(x: 22, y: 10)
        gamesPosition = GridPosition(x: 0, y: 13)
        hangoutPosition = GridPosition(x: 8, y: 22)
        width = 21
        size = 23
        remainingTime = 200
        
        return MazeData(startPosition: startPosition, endPosition: endPosition, gamesPosition: gamesPosition, hangoutPosition: hangoutPosition,width: width, size: size, walls: walls, remainingTime: TimeInterval(remainingTime))
    }else if level == 5{
        walls = [
            [true, true, true, false, true, true, true, true, true, true, true, false, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true],
            [true, false, false, false, false, false, false, false, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, true, false, true],
            [true, false, false, true, true, true, false, false, false, false, true, true, true, true, false, false, false, true, true, true, true, false, false, true, false, false, true, false, true],
            [true, false, false, true, false, false, false, true, false, false, false, false, false, true, false, false, false, false, false, false, true, false, false, true, false, false, true, false, true],
            [true, false, true, true, false, false, true, true, false, true, true, false, false, true, true, true, false, true, true, true, true, true, true, true, true, false, true, false, true],
            [true, false, true, false, false, true, true, false, false, true, false, false, false, false, false, false, false, true, false, false, false, false, false, true, false, false, true, false, true],
            [true, true, true, false, false, false, true, false, false, true, true, true, true, true, false, true, false, false, false, true, false, false, false, true, false, false, true, false, true],
            [true, false, false, false, true, true, true, false, false, true, false, false, false, true, false, true, true, true, true, true, true, false, false, true, true, true, true, false, true],
            [false, false, false, false, true, false, false, false, true, true, false, true, true, true, false, false, true, false, false, false, false, false, true, true, false, false, true, false, true],
            [true, true, true, false, true, false, false, false, false, false, false, true, false, false, false, false, true, false, false, false, false, false, false, true, false, false, false, false, true],
            [true, false, true, false, true, false, true, false, true, false, true, true, true, true, true, true, true, true, false, false, true, true, true, true, false, false, true, false, true],
            [true, false, true, false, true, false, true, false, true, false, true, false, false, false, false, true, false, false, false, false, true, false, false, false, false, false, true, false, true],
            [true, false, true, false, true, true, true, false, true, false, true, true, true, true, false, true, false, false, true, true, true, false, true, true, true, false, true, false, true],
            [true, false, true, false, false, false, true, false, true, false, true, false, false, true, false, true, false, false, true, false, false, false, true, false, false, false, true, false, true],
            [true, false, true, false, false, false, true, false, true, false, true, false, false, true, false, true, false, false, true, false, true, false, true, false, false, false, true, false, true],
            [true, false, true, false, true, false, true, false, true, false, true, false, true, true, false, false, false, false, true, false, true, false, true, false, true, true, true, false, true],
            [true, false, true, false, true, false, true, false, true, false, true, false, false, false, false, true, true, false, true, true, true, true, true, false, true, false, false, false, true],
            [true, false, true, false, true, false, true, false, true, false, true, false, false, false, false, true, false, false, true, true, false, false, false, false, true, false, false, true, true],
            [true, false, true, true, true, false, false, false, true, false, true, true, true, true, true, true, false, false, true, true, false, true, true, true, true, false, false, true, true],
            [true, false, false, false, true, true, true, true, true, false, false, false, true, false, false, true, false, false, true, true, false, false, false, true, false, false, false, true, true],
            [true, false, false, false, false, false, false, false, true, false, false, false, true, false, false, true, false, false, true, true, true, true, false, true, false, false, false, true, false],
            [true, true, true, true, true, true, false, false, true, true, true, true, true, false, false, false, false, false, true, false, false, false, false, true, false, false, true, true, false],
            [true, false, false, false, true, false, false, false, false, false, false, false, false, false, true, true, true, true, true, false, false, true, true, true, false, false, true, true, false],
            [true, false, false, false, true, false, true, true, true, true, true, true, true, true, true, false, false, false, false, false, false, true, false, false, false, false, true, false, false],
            [true, false, true, false, true, false, true, false, false, false, false, true, false, false, true, true, true, true, true, true, false, true, false, true, false, false, true, false, true],
            [true, false, true, false, false, false, true, false, true, true, false, true, false, false, false, false, true, false, false, false, false, true, false, true, false, false, false, false, true],
            [true, false, true, true, true, true, true, false, true, true, false, false, false, true, false, false, true, false, false, false, false, true, false, true, false, true, true, false, true],
            [true, false, false, false, false, false, false, false, true, true, false, false, false, true, false, false, false, false, false, true, true, true, false, true, false, true, false, false, true],
            [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true]]
        
        startPosition = GridPosition(x: 3, y: 0)
        endPosition = GridPosition(x: 28, y: 20)
        gamesPosition = GridPosition(x: 0, y: 8)
        hangoutPosition = GridPosition(x: 11, y: 0)
        width = 15
        size = 29
        remainingTime = 200
        
        return MazeData(startPosition: startPosition, endPosition: endPosition, gamesPosition: gamesPosition, hangoutPosition: hangoutPosition,width: width, size: size, walls: walls, remainingTime: TimeInterval(remainingTime))
    }
   
    
    return nil
}

struct MazeGameView_Previews: PreviewProvider {
    static var previews: some View {
        MazeGameView()
    }
}
