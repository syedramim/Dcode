//
//  ContentView.swift
//  Dcode
//
//  Created by Kaneis Zontanos on 12/3/24.
//

import SwiftUI

struct ContentView: View {
    @State private var enrypt: String = ""
    @State private var decrypt: String = ""
    @State private var stateCipher: Bool = false
    
    private var stateCipherText: String {
         stateCipher ? "Encrypt" : "Decrypt"
    }
    
    var body: some View {
        VStack {
            TextField("Encrypt:", text: $enrypt)
            
            Spacer()
            
            TextField("Decrypt:", text: $decrypt)
            
            Spacer()
            
            Button {
                stateCipher.toggle()
            } label: {
                Text(stateCipherText)
            }
            .buttonStyle(.borderedProminent)

        }
        .padding()
    }
}

#Preview {
    ContentView()
}
