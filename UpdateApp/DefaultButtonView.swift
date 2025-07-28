//
//  DefaultButtonView.swift
//  UpdateApp
//
//  Created by Main on 28.07.2025.
//

import SwiftUI

struct DefaultButtonView: View {
    var title: String
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(title)
        }
    }
}
