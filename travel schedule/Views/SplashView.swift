//
//  SplashView.swift
//  travel schedule
//
//  Created by user on 27.05.2025.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        Image("Splash Screen")
            .resizable()
            .scaledToFill() // ⬅️ аналог .fill
            .ignoresSafeArea()
    }
}

#Preview {
    SplashView()
}
