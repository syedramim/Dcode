//
//  ContentView.swift
//  Dcode
//
//  Created by Kaneis Zontanos on 12/3/24.
//

import SwiftUI

struct CipherView: View {
    @StateObject private var cipherVM = CipherViewModel()
    @State private var isSheetPresented = false
    @State private var isCustomCipherPresented = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Group {
                    TextField(cipherVM.isEncrypt ? "Encrypt: " : "Decrypt: ", text: $cipherVM.userInput)
                    Divider()
                        .frame(minHeight: 5)
                        .background(Color.gray)
                }
                .frame(width: 350)
                .padding(2)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .lineLimit(1)
        
                Button {
                    cipherVM.isEncrypt.toggle()
                } label: {
                    Image(systemName: cipherVM.isEncrypt ? "lock.open" : "lock")
                        .resizable()
                        .frame(width: 75, height: 100)
                        .tint(.black)
                }
                
                
                Spacer()
                
                
                Group {
                    Text(cipherVM.output)
                    
                    Button {
                        cipherVM.userInput = cipherVM.output
                        cipherVM.isEncrypt.toggle()
                    } label: {
                        Image(systemName: "arrow.up.arrow.down.circle")
                    }
                    
                }
                
                Spacer()
                
                Picker("Ciphers", selection: $cipherVM.selectedCipher) {
                    ForEach(CipherType.allCases, id: \.self) { cipher in
                        Text(cipher.rawValue)
                    }
                }
                .pickerStyle(.wheel)
                
                Spacer()
                
                Button {
                    isSheetPresented.toggle()
                } label: {
                    Text("Change Parameters")
                }

                
            }
            .padding()
            .navigationTitle("Dcode")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $isSheetPresented) {
                CipherDetailView(cipherVM: cipherVM)
            }
            .fullScreenCover(isPresented: $isCustomCipherPresented) {
                CreateCipherView(cipherVM: cipherVM)
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Create Cipher") {
                        isCustomCipherPresented = true
                    }
                }
            }
        }
    }
}

#Preview {
    CipherView()
}
