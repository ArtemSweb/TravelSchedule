//
//  Untitled.swift
//  TravelSchedule
//
//  Created by Артем Солодовников on 04.06.2025.
//

// 1. Импортируем библиотеки:
import OpenAPIRuntime
import OpenAPIURLSession

// 2. Улучшаем читаемость кода — необязательный шаг
// Создаём псевдоним (typealias) для сгенерированного типа Stations.
// Полное имя Components.Schemas.Stations соответствует пути в openapi.yaml:
// components → schemas → Stations
typealias NearestStations = Components.Schemas.Stations

// Определяем протокол для нашего сервиса (хорошая практика для тестирования и гибкости)
protocol NearestStationsServiceProtocol {
  // Функция для получения станций, асинхронная и может выбросить ошибку
  func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations
}

// Конкретная реализация сервиса
final class NearestStationsService: NearestStationsServiceProtocol {
  // Хранит экземпляр сгенерированного клиента
  private let client: Client
  
  init(client: Client) {
    self.client = client
  }
  
  func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations {
    // Вызываем функцию getNearestStations на ЭКЗЕМПЛЯРЕ сгенерированного клиента.
    // Имя функции и параметры 'query' напрямую соответствуют операции
    // 'getNearestStations' и её параметрам в openapi.yaml
    let response = try await client.getNearestStations(query: .init(
        lat: lat,           // Передаём широту
        lng: lng,           // Передаём долготу
        distance: distance  // Передаём дистанцию
    ))
    // response.ok: Доступ к успешному ответу
    // .body: Получаем тело ответа
    // .json: Получаем объект из JSON в ожидаемом типе NearestStations
    return try response.ok.body.json
  }
}
