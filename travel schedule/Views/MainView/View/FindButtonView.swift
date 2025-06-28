//
//  FindButtonView.swift
//  travel schedule
//
//  Created by user on 28.06.2025.
//

import SwiftUI

struct FindButton: View {
    private let buttonHeight: Double = 60
    private let buttonWidth: Double = 150
    
    let action: () -> Void
    var body: some View {
        Button(action: {
            action()
        }) {
            Text("Найти")
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .padding([.leading, .trailing], 47.5)
                .background(Color.customBlue)
                .clipShape(.rect(cornerRadius: 16))
        }
        .frame(width: buttonWidth, height: buttonHeight)
    }
}
