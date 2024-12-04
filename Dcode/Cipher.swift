//
//  Cipher.swift
//  Dcode
//
//  Created by Kaneis Zontanos on 12/3/24.
//

import Foundation

struct Cipher: Identifiable {
    let id = UUID()
    var encrypted: String
    var decrypted: String
    var cipher: CipherType
}
