//
//  TuringMachineApp.swift
//  TuringMachine
//
//  Created by Артур Галустян on 09.01.2025.
//

import SwiftUI

@main
struct TuringMachineApp: App {
    var body: some Scene {
        WindowGroup {
            let initialTape = Tape(cells: [0: "1", 1: "0", 2: "1", 3: "_", 4: "_"])
            let dummyRules = [
                TransitionRule(currentState: "q0", nextState: "q1", readSymbol: "1", writeSymbol: "0", direction: .right)
            ]
            let dummyMachine = TuringMachine(tape: initialTape, state: "q0", transitionRules: dummyRules)
            let viewModel = TuringMachineViewModel(machine: dummyMachine)
            
            ContentView(viewModel: viewModel)
        }
    }
}
