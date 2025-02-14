import Foundation
import Combine

class TuringMachineViewModel: ObservableObject {
    @Published private(set) var machine: TuringMachine
    @Published var tapeDisplay: [Int : String] = [:]
    @Published var showingAlert = false
    @Published var running = false
    
    init(machine: TuringMachine) {
        self.machine = machine
        updateTapeDisplay()
    }
    
    func step() async{
        if machine.step() {
            updateTapeDisplay()
        }
        else {
            showingAlert = true
            running = false
            print("Halted, \(machine.state), \(machine.tape)")
        }
    }
    
    func run(speed: UInt64) async { // TODO: Make async so it actually works
        while running {
            await step()
            try? await Task.sleep(nanoseconds: 1_000_000_000 / speed)
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
