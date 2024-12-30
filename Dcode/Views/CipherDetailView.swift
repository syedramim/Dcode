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
                    Group {
                        TextField("Current String: \(cipherVM.userInput)", text: $cipherVM.userInput)
                        Divider()
                            .frame(minHeight: 5)
                            .background(Color.gray)
                    }
                    .frame(width: 350)
                    .padding(2)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    
                    Group {
                        TextField("Current Shift Value: \(cipherVM.shift)", value: $cipherVM.shift, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                        Divider()
                            .frame(minHeight: 5)
                            .background(Color.gray)
                    }
                    .frame(width: 350)
                    .padding(2)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)

                    Group {
                        TextField("Current String: \(cipherVM.key)", text: $cipherVM.key)
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
                        dismiss()
                    } label: {
                        Text("Save Parameters")
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
