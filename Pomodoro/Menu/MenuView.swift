//
//  MenuView.swift
//  pomodoro
//
//  Created by Max Z on 30/11/21.
//

import SwiftUI

struct MenuView: View {
    // Slide animation
    @Namespace var animation
    // Current tab
    @State var currentTab = "Uploads"
    
    // timer
    @State var isTimerRunning = false
    @State private var startTime =  Date()
    @State private var timerString = "0.00"
    @State private var timer = Timer.publish(every: -1, on: .main, in: .common).autoconnect()

    
    var body: some View {
        VStack{
//            HStack{
//                TabButton(title: "Help", currentTab: $currentTab, animation: animation)
//                TabButton(title: "Start", currentTab: $currentTab, animation: animation)
//            }
//            .padding(.horizontal)
//            .padding(.top)
            Spacer()
            Text(self.timerString)
                .font(.system(size:60))
                .fontWeight(.bold)
                .onReceive(timer) { _ in
                    if self.isTimerRunning {
                        timerString = String(format: "%.2f", (Date().timeIntervalSince( self.startTime)))
                    }
                }
                .onTapGesture {
                    if isTimerRunning {
                        // stop UI updates
                        self.stopTimer()
                    } else {
                        timerString = "0.00"
                        startTime = Date()
                        // start UI updates
                        self.startTimer()
                    }
                    isTimerRunning.toggle()
                }
                .onAppear() {
                    // no need for UI updates at startup
                    self.stopTimer()
                }
            
//            Image("bb_sloth")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .padding()
            
//            Button("Start") {
//
//            }
            
            Spacer(minLength: 15)
//            Divider()
//                .padding(.top, 2)
//
            HStack{

                Image("pengy")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)

                Text("Pomodoro")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)

                Spacer(minLength: 0)
                
                if isTimerRunning {
                    Button(action: {
                        self.stopTimer()
                        isTimerRunning.toggle()
                        
                    }, label: {
                        Image(systemName: "pause")
                            .foregroundColor(.primary)
                    })
                        .buttonStyle(PlainButtonStyle())
                } else {
                    Button(action: {
                        self.startTimer()
                        isTimerRunning.toggle()
                    }, label: {
                        Image(systemName: "play")
                            .foregroundColor(.primary)
                    })
                        .buttonStyle(PlainButtonStyle())
                }
                
                Button(action: {}, label: {
                    Image(systemName: "forward")
                        .foregroundColor(.primary)
                })
                    .buttonStyle(PlainButtonStyle())
                Button(action: {}, label: {
                    Image(systemName: "gear")
                        .foregroundColor(.primary)
                })
                    .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .frame(width: 250, height: 300)
    }
    func stopTimer() {
            self.timer.upstream.connect().cancel()
        }
        
    func startTimer() {
        self.timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

struct TabButton: View {
    var title: String
    @Binding var currentTab: String
    var animation: Namespace.ID
    
    var body: some View {
        Button(action:{
            withAnimation{
                currentTab = title
            }
        }, label: {
            Text(title)
                .font(.callout)
                .fontWeight(.bold)
                // Dark mode adoption
                .foregroundColor(currentTab == title ? .white : .primary)
                .frame(maxWidth: .infinity)
                .background(
                    ZStack{
                        if currentTab == title {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.blue)
                                .matchedGeometryEffect(id: "TAB", in: animation)
                        } else {
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color .primary, lineWidth: 0.6)
                        }
                    }
                )
//                .contentShape(RoundedRectangle
//                              (cornerRadius: 4))
            })
            .buttonStyle(PlainButtonStyle())
    }
}
