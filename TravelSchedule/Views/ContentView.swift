//
//  ContentView.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 29.05.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var coordinator = NavCoordinator()
    
    var body: some View {
        ZStack {
            Color.whiteApp
                .ignoresSafeArea()
            
            NavigationStack(path: $coordinator.path) {
                TabView {
                    MainView(coordinator: coordinator)
                        .tabItem {
                            Image(.scheduleTab)
                                .renderingMode(.template)
                        }
                    
                    SettingsView()
                        .tabItem {
                            Image(.settingsTab)
                                .renderingMode(.template)
                        }
                }
                .tint(.blackApp)
                .navigationDestination(for: RouteEnum.self) { route in
                    switch route {
                    case .cityPicker(let fromField):
                        CitiesListView(
                            onSettlementSelected: { settlement in
                                if fromField {
                                    coordinator.selectedCityFrom = settlement.title
                                    coordinator.selectedSettlementFrom = settlement
                                } else {
                                    coordinator.selectedCityTo = settlement.title
                                    coordinator.selectedSettlementTo = settlement
                                }
                                coordinator.path.append(RouteEnum.stationPicker(settlement: settlement, fromField: fromField))
                            }
                        )
                    case .stationPicker(let settlement, let fromField):
                        StationListView(
                        viewModel: StationListViewModel(settlement: settlement),
                        onStationSelected: { station in
                            if fromField {
                                coordinator.selectedStationFrom = station.title
                                coordinator.selectedStationFromObject = station
                            } else {
                                coordinator.selectedStationTo = station.title
                                coordinator.selectedStationToObject = station
                            }
                            coordinator.path = NavigationPath()
                        }
                    )
                    case .tickets(let settlementFrom, let stationFrom, let settlementTo, let stationTo):
                        TicketListView(
                            coordinator: coordinator,
                            viewModel: TicketListViewModel(
                                settlementFrom: settlementFrom,
                                stationFrom: stationFrom,
                                settlementTo: settlementTo,
                                stationTo: stationTo
                            )
                        )
                    case .filters:
                        FiltersView(coordinator: coordinator)
                    case .carrierInfo(let ticket):
                        CarrierInfoView(carrier: ticket)
                    }
                }
            }
            .onChange(of: coordinator.path) {
                if coordinator.path.isEmpty {
                    coordinator.timeFilters.removeAll()
                    coordinator.showTransfers = nil
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
//
////TODO: - Перенести тестовые вызовы в тесты
//// тест NearestStationsService
//func testFetchStations() {
//    // Создаём Task для выполнения асинхронного кода
//    Task {
//        do {
//            // 3. Вызываем метод сервиса
//            print("Fetching stations...")
//            let response = try await ServiceManager.shared.getNearestStations(
//                lat: 56.864177, // Пример координат
//                lng: 30.319163, // Пример координат
//                distance: 50    // Пример дистанции
//            )
//            
//            // 4. Если всё успешно, печатаем результат в консоль
//            print("Successfully fetched stations: \(response.stations?.count ?? 0)")
//        } catch {
//            // 5. Если произошла ошибка на любом из этапов (создание клиента, вызов сервиса, обработка ответа),
//            //    она будет поймана здесь, и мы выведем её в консоль
//            print("Error fetching stations: \(error)")
//            // В реальном приложении здесь должна быть логика обработки ошибок (показ алерта и т. д.)
//        }
//    }
//}
//
//// тест SearchService
//func testGetScheduleBetweenStation() {
//    Task {
//        do {
//            let response = try await ServiceManager.shared.getScheduleBetweenStation(from: "c213", to: "c215")
//            print("Test Success: Loaded schedule between stations (\(response.segments?.count ?? 0) segments).")
//        } catch {
//            print("Беда!")
//        }
//    }
//}
//
//// тест ScheduleService
//func testGetSchedule() {
//    Task {
//        do {
//            let response = try await ServiceManager.shared.getScheduleForStation(station: "s9600215")
//            print("Test Success: Loaded schedule for station (\(String(describing: response.station?.title))).")
//        } catch {
//            print("Беда!")
//        }
//    }
//}
//
//// тест ThreadService
//func testScheduleThread() {
//    Task {
//        do {
//            let response = try await ServiceManager.shared.getScheduleThread(uid: "ZF-1005_250630_c59268_12") //Анталья, почему бы и нет
//            print("Test Success: Loaded schedule thread (\(response.title ?? "Текст"))")
//        } catch {
//            print("Беда!")
//        }
//    }
//}
////тест NearestSettlementService
//func testNearestStations() {
//    Task {
//        do {
//            let response = try await ServiceManager.shared.getNearestSettlement(lat: 59.864177, lng: 30.319163)
//            print("Test Success: Loaded nearest stations (\(response.title ?? "Оз"))")
//        } catch {
//            print("Беда!")
//        }
//    }
//}
//
////тест CarrierService
//func testCarrier() {
//    Task {
//        do {
//            let response = try await ServiceManager.shared.getCarrier(code: "59268")
//            print("Test Success: Loaded carrier (\(response))")
//        } catch {
//            print("Беда!")
//        }
//    }
//}
//
////тест StationListService
//func testStationsList() {
//    Task {
//        do {
//            let response = try await ServiceManager.shared.getStationsList()
//            print("Test Success: \(response.countries)")
//        } catch {
//            print("Беда!")
//        }
//    }
//}
//
////тест CopyrightService
//func testCopyright() {
//    Task {
//        do {
//            let response = try await ServiceManager.shared.getCopyright()
//            print("Test Success: Loaded copyright info (\(response.copyright?.text ?? "Текст"))")
//        } catch {
//            print("Беда!")
//        }
//    }
//}





