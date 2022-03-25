//
//  micro.swift
//  Animation
//
//  Created by Mirko Pietro Leone on 24/03/22.
//

import SwiftUI

var MinSize : CGFloat = 0
var MaxSize : CGFloat = 200
var initx : CGFloat = 0
var inity : CGFloat = 40
var finalx : CGFloat = 414
var finaly : CGFloat = -700


struct micro: View {
    @State var isAnimated:Bool = false
    @State var isAnimated2:Bool = false
    @State var isanimated3:Bool = false
    @State var duration:Double = 0.1
    @State var duration1:Double = 0.4
    @State var duration2: Double = 0.7
    let timer5 = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        @State private var counter5 = 0
    @State var paperIsAnimated:Bool = false
    @State var paperDUration:Double = 1
    
    var body: some View {
        NavigationView{
        ZStack{
            
            Color(UIColor.systemGray6)
            Image("prova")
                .resizable()
                .frame(height: 500)
                .position(x: 207, y: 250)

            Spacer()
//            paper(size1: MinSize, posx: initx, posy: inity)
            
            HStack{
                //            HEART
                
            Button(){
                isAnimated.toggle()
                isAnimated2.toggle()
                
                

            }label: {
                ZStack{
                    Image(systemName: "heart.fill") .resizable()
                      
                        .foregroundColor(isAnimated ? Color.red : Color.white)
                
                Image(systemName: "heart")
                    .resizable()
                    
                    .foregroundColor(isAnimated ? Color.red : Color.black)
                    .animation(.linear(duration: duration), value: isAnimated)
                }
               
                    }
                
            .frame(width: 35, height: 35)
            .position(x: 30, y: 40)
                
                Spacer()
                
                
                Image(systemName: "heart.fill")
                    .resizable()
                    .frame(width: isAnimated2 ? 200 : 0, height: isAnimated2 ? 200 : 0)
                    .position(x: 68, y: -250)
                    .foregroundColor(Color.red)
                    .opacity(isAnimated2 ? 0 : 10)
                    .animation(.linear(duration: duration1), value: isAnimated2)
                    
//                AIRPLANE
           Spacer()
               
                Button{
                    isanimated3.toggle()
//                    withAnimation(.linear(duration: 1)){
//                        MinSize = MaxSize
//                        initx = finalx
//                        inity = finaly
//                        print(initx)
//                        print(MinSize)
//                        if counter5 == 1 {
//                            print("s")
//                        }
//                        counter5 += 1
//                    }
                    
                } label: {
                    ZStack{
//                      PAPER ICON
                    Image(systemName: "paperplane")
                            .resizable()
                            .frame(width: 35, height: 35, alignment: .center)
                            .foregroundColor(Color.black)
                   
                        Image(systemName: "paperplane.fill")
                            .resizable()
                            .foregroundColor(Color.blue)
                            .frame(width: isanimated3 ? MaxSize : MinSize, height: isanimated3 ? MaxSize : MinSize)
                            .position(x:isanimated3 ? finalx : initx, y: isanimated3 ? finaly : inity )
                            .animation(.linear(duration: duration2), value: isanimated3)
                    }
                }.frame(width: 35, height: 34)
                    .position(x: -190, y: 40)
                
               
                }.frame(width: 414, height: 80)
                .position(x: 207, y: 535)
            
//            PAPER ANIMATION
           
        }.foregroundColor(Color.black)
            .navigationTitle("Micro-interactions")
        
        }
    }
}


//struct paper: View {
//    @State var size1 :CGFloat
//    @State var posx : CGFloat
//    @State var posy : CGFloat
//
//    var body: some View{
//        ZStack{
//            Image(systemName: "paperplane")
//
//                .foregroundColor(Color.black)
//
//        } .frame(width: size1 , height: size1)
//            .position(x: posx, y: posy)
//    }
//}
struct micro_Previews: PreviewProvider {
    static var previews: some View {
        micro()
    }
}
