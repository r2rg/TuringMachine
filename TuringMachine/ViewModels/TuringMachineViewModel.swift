import Foundation
import Combine

@MainActor
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
            print("Halted, \(machine.state), \(machine.tape), \n \(tapeDisplay)")
        }
    }
    
    func run(speed: UInt64) async { 
        while running {
            await step()
            try? await Task.sleep(nanoseconds: 1_000_000_000 / speed)
        }
    }
    
    func reset() {
        machine.tape = Tape(cells: [:])
        machine.state = "q0"
        updateTapeDisplay()
    }
    
    private func updateTapeDisplay() {
        tapeDisplay = machine.tape.cells
    }
    
    func updateTapeCell(at index: Int, with newValue: String) {
        if newValue == "_" {
            machine.tape.cells.removeValue(forKey: index)
        }
        else {
            machine.tape.cells[index] = newValue
        }
        
        updateTapeDisplay()
            
    }

    func addTransition(rule: TransitionRule) {
        machine.transitionRules.removeAll {
            $0.currentState == rule.currentState && $0.readSymbol == rule.readSymbol
        }
        machine.transitionRules.append(rule)
    }
    
    func removeTransitionRule(at offsets: IndexSet) {
        var transitionRules = machine.transitionRules
        transitionRules.remove(atOffsets: offsets)
        machine.transitionRules = transitionRules
    }
    
    func updateMachine(_ newMachine: TuringMachine) {
        self.machine = newMachine
        updateTapeDisplay()
    }
    
}
