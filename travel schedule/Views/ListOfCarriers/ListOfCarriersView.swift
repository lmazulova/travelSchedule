import SwiftUI

struct ListOfCarriersView: View {
    let title: String
    @StateObject var viewModel = MockViewModel()
    
    init(title: String) {
        self.title = title
    }
    var body: some View {
        Text(title)
            .font(.system(size: 24, weight: .bold))
            .padding(16)
        
        List(viewModel.foundRoutes) { service in
            CarrierRow(serviceInfo: service)
                .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 8, trailing: 16))
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

#Preview {
    ListOfCarriersView(title: "Москва (Ярославский вокзал) → Санкт Петербург (Балтийский вокзал)")
}
