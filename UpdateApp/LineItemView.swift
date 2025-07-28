//
//  LineItemView.swift
//  UpdateApp
//
//  Created by Main on 28.07.2025.
//

import SwiftUI

struct LineItemView: View {
    var text: String
    var width: CGFloat
    var color: Color?
    
    var body: some View {
        HStack{
            Text(text)
                .foregroundStyle(Color.white)
                .lineLimit(1)
            Spacer()
        }
        .frame(width: width, height: 20)
        .padding(.horizontal, 5)
        .background((color != nil) ? color : Color.sectionBG)
    }
}

