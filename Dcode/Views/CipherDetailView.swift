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
                LinearGradient(colors: [.gray, .blue], startPoint: .bottom, endPoint: .top)
                    .ignoresSafeArea()
                
                VStack {
                    
                    Parameters.handleParams(
                        cipher: cipherVM.selectedCipher,
                        shift: Binding(
                            get: {cipherVM.shift},
                            set: {cipherVM.shift = $0 ?? 0}
                        ),
                        key: Binding(
                            get: {cipherVM.key},
                            set: {cipherVM.key = $0 ?? "KEY"}
                        )
                    )
                    
                    Button {
                        dismiss()
                    } label: {
                        Text("Save Parameter")
                    }
                    .buttonStyle(.borderedProminent)
                    
                }
                
                

            }
            .navigationTitle("Parameters")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    CipherDetailView(cipherVM: CipherViewModel())
}
