//
//  ContentView.swift
//  Dcode
//
//  Created by Kaneis Zontanos on 12/3/24.
//

import SwiftUI

struct CipherView: View {
    @State private var enrypt: String = ""
    @State private var decrypt: String = ""
    @State private var stateCipher: Bool = true
    @StateObject private var cipherVM = CipherViewModel()
    
    private var stateCipherText: String {
         stateCipher ? "Encrypt" : "Decrypt"
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            Group {
                TextField(stateCipher ? "Encrypt: " : "Decrypt: ", text: $enrypt)
                Divider()
                    .frame(minHeight: 5)
                    .background(Color.gray)
            }
            .frame(width: 350)
            .padding(2)
            
            Spacer()
            /*
            Button {
                stateCipher.toggle()
            } label: {
                Image(systemName: stateCipher ? "lock.open" : "lock")
                    .resizable()
                    .frame(width: 75, height: 100)
                    .tint(.black)
            }*/

            
            Spacer()
        
            
            Text(cipherVM.XORCipher(str: "aGk=", isEncrypt: false, key: "Asgard"))
            
            Spacer()

        }
        .padding()
    }
}

#Preview {
    CipherView()
}
