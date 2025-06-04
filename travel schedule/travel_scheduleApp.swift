import SwiftUI

@main
struct travel_scheduleApp: App {
    private let tabItemSize: Double = 30
    @State var path1 = NavigationPath()
    @State var path2 = NavigationPath()
    @StateObject private var themeManager = ThemeManager()
    
    private func setupAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.shadowColor = themeManager.isDarkMode ? .black : .customGray // Используйте .gray вместо .customGray
        tabBarAppearance.backgroundColor = UIColor(named: "customWhite")
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
    
    var body: some Scene {
        
        WindowGroup {
            TabView {
                ZStack {
                    NavigationStack(path: $path1) {
                        MainView(path: $path1)
                    }
                }
                .tabItem(){
                    Image("scheduleItem")
                        .renderingMode(.template)
                        .frame(width: tabItemSize, height: tabItemSize)
                }
                
                ZStack {
                    NavigationStack(path: $path2) {
                        SettingsView(path: $path2)
                    }
                }
                .tabItem(){
                    Image("settingsItem")
                        .renderingMode(.template)
                        .frame(width: tabItemSize, height: tabItemSize)
                }
            }
            .tint(.customBlack)
            .environmentObject(themeManager)
            .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
            .onAppear {
                setupAppearance()
            }
        }
    }
}


extension UIApplication {
    func hideKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
