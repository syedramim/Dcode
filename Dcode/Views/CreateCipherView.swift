//
//  CreateCipherView.swift
//  Dcode
//
//  Created by Kaneis Zontanos on 12/30/24.
//

import SwiftUI

struct CreateCipherView: View {
    @ObservedObject var cipherVM: CipherViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [Color.black.opacity(0.7), Color.black.opacity(0.5)], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                
                VStack {
                    ScrollView {
                        LazyVStack {
                            ForEach(cipherVM.customCiphers) { layer in
                                CustomCipherWidget(cipher: Binding(
                                    get: { layer },
                                    set: { cipher in
                                        if let index = cipherVM.customCiphers.firstIndex(where: { $0.id == layer.id }) {
                                            cipherVM.customCiphers[index] = cipher
                                        }
                                    }
                                ))
                            }
                        }
                    }
                    
                    
                    Spacer()
                    
                    Button {
                        let newCipher = Cipher(cipher: .caesar, shift: 13, key: "key")
                        cipherVM.customCiphers.append(newCipher)
                    } label: {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                }
                .padding()
                
            }
            .navigationTitle("Custom Cipher")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    CreateCipherView(cipherVM: CipherViewModel())
}
