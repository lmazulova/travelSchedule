//
//  StationsSelectionSectionView.swift
//  travel schedule
//
//  Created by user on 28.06.2025.
//

import SwiftUI

struct StationsSelectionSection: View {
    // MARK: - UI Constants
    private let internalViewHeight: Double = 96
    private let iconHeight: Double = 24
    private let circleHeight: Double = 36
    
    @Binding var from: DeparturePoint
    @Binding var to: DeparturePoint
    var change: () -> Void
    var onToTap: () -> Void
    var onFromTap: () -> Void
    
    var body: some View {
        HStack {
            HStack(spacing: 16) {
                VStack(spacing: 28) {
                    NavigationLink(value: Destination.from) {
                        Text(from.station.isEmpty ? "Откуда" : "\(from.city) (\(from.station))")
                            .font(.system(size: 17, weight: .regular))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(from.station.isEmpty ? .customGray : .black)
                            .lineLimit(1)
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        onFromTap()
                    })
                    
                    NavigationLink(value: Destination.to) {
                        Text(to.station.isEmpty ? "Куда" : "\(to.city) (\(to.station))")
                            .font(.system(size: 17, weight: .regular))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(to.station.isEmpty ? .customGray : .black)
                            .lineLimit(1)
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        onToTap()
                    })
                }
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 13))
                .frame(maxWidth: .infinity, alignment: .leading)
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
        .background(Color.customBlue)
        .clipShape(.rect(cornerRadius: 20))
    }
}
