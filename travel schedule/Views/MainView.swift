//
//  MainView.swift
//  travel schedule
//
//  Created by user on 23.05.2025.
//

import SwiftUI

struct MainView: View {
    @State var from: String = ""
    @State var to: String = ""
    private var externalViewHeight: Double = 128
    private var internalViewHeight: Double = 96
    private var iconHeight: Double = 24
    private var circleHeight: Double = 36
    var body: some View {
        HStack {
            HStack(spacing: 16) {
                VStack(spacing: 28) {
                    TextField("Откуда", text: $from)
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(.black)
                    TextField("Куда", text: $to)
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(.black)
                }
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 13))
                .frame(height: internalViewHeight)
                .background(Color.white)
                .clipShape(.rect(cornerRadius: 20))
                Button(action: change) {
                    Image("change")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: iconHeight, height: iconHeight)
                        .background(
                            Color.white
                                .frame(width: circleHeight, height: circleHeight)
                                .clipShape(.circle)
                        )
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(16)
        }
        .frame(height: externalViewHeight)
        .background(Color.customBlue)
        .clipShape(.rect(cornerRadius: 20))
        .padding(16)
        
    }
    
    private func change() {
        
    }
}

#Preview {
    MainView()
}
