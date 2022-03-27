//
//  breath.swift
//  Animation
//
//  Created by Mirko Pietro Leone on 24/03/22.
//

import SwiftUI
//import WatchKit


//                  COLOR

private func createcolor ( _ red: Double, _ green: Double, _ blue: Double)-> Color {
    Color(red : red / 255, green: green / 255, blue: blue / 255)
}
private let table : Array = [10, 10, 15 , 10, 9, 15]

private let gradientstart = createcolor(32, 148, 250)
private let gradientend = createcolor (74,202,159)

private let gradientstartHold = createcolor(250, 96, 32)
private let gradientendHold = createcolor (230,168,56)

private let barcolorbase = createcolor(230, 168, 56)
private let barcolor = createcolor(250, 96, 32)

private let barcolorHold = createcolor(250, 96, 32)
private let barcolorholdBase = createcolor(230, 168, 56)

private var coloribarra : Color = Color.blue

private var gradientHold = LinearGradient(gradient: Gradient (colors:[ gradientstartHold , gradientendHold]), startPoint: .bottom, endPoint: .top)

private var gradient = LinearGradient(gradient: Gradient (colors: [gradientstart, gradientend]), startPoint: .bottom, endPoint: .top)
private let maskGradient = LinearGradient(gradient: Gradient (colors: [.black]), startPoint: .bottom, endPoint: .top)

private let gradienteHold = LinearGradient (gradient: Gradient (colors: [barcolorbase, barcolor]), startPoint: .bottom, endPoint: .top)




var NumAction: Int = 0
private let minsize : CGFloat = 30
private let maxsize : CGFloat = 85
private let inhaleTime : Double = 3
private let exhaleTime :Double = 4
private let pauseTime : Double = 0.5
private var i : Int = 0

private let ghostmaxsize : CGFloat = maxsize * 0.93
private let ghoistminsize : CGFloat = maxsize * 0.92
private let backColor = createcolor( 32, 148, 132)
private var gradiente : LinearGradient = gradient
private var action : Array = ["Breathe", "Hold"]
private var se : Bool = false


  struct breath: View {
      //                  TIMER
      let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
          @State private var counter = 0
      let timer1 = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        @State private var counter1 = 0
      let timer2 = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
          @State private var counter2 = 0
      let timer3 = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        @State private var counter3  = 0
      
      
      @State var color: Bool = false
   @State var progress : CGFloat = 0.0
    @State var progress1 : CGFloat = 0.0
    @State private var size = minsize
    
    @State private var inhaling = false
      
      @State private var ghostsize = ghostmaxsize
      @State private var ghostblur : Double = 0
      @State private var ghostopacity : Double = 0
      
      @State private var x : Int = 0
    
    var body: some View {
        NavigationView{
//        background(Color.black)
            ZStack{
            
                Text(action[NumAction])
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)

                .frame( alignment: .center)
                .position(x: 207, y: 310)
                
                
//                  SEMICERCHI
                
            Circle ()
                    .trim(from: 0, to: 0.75)
//                color ? barcolorholdBase :
                    .stroke ( backColor ,style:  StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round, miterLimit: .infinity))
                .frame (width: 200, height: 200)
                .rotationEffect(.degrees(135))
                .opacity(0.5)
                .offset(y:-150)
                
                Spacer()
                
              
                    Circle ()
                        .trim(from: progress1 ,to: progress)
//                color ? barcolorHold :
                        .stroke ( coloribarra,style:  StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round, miterLimit: .infinity))
                            .frame (width: 200, height: 200)
                            .rotationEffect(.degrees(135))
                            .offset(y:-150)

                    Spacer()

                    Group{
                    Petals(size: ghostsize, inhaling: inhaling)
                        .blur(radius: ghostblur)
                        .opacity(ghostopacity)
                        .drawingGroup()
                    Petals (size: size, inhaling: inhaling,isMask: true)
                    Petals (size: size, inhaling: inhaling)
                }
                .rotationEffect(.degrees (inhaling ? 60 : -30))
                .offset(y:-150)

//                    Spacer()
                    
                 
              
                
                
//                ANIMATION
                
                

                }
            .onReceive(timer) { time in


                    if counter == 0  {
                        color = false
                        NumAction = 0
                        withAnimation(.linear(duration: Double(table [1]))){
//                  
                            progress = 0.75
                            i += 1
                            
//                            withAnimation(.linear(duration: inhaleTime).repeatCount((table [i] / Int (inhaleTime))).delay(1)){
//
//                                    inhaling = true
//                                    size = maxsize
//                            }
                        }
                        withAnimation(.linear(duration: inhaleTime).repeatCount((table [i] / Int (inhaleTime))).delay(1)){
                              
                                inhaling = true
                                size = maxsize
                            }

                    }

                counter += 1
                }.onReceive(timer1){time in

                    if counter1 == 10 {
                        color = true
                        NumAction = 1
                        withAnimation(.linear(duration: Double(table[1]))){
                       
                        progress = 0.0
                    inhaling = true

                        }
                    }
                    if counter1 == 20{
                        inhaling = false
                        size = minsize
                        print ("fine")
                    timer1.upstream.connect().cancel()}
                    counter1 += 1

                }.onReceive(timer2){time in

                    if counter2 == 20 {
                        color = false
                        NumAction = 0
                        withAnimation(.linear(duration: Double(table[1]))){
                       
                        progress = 0.75
                         
                            withAnimation(.linear(duration: inhaleTime).repeatCount((table [i] / Int (inhaleTime)))){
                                
                                    inhaling = true
                                    size = maxsize
                            }
                        }
                    }
                    if counter2 == 30{
                        print ("fine")
                    timer2.upstream.connect().cancel()
                        
                    }
                    counter2 += 1
                   
                   
                }
           
                
                }.navigationTitle("breath")
            
    }
        }
  

//    CERCHI INTERNI


private struct Petals : View {

    let size: CGFloat
    let inhaling : Bool
    var isMask =  false
    
    var body: some View {
       
        let gradientsize = inhaling ? size * 2 : size
        let petalGradient = isMask ? maskGradient : gradiente
//        let petalGradientHold = isMask ? maskGradient : gradienteHold
//         var petalGradientFinal =  petalGradientHold
        ZStack{
            ForEach(0..<6){ index in
                petalGradient.mask{
                Circle()
                    .frame(width: size, height: size)
                    .offset(x: inhaling ? size * 0.5 :0)
                    .rotationEffect(.degrees(Double(-60+(60 * index))))
                }
                .blendMode(isMask  ? .normal : .screen) 
         }
        }
        .frame(width: gradientsize, height: gradientsize)
       
        }
      
      }
    


struct timer_Previews: PreviewProvider {
    static var previews: some View {
        breath()
    }
}
            
