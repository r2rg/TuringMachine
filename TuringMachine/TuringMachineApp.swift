//
//  TuringMachineApp.swift
//  TuringMachine
//
//  Created by Артур Галустян on 09.01.2025.
//

import SwiftUI

@main
struct TuringMachineApp: App {
    @StateObject private var viewModel: TuringMachineViewModel = {
        let initialTape = Tape(cells: [:])
        let dummyRules = [TransitionRule]()
        let dummyMachine = TuringMachine(tape: initialTape, state: "q0", transitionRules: dummyRules)
        return TuringMachineViewModel(machine: dummyMachine)
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
        .commands {
            CommandGroup(replacing: CommandGroupPlacement.saveItem) {
                Button("Save machine") {
                    StorageManager.shared.promptUserForSaveLocation { saveURL in
                        if let url = saveURL {
                            do {
                                try StorageManager.shared.saveMachine(viewModel.machine, to: url)
                                print("Program saved successfully.")
                            } catch {
                                print("Error saving program: \(error)")
                            }
                        }
                    }
                }
                .keyboardShortcut("S", modifiers: [.command])
            }
            
            CommandGroup(after: CommandGroupPlacement.saveItem) {
                Button("Load machine") {
                    StorageManager.shared.promptUserForLoadLocation { fileURL in
                        guard let fileURL = fileURL else {
                            print("User cancelled load.")
                            return
                        }
                        
                        DispatchQueue.global(qos: .userInitiated).async {
                            do {
                                let loadedMachine = try StorageManager.shared.loadMachine(from: fileURL)
                                DispatchQueue.main.async {
                                    viewModel.updateMachine(loadedMachine)
                                    print("Program loaded successfully from \(fileURL.path)")
                                }
                            } catch {
                                DispatchQueue.main.async {
                                    print("Error loading program: \(error)")
                                }
                            }
                        }
                    }
                }
                .keyboardShortcut("O", modifiers: [.command])
            }
        }
    }
}
