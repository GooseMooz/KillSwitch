//
//  BlockAttributes.swift
//  KillSwitch
//
//  Created by GooseMooz on 2024-10-12.
//

import Foundation
import ActivityKit


struct BlockAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var startTime: Date
    }
}

extension BlockAttributes {
    static var preview: BlockAttributes {
        return BlockAttributes()
    }
}
