import Foundation

enum Direction {
    case left, right, stay
}

struct TransitionRule: Identifiable {
    let id = UUID()
    let currentState: String
    let nextState: String
    let readSymbol: String
    let writeSymbol: String
    let direction: Direction
}
