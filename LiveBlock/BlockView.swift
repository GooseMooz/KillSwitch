//
//  BlockView.swift
//  LiveBlockExtension
//
//  Created by GooseMooz on 2024-10-12.
//

import Foundation
import SwiftUI
import WidgetKit

struct BlockView: View {
    let state: BlockAttributes.ContentState
    let formatter = DateFormatter()
    var isDynamicisland: Bool = false
    
    var body: some View {
        ZStack {
            VStack{
                if (!isDynamicisland) {
                    Spacer()
                }
                Image(systemName: "power")
                    .foregroundStyle(!isDynamicisland ? Color.white : Color.green)
                Text(timerInterval: state.startTime...Date(timeInterval: 60 * 60 * 24 * 365 * 5, since: .now),
                        countsDown: false)
                    .foregroundStyle(!isDynamicisland ? Color.white : Color.green)
                    .bold()
                    .multilineTextAlignment(.center)
                if (!isDynamicisland) {
                    Spacer()
                }
            }
        }
        .activityBackgroundTint(Color.black.opacity(0.5))
    }
}

struct BlockView_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            BlockAttributes.preview
                .previewContext(.init(startTime: Date()), viewKind: .content)
                .previewDisplayName("Lock Screen")
            BlockAttributes.preview
                .previewContext(.init(startTime: Date()), viewKind: .dynamicIsland(.compact))
                .previewDisplayName("Dynamic Island View")
        }
    }
}
