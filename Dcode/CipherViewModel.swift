//
//  CipherViewModel.swift
//  Dcode
//
//  Created by Kaneis Zontanos on 12/3/24.
//

import Foundation

/// CipherViewModel handles the logic of Encryption and Decryption 

class CipherViewModel: ObservableObject {
    
    // MARK: - Properties
    
    /// Allows for the user to choose what cipher they want to use
    @Published var selectedCipher: CipherType = .caesar { didSet { performCipher() } }
    
    @Published var userInput: String = "" { didSet { performCipher() } }
    @Published var isEncrypt: Bool = true { didSet { performCipher() } }
    @Published var shift: Int = 13 { didSet { performCipher() } }
    @Published var key: String = "KEY" { didSet { performCipher() } }
    @Published var output: String = "" 
    
    /// Initializes the the CipherViewModel with the necessary parameters for each Cipher Type
    /// - Parameters:
    ///     - selectedCipher: is a CipherType that allows for switching between Ciphers
    ///     - userInput: a String that takes the userInput for the str to be encoded or decoded
    ///     - isEncrypt: a Bool that is used to handle whether or not to encrypt or decrypt the str
    ///     - shift: an Int that is used for specfic ciphers to shift str letters
    ///     - key: a String that is used for specific ciphers to use the letters ASCII vals to shift str letters
    init() {
        performCipher()
    }
    
    // MARK: - Methods
    
    func performCipher() {
        switch selectedCipher {
        case .caesar:
            output = CaesarCipher(str: userInput, isEncrypt: isEncrypt, shift: shift)
        case .atbash:
            output = AtbashCipher(str: userInput)
        case .rot13:
            output = ROT13Cipher(str: userInput)
        case .vigenere:
            output = VigenereCipher(str: userInput, isEncrypt: isEncrypt, key: key)
        case .xor:
            output = XORCipher(str: userInput, isEncrypt: isEncrypt, key: key)
        }
    }
    
    /// Provides an ASCII value if there exists such for the given character
    /// - Parameters:
    ///     - charOfString: a character that is part of the string
    /// - Returns: an Int signifying the ASCII value of the char otherwise -1 if there is no ASCII
    private func getASCIIVal(_ charOfString: Character) -> Int {
        if let asciiVal = charOfString.asciiValue {
            return Int(asciiVal)
        }
        
        return -1
    }
    
    /// Provides the String version of the given ASCII value if there exists such a string
    /// - Parameters:
    ///     - asciiVal: an Int that is supposed to signify an ASCII val
    /// - Returns: an Optional String where it will return a String of a char if there exists an ASCII value for it otherwise nil if there is no possible conversion
    private func getStringFromASCII(_ asciiVal: Int) -> String? {
        if let uniASCII = UnicodeScalar(asciiVal) {
            return String(Character(uniASCII))
        }
        
        return nil
    }
    
    /// Determines whether or not the passed in char is a letter or not
    /// - Parameters:
    ///     - char: a character to evaluate
    /// - Returns: A  Bool value to determine if the passed in character is a letter
    private func isLetter(_ char: Character) -> Bool {
        let val = self.getASCIIVal(char)
        
        return (65 <= val && val <= 90) || (97 <= val && val <= 122)
    }
    
    /// Provides the starting point in ASCII value depending on whether its lowercase or uppercase
    /// - Parameters:
    ///     - char: a character that will determine the start point
    /// - Returns: An int that determines the start point in ASCII value
    private func determineLowerOrUpper(_ char: Character) -> Int {
        return char.isUppercase ? 65 : 97
    }
    
    /// Applies the Caeser Cipher on a provided string
    /// The Function will shift by the provided shift and it will whether encode or decode depending on isEncrypt. The output string is dependant on the input string
    /// - Parameters:
    ///     - str: A String that will be encrypted or decrypted
    ///     - isEncrypt: A Bool that handles if it is an encryption or not, Encryption(true)/Decryption(false)
    ///     - shift: An Int that handles how much to shift the letters by
    /// - Returns: a new String which is either encoded or decoded by the Caeser Cipher
    func CaesarCipher(str: String, isEncrypt: Bool, shift: Int) -> String {
        var stringResult = ""
        
        for s in str {
            if self.isLetter(s) {
                let ascii = self.getASCIIVal(s)
                let mainStart = self.determineLowerOrUpper(s)
                let shiftFactor = isEncrypt ? shift: -shift
                
                // calculates the new position of the letter depending on its ASCII value which is then just brought to normal alphabet positions ranging from 0-25 and then gives its new position according to the shift
                let charChangedPosition = (((ascii - mainStart + shiftFactor) % 26 + 26) % 26) + mainStart
                
                if let appendToString = self.getStringFromASCII(charChangedPosition) {
                    stringResult.append(appendToString)
                } else {
                    continue
                }
            } else {
                stringResult.append(s)
            }
        }
        
        return stringResult
    }
    
    
    /// Applies the Atbash cipher on a provided string
    /// A Function that will map each letter in the alphabet to it's inverse indexed letter; A->Z and Z->A
    /// - Parameters:
    ///     - str: A String that will be encrypted or decrypted
    /// - Returns: a new String which is either encoded or decoded by the Atbash Cipher
    func AtbashCipher(str: String) -> String {
        var stringResult = ""
        
        for s in str {
            if self.isLetter(s) {
                let mainStart = self.determineLowerOrUpper(s)
                let ascii = self.getASCIIVal(s)
                
                // the new positions takes the current position in the alphabet then switches the position by doing 25 - pos and then giving it the ascii value by adding mainstart to it
                let charChangedPosition = (25 - (ascii - mainStart)) + mainStart
                
                if let appendToString = self.getStringFromASCII(charChangedPosition) {
                    stringResult.append(appendToString)
                } else {
                    continue
                }
            } else {
                stringResult.append(s)
            }
        }
        
        return stringResult
    }
    
