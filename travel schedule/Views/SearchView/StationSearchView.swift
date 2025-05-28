import SwiftUI

struct StationSearchView: View {
    private let iconSize: Double = 24
    private let rowHeight: Double = 60
    @StateObject var viewModel = MockViewModel()
    
    var body: some View {
        CustomSearchBar(searchText: $viewModel.searchText)
        
        List(viewModel.filteredRailwayStations, id: \.self) { station in
            HStack {
                Text(station)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(Color.customBlack)
                
                Spacer()
                
                Image("arrow")
                    .frame(width: iconSize, height: iconSize)
            }
            .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            .frame(height: rowHeight)
            .listRowSeparator(.hidden)
            .background(Color.customWhite)
        }
        .listStyle(.plain)
    }
}

#Preview {
    StationSearchView()
}

