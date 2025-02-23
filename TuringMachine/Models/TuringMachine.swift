import Foundation

struct TuringMachine: Codable {
    var tape: Tape
    var state: String
    var transitionRules: [TransitionRule]
    
    mutating func step() -> Bool {
        let currentSymbol = tape.read()
        
        guard let rule = transitionRules.first(where: {
            $0.currentState == state && $0.readSymbol == currentSymbol
        }) else {
            return false
        }
        
        tape.write(rule.writeSymbol)
        state = rule.nextState
        
        switch rule.direction {
        case .left:
            tape.index -= 1
        case .right:
            tape.index += 1
        case .stay:
            break
        }
        
        return true
    }
}
