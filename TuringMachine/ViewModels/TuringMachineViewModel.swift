import Foundation
import Combine

class TuringMachineViewModel: ObservableObject {
    @Published private(set) var machine: TuringMachine
    @Published var tapeDisplay: [Int : String] = [:]
    
    init(machine: TuringMachine) {
        self.machine = machine
        updateTapeDisplay()
    }
    
    func step() {
        if machine.step() {
            updateTapeDisplay()
        }
        else {
            print("Halted")
        }
    }
    
    func reset(with newTape: Tape, state: String) {
        machine.tape = newTape
        machine.state = state
        updateTapeDisplay()
    }
    
    private func updateTapeDisplay() {
        tapeDisplay = machine.tape.cells
    }
    
    func addTransition(rule: TransitionRule) {
        machine.transitionRules.removeAll {
            $0.currentState == rule.currentState && $0.readSymbol == rule.readSymbol
        }
        machine.transitionRules.append(rule)
    }
}
