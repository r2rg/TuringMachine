//
//  NewRuleFormView.swift
//  TuringMachine
//
//  Created by Артур Галустян on 11.02.2025.
//


//
//  NewRuleFormView.swift
//  TuringMachine
//
//  Created by Артур Галустян on 11.02.2025.
//

import SwiftUI

struct NewRuleFormView: View {
    @ObservedObject var viewModel: TuringMachineViewModel
    @Environment(\.dismiss) var dismiss
    
    @State var currentState = ""
    @State var nextState = ""
    @State var readSymbol = ""
    @State var writeSymbol = ""
    @State var direction: Direction = .stay
    
    var body: some View {
        VStack {
            Form {
                TextField("Current State", text: $currentState)
                TextField("Next State", text: $nextState)
                TextField("Read Symbol", text: $readSymbol)
                TextField("Write Symbol", text: $writeSymbol)
                Picker("Direction", selection: $direction) {
                    ForEach(Direction.allCases) { dir in
                        Text(dir.rawValue.capitalized)
                    }
                }
            }
            
            Button("Save") {
                let newRule = TransitionRule(currentState: currentState,
                                             nextState: nextState,
                                             readSymbol: readSymbol,
                                             writeSymbol: writeSymbol,
                                             direction: direction)
                
                viewModel.addTransition(rule: newRule)
                dismiss()
            }
            .padding(.top)
        }
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
    
    NewRuleFormView(viewModel: viewModel)
}
