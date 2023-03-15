//
//  AppStateViewModel.swift
//  ZetaBox
//
//  Created by Mac on 22/6/2022.
//

import Combine
import Foundation

class AppStateViewModel: ObservableObject {
    
    @Published var participants: Int = Constants.PARTICIPANTS_START_NUMBER
    private var timer: Timer?
    
    init() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true, block: { timer in
            self.participants += 1
            if self.participants == Constants.PARTICIPANTS_LIMIT {
                timer.invalidate()
            }
        })
    }
    
    deinit {
        timer?.invalidate()
    }

}
