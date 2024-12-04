//
//  CipherTypes.swift
//  Dcode
//
//  Created by Kaneis Zontanos on 12/3/24.
//

import Foundation

enum CipherType: String {
    case caesar = "Caesar Cipher"
    case atbash = "Atbash Cipher"
    case rot13 = "ROT13 Cipher"
    case vigenere = "Vigenère Cipher"
    case playfair = "Playfair Cipher"
    case affine = "Affine Cipher"
    case substitution = "Substitution Cipher"
    case transposition = "Transposition Cipher"
    case morseCode = "Morse Code"
    case bacons = "Bacon's Cipher"
    case railFence = "Rail Fence Cipher"
    case keyword = "Keyword Cipher"
    case book = "Book Cipher (Running Key Cipher)"
    case xor = "Simple XOR Cipher"
    case base64 = "Base64 Encoding"
}

