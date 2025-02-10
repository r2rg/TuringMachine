//
//  StateTableView.swift
//  TuringMachine
//
//  Created by Артур Галустян on 10.02.2025.
//

import SwiftUI

struct StateTableView: View {
    @ObservedObject var viewModel: TuringMachineViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Transition Rules")
                .font(.headline)
            
            List {
                ForEach(viewModel.machine.transitionRules) { rule in
                    HStack {
                        Text("δ( \(rule.currentState), \(rule.readSymbol) )")
                        Spacer()

                        Text("= (\(rule.writeSymbol), \(rule.direction == .left ? "L" : rule.direction == .right ? "R" : "S"), \(rule.nextState))")
                    }
                }
            }
            
            Button("Add Dummy Rule") {
                let newRule = TransitionRule(currentState: "q1",
                                             nextState: "q2",
                                             readSymbol: "_",
                                             writeSymbol: "1",
                                             direction: .right)
                viewModel.addTransition(rule: newRule)
            }
            .padding(.top, 5)
        }
    }
}

#Preview {
    let initialTape = Tape(cells: [0: "1", 1: "0", 2: "1", 3: "_", 4: "_"])
    let dummyRules = [
        TransitionRule(currentState: "q0", nextState: "q1", readSymbol: "1", writeSymbol: "0", direction: .right)
    ]
    let dummyMachine = TuringMachine(tape: initialTape, state: "q0", transitionRules: dummyRules)
    let viewModel = TuringMachineViewModel(machine: dummyMachine)
    
    StateTableView(viewModel: viewModel)
}
