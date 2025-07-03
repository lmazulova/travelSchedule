import SwiftUI

@main
struct travel_scheduleApp: App {
    private let tabItemSize: Double = 30
    @State var path1 = NavigationPath()
    @State var path2 = NavigationPath()
    @StateObject private var themeManager = ThemeManager()
    @StateObject var viewedStories = ViewedStoriesStore()
    @StateObject var mainViewModel = MainViewModel()
    
    private func setupAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.shadowColor = themeManager.isDarkMode ? .black : .customGray
        tabBarAppearance.backgroundColor = UIColor(named: "customWhite")
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        APIKeyStore.shared.saveAPIKey("d0eeeb52-67fa-48f2-8131-c568596dca7c") //заменить на свой ключ API при запуске
    }
    
    var body: some Scene {
        
        WindowGroup {
            TabView {
                ZStack {
                    NavigationStack(path: $path1) {
                        MainView(path: $path1, viewModel: mainViewModel)
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
            .environmentObject(viewedStories)
            .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
            .onAppear {
                setupAppearance()
            }
            .task {
                await mainViewModel.loadSettlements()
            }
        }
    }
}


extension UIApplication {
    func hideKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
