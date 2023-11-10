//
//  BedroomWidgetExtensionBundle.swift
//  BedroomWidgetExtension
//
//  Created by Caio Marques on 10/11/23.
//

import WidgetKit
import SwiftUI

@main
struct BedroomWidgetExtensionBundle: WidgetBundle {
    var body: some Widget {
        BedroomWidgetExtension()
        BedroomWidgetExtensionLiveActivity()
    }
}