    /// Applies the ROT13 Cipher on a provided string
    /// A Function that will shift each character by a specfic string which also translates and rotates throgu
    /// - Parameters:
    ///     - str: A String that will be encrypted or decrypted
    /// - Returns: a new String which is either encoded or decoded by the ROT13 Cipher
    func ROT13Cipher(str: String) -> String {
        return self.CaesarCipher(str: str, isEncrypt: true, shift: 13)
    }
    
    /// Applies the Vigenere Cipher on a provided string
    /// A Function that will take a provided string and for each character it will shift it by another character's position which is provided by the key.
    /// The key will be transformed to match the length of the str such that a key of 'KEY' for str 'HELLO' would become 'KEYKE'
    /// - Parameters:
    ///     - str: A String that will be encrypted or decrypted
    ///     - isEncrypt: A Bool that handles if it is an encryption or not, Encryption(true)/Decryption(false)
    ///     - key: A String that will be used to shift each character of str
    /// - Returns: a new String which is either encoded or decoded by the Vigenere Cipher
    func VigenereCipher(str: String, isEncrypt: Bool, key: String) -> String {
        var stringResult = ""
        let keyArray = Array(key)
        var key_index = 0
        
        for s in str {
            if self.isLetter(s) {
                let strStart = self.determineLowerOrUpper(s)
                let strASCII = self.getASCIIVal(s)
                let key_char = keyArray[key_index]
                let keyStart = self.determineLowerOrUpper(key_char)
                let keyASCII = self.getASCIIVal(key_char)
                let keyNormalizedPos = keyASCII - keyStart
                
                let charChangedPosition = (((strASCII - strStart) + (isEncrypt ? keyNormalizedPos : -keyNormalizedPos) + 26) % 26) + strStart
                
                if let appendToString = self.getStringFromASCII(charChangedPosition) {
                    stringResult.append(appendToString)
                } else {
                    continue
                }
                
                key_index = (key_index + 1) % keyArray.count
            } else {
                stringResult.append(s)
            }
        }
        
        return stringResult
    }
    
    /// Applies Base64 Cipher only for the use to make allowing for XOR to show non printable characters
    /// A Function that will use built-in functions to use Base64 encoding and decoding to handle non printable characters
    /// - Parameters:
    ///     - str: A String that will be encrypted or decrypted
    ///     - isEncrypt: A Bool that handles if it is an encryption or not, Encryption(true)/Decryption(false)
    /// - Returns: a new String that will allow for non printable characters to be legible
    private func Base64Cipher(str: String, isEncrypt: Bool) -> String {
        if isEncrypt {
            guard let data = str.data(using: .utf8) else {
                return str
            }
            return data.base64EncodedString()
        } else {
            guard let data = Data(base64Encoded: str) else {
                return str
            }
            return String(data: data, encoding: .utf8) ?? str
        }
    }
    
    /// Applies the XOR Cipher on a provided string
    /// A Function that will take a provided string and for each character it will take the binary value and XOR gate it with another character's binary value.
    /// The key will be transformed to match the length of the str such that a key of 'KEY' for str 'HELLO' would become 'KEYKE'
    /// - Parameters:
    ///     - str: A String that will be encrypted or decrypted
    ///     - isEncrypt: A Bool that handles if it is an encryption or not, Encryption(true)/Decryption(false)
    ///     - key: A String that will be used to XOR each character of str
    /// - Returns: a new String which is either encoded or decoded by the XOR Cipher
    func XORCipher(str: String, isEncrypt: Bool, key: String) -> String {
        var stringResult = ""
        let keyArray = Array(key)
        var key_index = 0
        
        for s in str {
            let strASCII = self.getASCIIVal(s)
            let keyASCII = self.getASCIIVal(keyArray[key_index])
            
            // the new position of the transformed char will be the XOR of the binary value of the string's character ASCII with the key's one as well using the ^ to apply the XOR
            let charChangedPosition = strASCII ^ keyASCII
            print(charChangedPosition)
            if let appendToString = self.getStringFromASCII(charChangedPosition) {
                stringResult.append(appendToString)
            } else {
                continue
            }
            
            key_index = (key_index + 1) % keyArray.count
        }
        
        return Base64Cipher(str: str, isEncrypt: isEncrypt)
    }
    
}
