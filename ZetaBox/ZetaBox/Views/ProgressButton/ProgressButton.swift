//
//  ProgressButton.swift
//  ZetaBox
//
//  Created by Mac on 22/6/2022.
//

import SwiftUI

struct ProgressButton: View {
    
    @Binding var enabled: Bool
    @Binding var recordedTime: Float
    @Binding var isDoneLongPressing: Bool
    
    @State private var isLongPressing: Bool = false
    @State private var timer: Timer?
    @State private var counter: Float = 0.0
    
    var body: some View {
        ZStack {
            Button(action: {
                if(self.isLongPressing){
                    self.isLongPressing.toggle()
                    self.isDoneLongPressing = true
                    self.timer?.invalidate()
                }
                self.recordedTime = self.counter
                self.counter = 0.0
            }, label: {
                // Deciding Button Icon based on its State
                Image(enabled ? (self.isLongPressing ? "mic-blue" : "mic") : "mic_disabled")
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
            })
            .buttonStyle(.plain)
            .simultaneousGesture(LongPressGesture(minimumDuration: 1).onEnded { _ in
                self.handleLongPress()
            }).disabled(!enabled)
        }
        .frame(minWidth: 250, idealWidth: .infinity, maxWidth: .infinity, minHeight: 250, idealHeight: .infinity, maxHeight: .infinity, alignment: .center)
        .background(
            ZStack {
                Circle()
                    .fill(Color("button-background"))
                Circle()
                    .strokeBorder(Color("border"), lineWidth: 5)
                // PROGRESS Animation UI Elements
                if self.isLongPressing {
                    if counter < Constants.MAX_PRESS_DURATION {
                        Circle()
                            .trim(from: 0.0, to: 0.002)
                            .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .butt, lineJoin: .round))
                            .foregroundColor(Color("app-blue"))
                            .rotationEffect(Angle(degrees: 270.0))
                    }
                    Circle()
                        .trim(from: 0.0, to: getCounterTrimmingStep())
                        .stroke(style: StrokeStyle(lineWidth: 5.0, lineCap: .butt, lineJoin: .round))
                        .foregroundColor(Color("app-blue"))
                        .rotationEffect(Angle(degrees: 270.0))
                        .animation(.linear, value: counter)
                    Circle()
                        .trim(from: getCounterTrimmingStep(), to: getCounterTrimmingStep() + 0.001)
                        .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                        .foregroundColor(Color("app-blue"))
                        .rotationEffect(Angle(degrees: 270.0))
                        .animation(.linear, value: counter)
                }
            }
        )
    }
    
    private func getCounterTrimmingStep() -> CGFloat {
        return CGFloat(min(counter/Constants.MAX_PRESS_DURATION, 1.0))
    }
    
    private func handleLongPress() {
        print("long press")
        self.isLongPressing = true
        self.isDoneLongPressing = false
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { timer in
            print("setp")
            if self.counter < Constants.MAX_PRESS_DURATION {
                self.counter += 0.1
            }else {
                self.recordedTime = Constants.MAX_PRESS_DURATION
                self.isDoneLongPressing = true
            }
        })
    }
}
