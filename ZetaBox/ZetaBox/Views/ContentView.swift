//
//  ContentView.swift
//  ZetaBox
//
//  Created by Mac on 22/6/2022.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var appState = AppStateViewModel()
    @State private var enabled: Bool = false
    @State private var isDoneLongPressing: Bool = false
    @State private var recordedTime: Float = 0.0
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Spacer(minLength: 25)
                HStack(spacing: -25) {
                    ForEach((1...Constants.PARTICIPANTS_START_NUMBER).reversed(), id: \.self) {
                        Image("user\($0)")
                    }
                    if appState.participants > Constants.PARTICIPANTS_START_NUMBER {
                        Text("+\(appState.participants - Constants.PARTICIPANTS_START_NUMBER)")
                            .foregroundColor(.white)
                            .padding()
                            .background(
                                Circle()
                                    .foregroundColor(.gray)
                                    .frame(width: 64, height: 64)
                            )
                    }
                }
                Spacer(minLength: 20)
                HStack {
                    ProgressButton(enabled: self.$enabled, recordedTime: self.$recordedTime, isDoneLongPressing: self.$isDoneLongPressing)
                }.padding(30)
                VStack {
                    VStack {
                        Text("You’ve been taping on the button for: ")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: 300, height: 50, alignment: .center)
                        Text("\(Int(recordedTime)) seconds")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                    }.opacity(isDoneLongPressing ? 1 : 0)
                    Spacer()
                    Toggle("", isOn: $enabled)
                        .tint(Color("app-blue"))
                        .frame(width: 51, height: 31, alignment: .center)
                }
                .frame(width: 300, height: 200)
                Spacer(minLength: 20)
            }
        }
        .preferredColorScheme(.dark)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
