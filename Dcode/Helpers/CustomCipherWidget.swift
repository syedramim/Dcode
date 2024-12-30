//
//  CustomCipherWidget.swift
//  Dcode
//
//  Created by Kaneis Zontanos on 12/30/24.
//

import SwiftUI

struct CustomCipherWidget: View {
    @Binding var cipher: Cipher

    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(LinearGradient(
                colors: [Color.gray.opacity(0.1), Color.gray.opacity(0.3)],
                startPoint: .top,
                endPoint: .bottom
            ))
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 200)
            .overlay {
                HStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Parameters")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)

                        Parameters.handleParams(
                            cipher: cipher.cipher,
                            shift: $cipher.shift,
                            key: $cipher.key
                        )
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.black.opacity(0.05))
                        )
                    }
                    .frame(maxWidth: .infinity)

                    Divider()
                        .frame(width: 1)
                        .background(Color.black.opacity(0.3))

                    VStack {
                        Text("Ciphers")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)

                        Picker("Ciphers", selection: $cipher.cipher) {
                            ForEach(CipherType.allCases, id: \.self) { cipher in
                                Text(cipher.rawValue)
                                    .font(.callout)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .pickerStyle(.wheel)
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding()
            }
    }
}

#Preview {
    @Previewable @State var cipherTest = Cipher(cipher: .caesar, shift: 12, key: "key")
    CustomCipherWidget(cipher: $cipherTest)
}

