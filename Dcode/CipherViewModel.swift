//
//  CipherViewModel.swift
//  Dcode
//
//  Created by Kaneis Zontanos on 12/3/24.
//

import Foundation

class CipherViewModel: ObservableObject {
    
    // function getASCIIVal takes a character as input and returns an Int which represents the ASCII value if the provided char has an ASCII value
    private func getASCIIVal(_ char: Character) -> Int {
        if let asciiVal = char.asciiValue {
            return Int(asciiVal)
        }
        
        return -1
    }
    
    // function getStringFromASCII takes an int as input and returns a String which or nil depending on whether or not the int given as input has an ascii value
    private func getStringFromASCII(_ asciiVal: Int) -> String? {
        if let uniASCII = UnicodeScalar(asciiVal) {
            return String(Character(uniASCII))
        }
        
        return nil
    }
    
    // function isLetter takes a character as input and returns a Bool depending on if the character provided has an ASCII value which links to a letter in the alphabet
    private func isLetter(_ char: Character) -> Bool {
        let val = self.getASCIIVal(char)
        
        return (65 <= val && val <= 90) || (97 <= val && val <= 122)
    }
    
    private func determineLowerOrUpper(_ char: Character) -> Int {
        return char.isUppercase ? 65 : 97
    }
    
    // function CaeserCipher takes a String, a Bool, an Int and returns a String with either an encoded version or decoded depending on the Bool, the String that is input is either encoded or decoded and it is either encoded or decoded depending on the shift which is the input Int
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
                    stringResult += appendToString
                } else {
                    continue
                }
            } else {
                stringResult.append(s)
            }
        }
        
        return stringResult
    }
    
    // func AtbashCipher takes a String as input and returns another string, since it is 1:1, encoding or decoding is irrelevent. Atbash Cipher maps each char to it's inverse indexed char. Ex. A->Z and Z->A
    func AtbashCipher(str: String) -> String {
        var stringResult = ""
        
        for s in str {
            if self.isLetter(s) {
                let mainStart = self.determineLowerOrUpper(s)
                let ascii = self.getASCIIVal(s)
                
                // the new positions takes the current position in the alphabet then switches the position by doing 25 - pos and then giving it the ascii value by adding mainstart to it
                let charChangedPosition = (25 - (ascii - mainStart)) + mainStart
                
                if let appendToString = self.getStringFromASCII(charChangedPosition) {
                    stringResult += appendToString
                } else {
                    continue
                }
            } else {
                stringResult.append(s)
            }
        }
        
        return stringResult
    }
    
    func ROT13Cipher(str: String) -> String {
        return self.CaesarCipher(str: str, isEncrypt: true, shift: 13)
    }
    
    func VigenereCipher(str: String, isEncrypt: Bool, key: String) -> String {
        var stringResult = ""
        let keyLength = key.count
        var key_index = 0
        
        for s in str {
            if self.isLetter(s) {
                let strStart = self.determineLowerOrUpper(s)
                let strASCII = self.getASCIIVal(s)
                let key_char = key[key.index(key.startIndex, offsetBy: key_index)]
                let keyStart = self.determineLowerOrUpper(key_char)
                let keyASCII = self.getASCIIVal(key_char)
                let keyNormalizedPos = keyASCII - keyStart
                
                let charChangedPosition = (((strASCII - strStart) + (isEncrypt ? keyNormalizedPos : -keyNormalizedPos) + 26) % 26) + strStart
            
                if let appendToString = self.getStringFromASCII(charChangedPosition) {
                    stringResult.append(appendToString)
                } else {
                    continue
                }
                
                key_index = (key_index + 1) % keyLength
            } else {
                stringResult.append(s)
            }
        }
        
        return "The String: " + stringResult
    }
    
    //TODO: implement morse code, xor, and encode64
}
