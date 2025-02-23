//
//  TapeView.swift
//  TuringMachine
//
//  Created by Артур Галустян on 09.01.2025.
//

import SwiftUI

struct TapeView: View {
    @Environment(\.colorScheme) private var colorScheme
    let tape: [Int : String]
    let state: String
    let headIndex: Int
    let visibleRange: Int = 10
    
    let onCommit: (Int, String) -> Void
    
    private var minIndex: Int {
        (tape.keys.min() ?? 0) - tape.count + 1 + headIndex - visibleRange
    }
        
    private var maxIndex: Int {
        (tape.keys.max() ?? 0) + headIndex + visibleRange
    }
        
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ForEach(minIndex...maxIndex, id: \.self) { index in
                    let binding = Binding<String>(
                        get: { tape[index, default: "_"] },
                        set: { newValue in onCommit(index, newValue) }
                    )
                    EditableTapeCell(
                        index: index,
                        cellValue: binding
                    )
                    .accessibilityLabel("\(index)")
                }
            }
            .animation(.easeInOut(duration: 0.1), value: state)
            .frame(width: 510, height: 40)
            .mask {
                LinearGradient(gradient: Gradient(colors: [.clear, .black, .black, .clear]),
                               startPoint: .leading,
                               endPoint: .trailing)
            }
            .padding(10)
            
            Image(systemName: "triangle.fill")
                .resizable()
                .frame(width: 25, height: 25)
        }
    }
}

