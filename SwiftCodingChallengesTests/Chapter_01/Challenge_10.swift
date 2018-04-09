//
//  Challenge_10.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 4/9/18.
//

import XCTest

/// Given a string in English, return a tuple containing the number of vowels and consonants.

/// Tip: Vowels are the letters, A, E, I, O, and U; consonants are the letters B, C, D, F, G, H, J, K, L, M, N, P, Q, R, S, T, V, W, X, Y, Z.

private extension String {

    func vowelsAndConsonants() -> (vowels: Int, consonants: Int) {

        let vowels = Set<Character>(arrayLiteral: "A", "E", "I", "O", "U")
        let consonants = Set<Character>(arrayLiteral: "B", "C", "D", "F", "G", "H", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "V", "W", "X", "Y", "Z")

        var vowelCount = 0
        var consonantCount = 0
        for each in self.uppercased() {
            if vowels.contains(each) { vowelCount += 1 }
            if consonants.contains(each) { consonantCount += 1 }
        }

        return (vowels: vowelCount, consonants: consonantCount)
    }

    func vowelsAndConsonants2() -> (vowels: Int, consonants: Int) {

        let vowels = CharacterSet(charactersIn: "AEIOU")
        let consonants = CharacterSet.uppercaseLetters.subtracting(vowels)

        var vowelCount = 0
        var consonantCount = 0
        for char in self.uppercased() {
            let str = String(char)
            if str.rangeOfCharacter(from: vowels, options: .caseInsensitive) != nil {
                vowelCount += 1
            }
            if str.rangeOfCharacter(from: consonants, options: .caseInsensitive) != nil {
                consonantCount += 1
            }
        }

        return (vowels: vowelCount, consonants: consonantCount)
    }
}

class Challenge_10: XCTestCase {

    func test01() {
        let count = "Swift Coding Challenges".vowelsAndConsonants()
        XCTAssertEqual(count.vowels, 6)
        XCTAssertEqual(count.consonants, 15)
        let count2 = "Swift Coding Challenges".vowelsAndConsonants2()
        XCTAssertEqual(count2.vowels, 6)
        XCTAssertEqual(count2.consonants, 15)
    }

    func test02() {
        let count = "Mississippi".vowelsAndConsonants()
        XCTAssertEqual(count.vowels, 4)
        XCTAssertEqual(count.consonants, 7)
        let count2 = "Mississippi".vowelsAndConsonants2()
        XCTAssertEqual(count2.vowels, 4)
        XCTAssertEqual(count2.consonants, 7)
    }

    func testP01() {
        measure {
            let str = String.init(repeating: "abcdefghijklmnopqrstuvwxys", count: 10)
            _ = str.vowelsAndConsonants()
        }
    }

    func testP02() {
        measure {
            let str = String.init(repeating: "abcdefghijklmnopqrstuvwxys", count: 10)
            _ = str.vowelsAndConsonants2()
        }
    }

}
