//
//  ContentView.swift
//  Dcode
//
//  Created by Kaneis Zontanos on 12/3/24.
//

import SwiftUI

struct CipherView: View {
    @State private var isSheetPresented = false
    @StateObject private var cipherVM = CipherViewModel()
    
    
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
                
                
                Spacer()
                
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
                .pickerStyle(.navigationLink)
                
            }
            .onChange(of: cipherVM.selectedCipher) {
                isSheetPresented = true
            }
            .sheet(isPresented: $isSheetPresented) {
                CipherDetailView(cipherType: cipherVM.selectedCipher)
            }
            .padding()
        }
    }
}

#Preview {
    CipherView()
}
