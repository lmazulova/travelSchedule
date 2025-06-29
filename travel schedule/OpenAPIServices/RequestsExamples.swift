import OpenAPIRuntime
import OpenAPIURLSession


func stations() {
    let client = Client(
        serverURL: try! Servers.Server1.url(),
        transport: URLSessionTransport()
    )
    
    let service = NearestStationsService(
        client: client,
        apikey: "d0eeeb52-67fa-48f2-8131-c568596dca7c"
    )
    
    Task {
        do {
            let stations = try await service.getNearestStations(lat: 59.864177, lng: 30.319163, distance: 50)
            print("✅ Success:")
            print(stations)
        } catch {
            print("❌ Error:", error)
        }
    }
}

func routeStations() {
    let client = Client(
        serverURL: try! Servers.Server1.url(),
        transport: URLSessionTransport()
    )
    
    let service = RouteStationsService(
        client: client,
        apikey: "d0eeeb52-67fa-48f2-8131-c568596dca7c"
    )
    
    
    Task {
        do {
            let routeStations = try await service.getRouteStations(uid: "098S_3_2")
            print("✅ Success:")
            print(routeStations)
        } catch {
            print("❌ Error:", error)
        }
    }
}

func searchStations() {
    let client = Client(
        serverURL: try! Servers.Server1.url(),
        transport: URLSessionTransport()
    )
    
    let service = SearchStationsService(
        client: client,
        apikey: "d0eeeb52-67fa-48f2-8131-c568596dca7c"
    )
    
    
    Task {
        do {
            let searchStations = try await service.searchStations(from: "c146", to: "c213")
            print("✅ Success:")
            print(searchStations)
        } catch {
            print("❌ Error:", error)
        }
    }
}

func nearestSettlement() {
    let client = Client(
        serverURL: try! Servers.Server1.url(),
        transport: URLSessionTransport()
    )
    
    let service = NearestSettlementService(
        client: client,
        apikey: "d0eeeb52-67fa-48f2-8131-c568596dca7c"
    )
    
    
    Task {
        do {
            let nearestSettlement = try await service.getNearestSettlement(lat: 59.864177, lng: 30.319163)
            print("✅ Success:")
            print(nearestSettlement)
        } catch {
            print("❌ Error:", error)
        }
    }
}

//func carrierInfo() {
//    let client = Client(
//        serverURL: try! Servers.Server1.url(),
//        transport: URLSessionTransport()
//    )
//    
//    let service = CarrierInfoService(
//        client: client,
//        apikey: "d0eeeb52-67fa-48f2-8131-c568596dca7c"
//    )
//    
//    
//    Task {
//        do {
//            let carrierInfo = try await service.getCarrierInfo(code: "112")
//            print("✅ Success:")
//            print(carrierInfo)
//        } catch {
//            print("❌ Error:", error)
//        }
//    }
//}

func copyright() {
    let client = Client(
        serverURL: try! Servers.Server1.url(),
        transport: URLSessionTransport()
    )
    
    let service = CopyrightService(
        client: client,
        apikey: "d0eeeb52-67fa-48f2-8131-c568596dca7c"
    )
    
    
    Task {
        do {
            let copyright = try await service.getCopyright()
            print("✅ Success:")
            print(copyright)
        } catch {
            print("❌ Error:", error)
        }
    }
}

func stationSchedule() {
    let client = Client(
        serverURL: try! Servers.Server1.url(),
        transport: URLSessionTransport()
    )
    
    let service = StationScheduleService(
        client: client,
        apikey: "d0eeeb52-67fa-48f2-8131-c568596dca7c"
    )
    
    
    Task {
        do {
            let stationSchedule = try await service.getStationSchedule(station: "s9600213")
            print("✅ Success:")
            print(stationSchedule)
        } catch {
            print("❌ Error:", error)
        }
    }
}

//func stationsList() {
//    let client = Client(
//        serverURL: try! Servers.Server1.url(),
//        transport: URLSessionTransport()
//    )
//    
//    let service = StationsListService(
//        client: client,
//        apikey: "d0eeeb52-67fa-48f2-8131-c568596dca7c"
//    )
//    
//    
//    Task {
//        do {
//            let stationsList = try await service.getStationsList()
//            print("✅ Success:")
//            print(stationsList)
//        } catch {
//            print("❌ Error:", error)
//        }
//    }
//}
