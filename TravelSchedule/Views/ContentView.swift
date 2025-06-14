//
//  ContentView.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 29.05.2025.
//

import SwiftUI
import OpenAPIURLSession
import OpenAPIRuntime

struct ContentView: View {
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            // Вызываем нашу тестовую функцию при появлении View
//            testFetchStations()
            testGetScheduleBetweenStation()
//            testGetSchedule()
//            testScheduleThread()
//            testNearestStations()
//            testCarrier()
//            testStationsList()
//            testCopyright()
        }
    }
}

#Preview {
    ContentView()
}

//TODO: - Перенести тестовые вызовы в тесты
// тест NearestStationsService
func testFetchStations() {
    // Создаём Task для выполнения асинхронного кода
    Task {
        do {
            // 3. Вызываем метод сервиса
            print("Fetching stations...")
            let response = try await ServiceManager.shared.getNearestStations(
                lat: 56.864177, // Пример координат
                lng: 30.319163, // Пример координат
                distance: 50    // Пример дистанции
            )
            
            // 4. Если всё успешно, печатаем результат в консоль
            print("Successfully fetched stations: \(response.stations?.count ?? 0)")
        } catch {
            // 5. Если произошла ошибка на любом из этапов (создание клиента, вызов сервиса, обработка ответа),
            //    она будет поймана здесь, и мы выведем её в консоль
            print("Error fetching stations: \(error)")
            // В реальном приложении здесь должна быть логика обработки ошибок (показ алерта и т. д.)
        }
    }
}

// тест SearchService
func testGetScheduleBetweenStation() {
    Task {
        do {
            let response = try await ServiceManager.shared.getScheduleBetweenStation(from: "c213", to: "c215")
            print("Test Success: Loaded schedule between stations (\(response.segments?.count ?? 0) segments).")
        } catch {
            print("Беда!")
        }
    }
}

// тест ScheduleService
func testGetSchedule() {
    Task {
        do {
            let response = try await ServiceManager.shared.getScheduleForStation(station: "s9600215")
            print("Test Success: Loaded schedule for station (\(String(describing: response.station?.title))).")
        } catch {
            print("Беда!")
        }
    }
}

// тест ThreadService
func testScheduleThread() {
    Task {
        do {
            let response = try await ServiceManager.shared.getScheduleThread(uid: "ZF-1005_250630_c59268_12") //Анталья, почему бы и нет
            print("Test Success: Loaded schedule thread (\(response.title ?? "Текст"))")
        } catch {
            print("Беда!")
        }
    }
}
//тест NearestSettlementService
func testNearestStations() {
    Task {
        do {
            let response = try await ServiceManager.shared.getNearestSettlement(lat: 59.864177, lng: 30.319163)
            print("Test Success: Loaded nearest stations (\(response.title ?? "Оз"))")
        } catch {
            print("Беда!")
        }
    }
}

//тест CarrierService
func testCarrier() {
    Task {
        do {
            let response = try await ServiceManager.shared.getCarrier(code: "59268")
            print("Test Success: Loaded carrier (\(response))")
        } catch {
            print("Беда!")
        }
    }
}

//тест StationListService
func testStationsList() {
    Task {
        do {
            let response = try await ServiceManager.shared.getStationsList()
            print("Test Success: \(response.countries?.count ?? 0)")
        } catch {
            print("Беда!")
        }
    }
}

//тест CopyrightService
func testCopyright() {
    Task {
        do {
            let response = try await ServiceManager.shared.getCopyright()
            print("Test Success: Loaded copyright info (\(response.copyright?.text ?? "Текст"))")
        } catch {
            print("Беда!")
        }
    }
}





