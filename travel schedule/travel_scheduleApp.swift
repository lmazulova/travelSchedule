import SwiftUI

@main
struct travel_scheduleApp: App {
    private let tabItemSize: Double = 30
    var body: some Scene {
        WindowGroup {
            
            TabView {
                ZStack {
                    MainView()
                }
                .tabItem(){
                    Image("scheduleItem")
                        .frame(width: tabItemSize, height: tabItemSize)
                }
                
                ZStack {
                    SettingsView()
                }
                .tabItem(){
                    Image("settingsItem")
                        .frame(width: tabItemSize, height: tabItemSize)
                }
            }
        }
    }
}
