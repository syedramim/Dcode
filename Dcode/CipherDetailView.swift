//
//  CipherDetailView.swift
//  Dcode
//
//  Created by Kaneis Zontanos on 12/26/24.
//

import SwiftUI

struct CipherDetailView: View {
    @ObservedObject private var cipherVM = CipherViewModel()
    @State var cipherType: CipherType
    
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
                    
                }
            }
            .navigationTitle("Parameters")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    CipherDetailView(cipherType: .caesar)
}
