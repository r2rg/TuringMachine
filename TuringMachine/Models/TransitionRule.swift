import Foundation

enum Direction: String, CaseIterable, Identifiable, Codable {
    case left, right, stay
    var id: Self { self }
}

struct TransitionRule: Codable, Identifiable {
    var id = UUID()
    let currentState: String
    let nextState: String
    let readSymbol: String
    let writeSymbol: String
    let direction: Direction
}
