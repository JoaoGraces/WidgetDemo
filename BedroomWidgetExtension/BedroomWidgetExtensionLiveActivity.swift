//
//  BedroomWidgetExtensionLiveActivity.swift
//  BedroomWidgetExtension
//
//  Created by Caio Marques on 10/11/23.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct BedroomWidgetExtensionAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct BedroomWidgetExtensionLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: BedroomWidgetExtensionAttributes.self) { context in
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

extension BedroomWidgetExtensionAttributes {
    fileprivate static var preview: BedroomWidgetExtensionAttributes {
        BedroomWidgetExtensionAttributes(name: "World")
    }
}

extension BedroomWidgetExtensionAttributes.ContentState {
    fileprivate static var smiley: BedroomWidgetExtensionAttributes.ContentState {
        BedroomWidgetExtensionAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: BedroomWidgetExtensionAttributes.ContentState {
         BedroomWidgetExtensionAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: BedroomWidgetExtensionAttributes.preview) {
   BedroomWidgetExtensionLiveActivity()
} contentStates: {
    BedroomWidgetExtensionAttributes.ContentState.smiley
    BedroomWidgetExtensionAttributes.ContentState.starEyes
}
