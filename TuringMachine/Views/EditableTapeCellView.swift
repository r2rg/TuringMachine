//
//  EditableTapeCellView.swift
//  TuringMachine
//
//  Created by Артур Галустян on 15.02.2025.
//

import SwiftUI

struct EditableTapeCell: View {
    let index: Int
    @Binding var cellValue: String

    @State private var text: String = ""
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        TextField("", text: $cellValue)
        .textFieldStyle(PlainTextFieldStyle())
        .frame(width: 65, height: 40)
        .multilineTextAlignment(.center)
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(colorScheme == .dark ? Color.white : Color.black, lineWidth: 2)
        }
        .background(colorScheme == .dark ? Color.black : Color.white)
    }
}


