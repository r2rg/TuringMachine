//
//  ContentView.swift
//  TuringMachine
//
//  Created by Артур Галустян on 09.01.2025.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) private var colorScheme
    @ObservedObject var viewModel: TuringMachineViewModel
    
    var body: some View {
        
        VStack {
            TapeView(tape: viewModel.tapeDisplay, headIndex: viewModel.machine.tape.index)
            
            StateTableView(viewModel: viewModel)
            
            Button("Step") {
                viewModel.step()
            }
            .alert("Halted", isPresented: $viewModel.showingAlert) {
                Button("OK", role: .cancel) { }
            }
        }
        .frame(width: 500,
               height: 300)
        .padding()
    }
}

#Preview {
    let initialTape = Tape(cells: [0: "1", 1: "0", 2: "1", 3: "_", 4: "_"])
    let dummyRules = [
        TransitionRule(currentState: "q0", nextState: "q1", readSymbol: "1", writeSymbol: "0", direction: .right)
    ]
    let dummyMachine = TuringMachine(tape: initialTape, state: "q0", transitionRules: dummyRules)
    let viewModel = TuringMachineViewModel(machine: dummyMachine)
    
    ContentView(viewModel: viewModel)
}
