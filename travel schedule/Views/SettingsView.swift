import SwiftUI

struct SettingsView: View {
    @State private var isDarkModeEnabled = false
    private var imageSize: Double = 24
    private var stackHeight: Double = 120
    
    var body: some View {
        VStack {
            VStack {
                VStack {
                    Toggle(isOn: $isDarkModeEnabled) {
                        Text("Темная тема")
                            .font(.system(size: 17, weight: .regular))
                    }
                    .tint(.customBlue)
                    .frame(height: stackHeight/2)
                    
                    HStack {
                        Text("Пользовательское соглашение")
                            .font(.system(size: 17, weight: .regular))
                        
                        Spacer()
                        
                        Image("arrow")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: imageSize)
                    }
                    .frame(height: stackHeight/2)
                }
                .frame(height: stackHeight)
                .padding(EdgeInsets(top: 24, leading: 16, bottom: 0, trailing: 16))
            }
            
            Spacer()
            
            VStack {
                Text("Приложение использует API «Яндекс.Расписания»")
                    .font(.system(size: 12, weight: .regular))
                Text("Версия 1.0 (beta)")
                    .font(.system(size: 12, weight: .regular))
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 24, trailing: 16))
        }
    }
}

#Preview {
    SettingsView()
}
