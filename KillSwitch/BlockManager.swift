//
//  BlockManager.swift
//  KillSwitch
//
//  Created by GooseMooz on 2024-10-12.
//

import Foundation
import ActivityKit
import SwiftUI

final class BlockManager {
    static let shared = BlockManager()
    var blockUpdateOnce = false
    
    func createBlockRequest(initDate: Date) {
        let startDate = BlockAttributes()
        let initState = BlockAttributes.ContentState(startTime: initDate)
        let blockContent = ActivityContent(state: initState, staleDate: nil)
        
        do {
            _ = try ActivityKit.Activity.request(attributes: startDate, content: blockContent, pushType: nil)
        } catch {
            print("Error creating block: \(error.localizedDescription)")
        }
    }
    
//    func updateBlockActivity() async {
//        guard let activity = currentBlocksArray.last else { return }
//        let updateState = BlockAttributes.ContentState(startTime: activity.)
//        let blockContent = ActivityContent(state: updateState, staleDate: nil)
//        
//        await activity.update(blockContent)
//        
//        blockUpdateOnce = true
//    }
    
    func endBLockActivity() async {
        let updatedState = BlockAttributes.ContentState(startTime: Date())
        guard let foundActivity = Activity<BlockAttributes>.activities.last else { return }
        let blockContent = ActivityContent(state: updatedState, staleDate: nil)
        await foundActivity.end(blockContent, dismissalPolicy: .immediate)
        blockUpdateOnce = false
    }
    
//    func stimulateBlockActivity() {
//        createBlockRequest() 
//        Task {
//            while (true) {
//                try await Task.sleep(for: .seconds(60))
//                await updateBlockActivity()
//            }
//        }
//    }
}
