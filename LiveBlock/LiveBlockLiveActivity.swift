//
//  LiveBlockLiveActivity.swift
//  LiveBlock
//
//  Created by GooseMooz on 2024-10-12.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct LiveBlockLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: BlockAttributes.self) { context in
            BlockView(state: context.state)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.center) {
                    BlockView(state: context.state, isDynamicisland: true)
                }
            } compactLeading: {
                Image(systemName: "lock.fill")
                    .foregroundStyle(Color.green)
            } compactTrailing: {
                Image(systemName: "power")
                    .foregroundStyle(Color.green)
            } minimal: {
                Image(systemName: "lock.fill")
                    .foregroundStyle(Color.green)
            }
        }
    }
}

