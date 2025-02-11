import Foundation

enum Direction: String, CaseIterable, Identifiable {
    case left, right, stay
    var id: Self { self }
}

struct TransitionRule: Identifiable {
    let id = UUID()
    let currentState: String
    let nextState: String
    let readSymbol: String
    let writeSymbol: String
    let direction: Direction
}
