//
//  CipherDetailView.swift
//  Dcode
//
//  Created by Kaneis Zontanos on 12/26/24.
//

import SwiftUI

struct CipherDetailView: View {
    @ObservedObject var cipherVM: CipherViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.white, .gray.opacity(0.2)], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    Spacer()
                    Parameters.handleParams(
                        cipher: cipherVM.selectedCipher,
                        shift: Binding(
                            get: { cipherVM.shift },
                            set: { cipherVM.shift = $0 ?? 0 }
                        ),
                        key: Binding(
                            get: { cipherVM.key },
                            set: { cipherVM.key = $0 ?? "KEY" }
                        )
                    )
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                    .shadow(radius: 2)
                    
                    Button(action: { dismiss() }) {
                        Text("Save Parameters")
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
            }
            .navigationTitle("Parameters")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    CipherDetailView(cipherVM: CipherViewModel())
}

