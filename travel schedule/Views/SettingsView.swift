import SwiftUI

struct SettingsView: View {
    @Binding var path: NavigationPath
    @EnvironmentObject var themeManager: ThemeManager
    
    private var imageSize: Double = 24
    private var stackHeight: Double = 120
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }
    
    var body: some View {
        ZStack {
            Color.customWhite
                .ignoresSafeArea()
            
            VStack {
                VStack {
                    VStack {
                        Toggle(isOn: $themeManager.isDarkMode) {
                            Text("Темная тема")
                                .font(.system(size: 17, weight: .regular))
                                .foregroundStyle(Color.customBlack)
                        }
                        .tint(.customBlue)
                        .frame(height: stackHeight/2)
                        
                        HStack {
                            Text("Пользовательское соглашение")
                                .font(.system(size: 17, weight: .regular))
                                .foregroundStyle(Color.customBlack)
                            
                            Spacer()
                            
                            Image("arrow")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: imageSize)
                        }
                        .frame(height: stackHeight/2)
                        .onTapGesture {
                            path.append("пользовательское соглашение")
                        }
                    }
                    .frame(height: stackHeight)
                    .padding(EdgeInsets(top: 24, leading: 16, bottom: 0, trailing: 16))
                }
                
                Spacer()
                
                VStack {
                    Text("Приложение использует API «Яндекс.Расписания»")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(Color.customBlack)
                    Text("Версия 1.0 (beta)")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(Color.customBlack)
                }
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 24, trailing: 16))
            }
            .navigationDestination(for: String.self) { _ in 
                UserAgreementView(path: $path)
            }
        }
    }
}

#Preview {
    SettingsView(path: .constant(NavigationPath()))
        .environmentObject(ThemeManager())
}

