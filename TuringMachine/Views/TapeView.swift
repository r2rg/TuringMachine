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
    let headIndex: Int
    let visibleRange: Int = 10
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                let minIndex = (tape.keys.min() ?? 0) - visibleRange
                let maxIndex = (tape.keys.max() ?? 0) + visibleRange
                
                ForEach(minIndex...maxIndex, id: \.self) { index in
                    Text(tape[index, default: "_"])
                        .frame(width: 50, height: 40)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(colorScheme == .dark ? .white : .black, lineWidth: 3)
                        }
                        .background(colorScheme == .dark ? .black : .white)
                        .accessibilityLabel("\(index)")
                }
            }
            .frame(width: 510, height: 40)
            .mask {
                LinearGradient(gradient: Gradient(colors: [.clear, .black, .black, .black, .clear]),
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

#Preview {
    TapeView(tape: [1: "1", 2: "0", 3: "1", 4: "_", 5: "_"], headIndex: 2)
}
