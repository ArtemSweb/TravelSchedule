import Foundation

struct Settlement: Identifiable, Hashable, Sendable {
    let id = UUID()
    let title: String
    let stations: [Station]
}
