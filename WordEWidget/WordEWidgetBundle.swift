//
//  WordEWidgetBundle.swift
//  WordEWidget
//
//  Created by Yung Hak Lee on 2/5/25.
//

import WidgetKit
import SwiftUI

@main
struct WordEWidgetBundle: WidgetBundle {
    var body: some Widget {
        WordEWidget()
        WordEWidgetControl()
        WordEWidgetLiveActivity()
    }
}
