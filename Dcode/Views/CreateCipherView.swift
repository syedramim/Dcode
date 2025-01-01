//
//  CreateCipherView.swift
//  Dcode
//
//  Created by Kaneis Zontanos on 12/30/24.
//

import SwiftUI

struct CreateCipherView: View {
    @ObservedObject var cipherVM: CipherViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [Color.black.opacity(0.7), Color.black.opacity(0.5)], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                
                VStack {
                    ScrollView {
                        LazyVStack {
                            ForEach(cipherVM.customCiphers.indices, id: \.self) { index in
                                CustomCipherWidget(cipher: Binding(
                                    get: { cipherVM.customCiphers[index] },
                                    set: { cipherVM.customCiphers[index] = $0}
                                ))
                            }
                        }
                    }
                    
                    
                    Spacer()
                    
                    Button {
                        let newCipher = Cipher(cipher: .caesar, shift: 13, key: "key")
                        cipherVM.addCustomCipher(cipher: newCipher)
                    } label: {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                }
                .padding()
                
            }
            .navigationTitle("Custom Cipher")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Save Cipher")
                    }

                }
            }
        }
    }
}

#Preview {
    CreateCipherView(cipherVM: CipherViewModel())
}
