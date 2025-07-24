import Foundation

struct Settlement: Identifiable, Hashable, TitledItem, Sendable {
    let id = UUID()
    let title: String
    let stations: [Station]
}
