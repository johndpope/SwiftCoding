//
//  Challenge_58.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 6/22/18.
//

import XCTest

private func hasBalancedBrackets(_ input: String) -> Bool {

    typealias BracketPair = (open: Character, close: Character)

    let brackets: [BracketPair] = [
        (open: "(", close: ")"),
        (open: "[", close: "]"),
        (open: "{", close: "}"),
        (open: "<", close: ">")
    ]

    func isBracket(_ char: Character) -> BracketPair? {
        return brackets.filter { bracket in
            return bracket.open == char || bracket.close == char
        }.first
    }

    guard !input.isEmpty else {
        return true
    }

    guard let first = input.first,
        let _ = isBracket(first) else {
            return false
    }

    let bracketsQueue = input.reduce([BracketPair]()) { (result, value) in
        guard let bracket = isBracket(value) else {
            return result
        }

        if value == bracket.open {
            var result = result
            result.append(bracket)
            return result
        }

        if let top = result.last,
            value == bracket.close,
            top.open == bracket.open {
            var result = result
            result.removeLast()
            return result
        }

        return result
    }

    print(bracketsQueue)
    return bracketsQueue.isEmpty
}

class Challenge_58: XCTestCase {

    func test() {
        XCTAssertTrue(hasBalancedBrackets("()"))
        XCTAssertTrue(hasBalancedBrackets("([])"))
        XCTAssertTrue(hasBalancedBrackets("([])(<{}>)"))
        XCTAssertTrue(hasBalancedBrackets("([]{}<[{}]>)"))
        XCTAssertTrue(hasBalancedBrackets(""))

        XCTAssertFalse(hasBalancedBrackets("}{"))
        XCTAssertFalse(hasBalancedBrackets("([)]"))
        XCTAssertFalse(hasBalancedBrackets("([)"))
        XCTAssertFalse(hasBalancedBrackets("(["))
        XCTAssertFalse(hasBalancedBrackets("[<<<{}>>]"))
        XCTAssertFalse(hasBalancedBrackets("hello"))
    }
}
