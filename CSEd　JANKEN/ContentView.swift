//
//  ContentView.swift
//  CSEd　JANKEN
//
//  Created by watanabehayato on 2021/12/01.
//
import SwiftUI

struct ContentView: View {
    @State private var playerHand = 0
    @State private var computerHand = 0
    @State private var text = "じゃんけん"
    @State private var NextText = "次へ"
    @State private var myWin = 0
    @State private var myLose = 0
    @State private var Draw = 0
    // 手を選択できるかを判定する
    @State private var canGame = false
    // ランダム表示に使用する変数
    @State private var counter = 0
    @State private var enemyRandomImage = "gu"
    @State private var GameCount = 1
    
    var body: some View {
        
        if(myWin < 2 && myLose < 2){//テストのため、２回
        VStack {
            Text(" \(GameCount)回戦目")
            
            /** 顔 */
            Image("face")
                .resizable()
                .scaledToFit()
            /** 相手の手 */
            
            HStack{
                // 手を選択できる時間はランダム表示をする
                if(!self.canGame){
                    Image(self.enemyRandomImage)
                        .resizable()
                        .scaledToFit()
                        .rotationEffect(Angle(degrees: 180))
                }else{
                    if(computerHand == 0) {
                        Image("gu")
                            .resizable()
                            .scaledToFit()
                            .rotationEffect(Angle(degrees: 180))
                    }else if(computerHand == 1) {
                        Image("choki")
                            .resizable()
                            .scaledToFit()
                            .rotationEffect(Angle(degrees: 180))
                    }else{
                        Image("pa")
                            .resizable()
                            .scaledToFit()
                            .rotationEffect(Angle(degrees: 180))
                    }
                }
                VStack{
                    Text("相手の勝利数: \(myLose)").padding(10)
                }
                }.onAppear(){
                    Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true){timer in
                        self.counter += 1
                        if(self.counter == 1){
                            self.enemyRandomImage = "gu"
                        }else if(self.counter == 2){
                            self.enemyRandomImage = "choki"
                        }else{
                            self.enemyRandomImage = "pa"
                            self.counter = 0
                        }
                    }
            }
            
        //現在の試合の状況をお知らせするテキスト
            Text(text)
             .font(.title)
            
            /** 自分の手 */
            HStack(spacing: 0.0){
                VStack{
                    Text("自分の勝利数 : \(myWin)")
                    

                    if(self.canGame){
                        Button(action:{
                            self.canGame = false
                            text = "じゃんけん"
                        }){
                            Text(NextText)
                        }
                    }
                }
                
                if(playerHand == 0) {
                    Image("gu")
                        .resizable()
                        .scaledToFit()
                } else if(playerHand == 1) {
                    Image("choki")
                        .resizable()
                        .scaledToFit()
                } else if(playerHand == 2) {
                    Image("pa")
                       .resizable()
                       .scaledToFit()
                }
            }
            .padding(.top, 6.0)
            
            /** 一番下のボタン */
            // ボタンを押したら、勝ちをカウントする。
            
            HStack {
            
                Button(action: {//自分のぐーのボタン
                    onHandButton(handNum: 0)
                    
                }) {
                    Image("b_gu")
                        .resizable()
                        .scaledToFit()
                }.disabled(self.canGame)
               
                
                
                Button(action: {//自分のちょきのボタン
                    onHandButton(handNum: 1)
                    
                }) {
                    Image("b_choki")
                        .resizable()
                        .scaledToFit()
                }.disabled(self.canGame)
                
                Button(action: {//自分のパーのボタン
                    onHandButton(handNum: 2)
                   
                }) {
                    
                    Image("b_pa")
                        .resizable()
                        .scaledToFit()
                }.disabled(self.canGame)

            }
           
        }}else{//５回戦の後に表示されるページ------------------------------------
            VStack{
            Text("\(GameCount-1)回戦の結果")
            Text("自分の勝利数 : \(myWin)")
            Text("相手の勝利数 : \(myLose)")
            Text("あいこ : \(Draw)")
            Button(action: {//再戦するボタン
                self.myWin = 0
                self.myLose = 0
                self.Draw = 0
                self.computerHand = 0
                self.GameCount = 1
                self.text = "じゃんけん"
                
                }) {
                    Text("再戦する")
                }
            
            }
        }
    }

func onHandButton(handNum:Int) -> Void{
        if(handNum == 0){
            print("グー")
        }else if(handNum == 1){
            print("チョキ")
        }else{
            print("パー")
        }
        self.playerHand = handNum;
        self.computerHand = chooseComputerHand();
        self.text = determineVictoryOrDefeat(playerHand:self.playerHand, computerHand:self.computerHand)
        if(text == "ぽん……あなたの勝ちです"){
            self.myWin+=1
            self.GameCount+=1
       }else if(text == "ぽん……あなたの負けです"){
           self.myLose+=1
           self.GameCount+=1
       }else{
           self.Draw+=1
           self.GameCount+=1
    }
        
        // 手を選択された場合はゲームをそのまま続けられなくする
        self.canGame = true
    }
}

func chooseComputerHand() -> Int {
    let random = Int.random(in: 0..<3)
    let computerHand = random
    return computerHand
}

 
func determineVictoryOrDefeat(playerHand:Int, computerHand:Int) -> String {
    var result = ""
    var playerHandTemp = playerHand
    playerHandTemp+=1
 
    if (playerHand == computerHand) {
        result = "ぽん……あいこです";
    }
    else if ((playerHand == 2 && computerHand == 0)||(playerHandTemp == computerHand)) {
        result = "ぽん……あなたの勝ちです";
       
            }
    else {
        result = "ぽん……あなたの負けです";
    }
    return result
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
