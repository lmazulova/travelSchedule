//
//  MaskFragmetView.swift
//  travel schedule
//
//  Created by user on 28.06.2025.
//

import SwiftUI

struct MaskFragmentView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: .progressBarCornerRadius)
            .fixedSize(horizontal: false, vertical: true)
            .frame(height: .progressBarHeight)
            .foregroundStyle(.white)
    }
}
