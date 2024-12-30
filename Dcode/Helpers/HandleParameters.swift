//
//  HandleParameters.swift
//  Dcode
//
//  Created by Kaneis Zontanos on 12/30/24.
//

import Foundation
import SwiftUI

struct Parameters {
    static func handleParams(cipher: CipherType, shift: Binding<Int?>, key: Binding<String?>) -> some View {
        VStack {
            switch cipher {
            case .caesar:
                HStack {
                    Text("Shift: ")
                    TextField("\(shift.wrappedValue ?? 0)", value: shift, format: .number)
                        .keyboardType(.numberPad)
                }
            case .vigenere, .xor:
                HStack {
                    Text("Key: ")
                    TextField("\(key.wrappedValue ?? "key")", text: Binding(
                        get: { key.wrappedValue ?? ""},
                        set: { key.wrappedValue = $0}
                    ))
                }
            case .atbash, .rot13:
                Text("This Cipher Does Not Require Any Parameters")
            }
        }
    }
}
