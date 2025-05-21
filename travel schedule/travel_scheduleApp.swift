import SwiftUI

@main
struct travel_scheduleApp: App {
    var body: some Scene {
        WindowGroup {
            Text("Checking API...")
                .task {
                    stations()
                    routeStations()
                    searchStations()
                    nearestSettlement()
                    carrierInfo()
                    copyright()
                    stationSchedule()
                    stationsList()
                }
        }
    }
}
