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
    
    private let cellWidth: CGFloat = 17.7
        
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
                    Text(tape[index, default: "_|"])
                        .frame(width: 50, height: 40)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(colorScheme == .dark ? .white : .black, lineWidth: 3)
                        }
                        .background(colorScheme == .dark ? .black : .white)
                        .accessibilityLabel("\(index)")
                }
            }
            .animation(.easeInOut(duration: 0.3), value: headIndex)
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
    TapeView(tape: [0: "1", 1: "0", 2: "1", 3: "_", 4: "_"], headIndex: 0)
}
