//
//  Challenge_13.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 4/11/18.
//

import XCTest

/// Write a function that accepts a string as input, then returns how often each letter is repeated in a single run, taking case into account.

/// Tip: This approach is used in a simple lossless compression technique called run-length encoding.

private extension String {

    func encode() -> String {
        var encoded = ""
        var characterCount = 0
        var character: Character? = nil
        var runner = startIndex

        while runner < endIndex {
            let char = self[runner]
            if let current = character {
                if current == char {
                    characterCount += 1
                } else {
                    encoded += "\(current)\(characterCount)"
                    character = char
                    characterCount = 1
                }
            } else {
                character = char
                characterCount = 1
            }

            runner = index(after: runner)
        }

        if let current = character {
            encoded += "\(current)\(characterCount)"
        }

        return encoded
    }

    func encode2() -> String {
        let array = Array(self)

        typealias Tuple = (encoded: String, character: Character?, characterCount: Int)

        let initialResult: Tuple = Tuple(encoded: "", character: nil, characterCount: 0)
        let result = array.reduce(initialResult) { (result, currentCharacter) -> Tuple in
            if let char = result.character {
                if char == currentCharacter {
                    return Tuple(encoded: result.encoded, character: char, characterCount: result.characterCount + 1)
                } else {
                    let partialEncode = result.encoded + "\(char)\(result.characterCount)"
                    return Tuple(encoded: partialEncode, character: currentCharacter, characterCount: 1)
                }
            } else {
                return Tuple(encoded: result.encoded, character: currentCharacter, characterCount: 1)
            }
        }

        if let char = result.character {
            return result.encoded + "\(char)\(result.characterCount)"
        } else {
            return result.encoded
        }
     }

    func encode3() -> String {

        guard var character = first else { return "" }
        var characterCount = 1

        var encoded = ""

        var runner = startIndex

        while runner < endIndex {
            let nextCharacterIndex = index(after: runner)
            if nextCharacterIndex >= endIndex || character != self[nextCharacterIndex] {
                encoded += "\(character)\(characterCount)"
                if nextCharacterIndex < endIndex {
                    character = self[nextCharacterIndex]
                    characterCount = 1
                }
            } else {
                characterCount += 1
            }
            runner = index(after: runner)
        }

        return encoded
    }

    func encode4() -> String {
        var returnValue = ""
        var letterCounter = 0
        var letterArray = Array(self)

        for i in 0 ..< letterArray.count {
            letterCounter += 1

            if i + 1 == letterArray.count || letterArray[i] != letterArray[i + 1] {
                returnValue += "\(letterArray[i])\(letterCounter)"
                letterCounter = 0
            }
        }

        return returnValue
    }
}

class Challenge_13: XCTestCase {

    func test01() {
        XCTAssertEqual("aabbcc".encode(), "a2b2c2")
        XCTAssertEqual("aaabaaabaaa".encode(), "a3b1a3b1a3")
        XCTAssertEqual("aaAAaa".encode(), "a2A2a2")
        XCTAssertEqual("a".encode(), "a1")
        XCTAssertEqual("".encode(), "")
        XCTAssertEqual("aa".encode(), "a2")
        XCTAssertEqual("abcde".encode(), "a1b1c1d1e1")

        XCTAssertEqual("aabbcc".encode2(), "a2b2c2")
        XCTAssertEqual("aaabaaabaaa".encode2(), "a3b1a3b1a3")
        XCTAssertEqual("aaAAaa".encode2(), "a2A2a2")
        XCTAssertEqual("a".encode2(), "a1")
        XCTAssertEqual("".encode2(), "")
        XCTAssertEqual("aa".encode2(), "a2")
        XCTAssertEqual("abcde".encode2(), "a1b1c1d1e1")

        XCTAssertEqual("aabbcc".encode3(), "a2b2c2")
        XCTAssertEqual("aaabaaabaaa".encode3(), "a3b1a3b1a3")
        XCTAssertEqual("aaAAaa".encode3(), "a2A2a2")
        XCTAssertEqual("a".encode3(), "a1")
        XCTAssertEqual("".encode3(), "")
        XCTAssertEqual("aa".encode3(), "a2")
        XCTAssertEqual("abcde".encode3(), "a1b1c1d1e1")

        XCTAssertEqual("aabbcc".encode4(), "a2b2c2")
        XCTAssertEqual("aaabaaabaaa".encode4(), "a3b1a3b1a3")
        XCTAssertEqual("aaAAaa".encode4(), "a2A2a2")
        XCTAssertEqual("a".encode4(), "a1")
        XCTAssertEqual("".encode4(), "")
        XCTAssertEqual("aa".encode4(), "a2")
        XCTAssertEqual("abcde".encode4(), "a1b1c1d1e1")
    }
}

