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
    @State private var showCopiedMessage = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.white, .gray.opacity(0.2)], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Spacer()
                    
                    Group {
                        TextField(cipherVM.isEncrypt ? "Enter text to Encrypt" : "Enter text to Decrypt", text: $cipherVM.userInput)
                            .padding()
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(10)
                            .shadow(radius: 2)
                            .minimumScaleFactor(0.5)
                            
                    }
                    .frame(width: 350)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    
                    Button {
                        cipherVM.isEncrypt.toggle()
                    } label: {
                        Image(systemName: cipherVM.isEncrypt ? "lock.fill" : "lock.open.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.blue)
                    }
                    .padding()
                    
                    Spacer()
                    
                    Group {
                        Text(cipherVM.output)
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 100)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(10)
                            .shadow(radius: 2)
                            .minimumScaleFactor(0.5)
                            .fixedSize(horizontal: false, vertical: true)
                            .onTapGesture {
                                UIPasteboard.general.string = cipherVM.output
                                
                                withAnimation {
                                    showCopiedMessage = true
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    withAnimation {
                                        showCopiedMessage = false
                                    }
                                }
                            }
                        
                        Button {
                            cipherVM.userInput = cipherVM.output
                            cipherVM.isEncrypt.toggle()
                        } label: {
                            Image(systemName: "arrow.triangle.2.circlepath")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer()
                    
                    Picker("Ciphers", selection: $cipherVM.selectedCipher) {
                        ForEach(CipherType.allCases, id: \.self) { cipher in
                            Text(cipher.rawValue)
                        }
                    }
                    .pickerStyle(.wheel)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                    .shadow(radius: 2)
                    .frame(height: 150)
                    
                    Spacer()
                    
                    Button {
                        isSheetPresented.toggle()
                    } label: {
                        Text("Change Parameters")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.opacity(0.8))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 40)
                    
                    Spacer()
                }
                .padding()
                
                if showCopiedMessage {
                    Text("Copied!")
                        .font(.headline)
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .transition(.opacity)
                        .zIndex(1)
                }
            }
            .navigationTitle("Dcode")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $isSheetPresented) {
                CipherDetailView(cipherVM: cipherVM)
            }
        }
    }
}

#Preview {
    CipherView()
}


