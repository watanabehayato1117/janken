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
    @State private var myWin = "0"
    @State private var myLose = "0"
    // 手を選択できるかを判定する
    @State private var canGame = false
    // ランダム表示に使用する変数
    @State private var counter = 0
    @State private var enemyRandomImage = "gu"
    
    var body: some View {
      
        VStack {
            
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
                Text("相手の勝利数")
                Text(myLose)
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
            /** 文字 */
            Text(text)
                .font(.title)
            
            
            /** 自分の手 */
            
            HStack{
                VStack{
                    Text("自分の勝利数")
                    Text(myWin)

                    if(self.canGame){
                        Button(action:{
                            self.canGame = false
                        }){
                            Text("次へ")
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
            /** ボタン */
            HStack {
                Button(action: {
                    onHandButton(handNum: 0)
                }) {
                    Image("b_gu")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                }.disabled(self.canGame)
                
                Button(action: {
                    onHandButton(handNum: 1)
                }) {
                    Image("b_choki")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                }.disabled(self.canGame)
                
                Button(action: {
                    onHandButton(handNum: 2)
                }) {
                    Image("b_pa")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                }.disabled(self.canGame)
                
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
