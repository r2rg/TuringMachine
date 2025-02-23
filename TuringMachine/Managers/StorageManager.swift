//
//  StorageManager.swift
//  TuringMachine
//
//  Created by Артур Галустян on 17.02.2025.
//

import Foundation
import AppKit

class StorageManager {
    
    static let shared = StorageManager()
    
    private init() { }
    
    func saveMachine(_ machine: TuringMachine, to url: URL) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try encoder.encode(machine)
        try data.write(to: url)
    }
    
    func loadMachine(from url: URL) throws -> TuringMachine {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        return try decoder.decode(TuringMachine.self, from: data)
    }
    
    func promptUserForSaveLocation(completion: @escaping (URL?) -> Void) {
        let panel = NSSavePanel()
        panel.title = "Save Turing Machine Program"
        panel.message = "Choose a location to save your program"
        panel.directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        panel.allowedContentTypes = [.json]

        panel.begin { response in
            if response == .OK {
                completion(panel.url)
            } else {
                completion(nil)
            }
        }
    }
    
    func promptUserForLoadLocation(completion: @escaping (URL?) -> Void) {
         let panel = NSOpenPanel()
         panel.title = "Load Turing Machine Program"
         panel.message = "Choose a program file to load"
         panel.allowsMultipleSelection = false
         panel.canChooseDirectories = false
         panel.allowedContentTypes = [.json]
         panel.directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first

         panel.begin { response in
             if response == .OK {
                 completion(panel.url)
             } else {
                 completion(nil)
             }
         }
     }
    
}
