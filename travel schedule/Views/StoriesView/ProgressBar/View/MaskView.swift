//
//  MaskView.swift
//  travel schedule
//
//  Created by user on 28.06.2025.
//

import SwiftUI

struct MaskView: View {
    let numberOfSections: Int

    var body: some View {
        HStack {
            ForEach(0..<numberOfSections, id: \.self) { _ in
                MaskFragmentView()
            }
        }
    }
}
