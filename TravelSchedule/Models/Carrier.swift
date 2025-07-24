import Foundation

struct Carrier: Hashable, Sendable {
    let code: String
    let title: String
    let logoSVG: String
    let logoFull: String
    let email: String?
    let phone: String?
}
