//
//  WordEWidgetLiveActivity.swift
//  WordEWidget
//
//  Created by Yung Hak Lee on 2/5/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct WordEWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct WordEWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: WordEWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension WordEWidgetAttributes {
    fileprivate static var preview: WordEWidgetAttributes {
        WordEWidgetAttributes(name: "World")
    }
}

extension WordEWidgetAttributes.ContentState {
    fileprivate static var smiley: WordEWidgetAttributes.ContentState {
        WordEWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: WordEWidgetAttributes.ContentState {
         WordEWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: WordEWidgetAttributes.preview) {
   WordEWidgetLiveActivity()
} contentStates: {
    WordEWidgetAttributes.ContentState.smiley
    WordEWidgetAttributes.ContentState.starEyes
}
