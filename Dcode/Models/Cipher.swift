//
//  Cipher.swift
//  Dcode
//
//  Created by Kaneis Zontanos on 12/3/24.
//

import Foundation

struct Cipher: Identifiable {
    let id = UUID()
    var cipher: CipherType
    var shift: Int?
    var key: String?
}
