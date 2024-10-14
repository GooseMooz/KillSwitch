//
//  HapticLong.swift
//  KillSwitch
//
//  Created by GooseMooz on 2024-10-07.
//

import Foundation
import UIKit

class HapticLong {
    private var timer: Timer?

    func startProlongedHapticFeedback(duration: TimeInterval = 1.0) {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        feedbackGenerator.prepare()

        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            feedbackGenerator.impactOccurred()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [weak self] in
            self?.stopHapticFeedback()
        }
    }

    func stopHapticFeedback() {
        timer?.invalidate()
        timer = nil
    }
}
