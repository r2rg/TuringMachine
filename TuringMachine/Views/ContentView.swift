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
            TapeView(
                tape: viewModel.tapeDisplay,
                state: viewModel.machine.state,
                headIndex: viewModel.machine.tape.index,
                onCommit: { index, newValue in
                    viewModel.updateTapeCell(at: index, with: newValue)
                }
            )
            .padding(30)
            
            StateTableView(viewModel: viewModel)
                .aspectRatio(contentMode: .fill)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            HStack {
                Button("Step") {
                    Task{
                        await viewModel.step()
                    }
                }
                .alert("Halted", isPresented: $viewModel.showingAlert) {
                    Button("OK", role: .cancel) { }
                }
                .padding()
                
                Button(!viewModel.running ? "Run" : "Stop") {
                    viewModel.running.toggle()
                    
                    Task {
                        await viewModel.run(speed: 2)
                    }
                }
                .alert("Halted", isPresented: $viewModel.showingAlert) {
                    Button("OK", role: .cancel) { }
                }
                .padding()
            }
        }
        .padding()
    }
}

#Preview {
    let initialTape = Tape(cells: [0: "1", 1: "0", 2: "1", 3: "1", 4: "0"])
    let dummyRules = [
        TransitionRule(currentState: "q0", nextState: "q1", readSymbol: "1", writeSymbol: "0", direction: .right)
    ]
    let dummyMachine = TuringMachine(tape: initialTape, state: "q0", transitionRules: dummyRules)
    let viewModel = TuringMachineViewModel(machine: dummyMachine)
    
    ContentView(viewModel: viewModel)
}
