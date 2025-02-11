import Foundation
import Combine

class TuringMachineViewModel: ObservableObject {
    @Published private(set) var machine: TuringMachine
    @Published var tapeDisplay: [Int : String] = [:]
    @Published var showingAlert = false
    
    init(machine: TuringMachine) {
        self.machine = machine
        updateTapeDisplay()
    }
    
    func step() {
        if machine.step() {
            updateTapeDisplay()
        }
        else {
            showingAlert = true
            print("Halted, \(machine.state), \(machine.tape)")
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
