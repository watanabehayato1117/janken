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
   
    
    var body: some View {
      
        VStack {
            
            /** 顔 */
            Image("face")
                .resizable()
                .scaledToFit()
            
            /** 相手の手 */
            
            HStack{
                
               
                
            if(computerHand == 0) {
                Image("gu")
                    .resizable()
                    .scaledToFit()
                    .rotationEffect(Angle(degrees: 180))
            }
            if(computerHand == 1) {
                Image("choki")
                    .resizable()
                    .scaledToFit()
                    .rotationEffect(Angle(degrees: 180))
            }
            if(computerHand == 2) {
                Image("pa")
                    .resizable()
                    .scaledToFit()
                    .rotationEffect(Angle(degrees: 180))
            }
                
                VStack{
                Text("相手の勝利数")
                Text(myLose)
                    
                    
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
                    print("グー")
                    self.playerHand = 0;
                    self.computerHand = chooseComputerHand();
                    self.text = determineVictoryOrDefeat(playerHand:self.playerHand, computerHand:self.computerHand)
                    
                }) {
                    Image("b_gu")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                }
                Button(action: {
                    print("チョキ")
                    self.playerHand = 1;
                    self.computerHand = chooseComputerHand();
                    self.text = determineVictoryOrDefeat(playerHand:self.playerHand, computerHand:self.computerHand)
                }) {
                    Image("b_choki")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                }
                Button(action: {
                    print("パー")
                    self.playerHand = 2;
                    self.computerHand = chooseComputerHand();
                    self.text = determineVictoryOrDefeat(playerHand:self.playerHand, computerHand:self.computerHand)
                    
                    
                }) {
                    Image("b_pa")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                }
                
            }
            
        }
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
