//
//  Challenge_02.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 4/3/18.
//

import XCTest

/// “Write a function that accepts a String as its only parameter, and returns true if the string reads the same when reversed, ignoring case.”

private extension String {

    func isPalindrome() -> Bool {
        let originalStr = self.uppercased()
        let reversedStr = String(originalStr.reversed())
        return originalStr == reversedStr
    }

    func isPalindrome2() -> Bool {
        let testStr = self.lowercased()
        var head = testStr.startIndex
        var tail = testStr.index(before:testStr.endIndex)
        while head < tail {
            let headChar = testStr[head]
            let tailChar = testStr[tail]
            if headChar != tailChar {
                return false
            }
            head = testStr.index(after: head)
            tail = testStr.index(before: tail)
        }
        return true
    }
}

class Challenge_02: XCTestCase {

    func test01() {
        XCTAssertTrue("rotator".isPalindrome())
        XCTAssertTrue("rotator".isPalindrome2())
    }

    func test02() {
        XCTAssertTrue("Rats live on no evil star".isPalindrome())
        XCTAssertTrue("Rats live on no evil star".isPalindrome2())
    }

    func test03() {
        XCTAssertFalse("Never odd or even".isPalindrome())
        XCTAssertFalse("Never odd or even".isPalindrome2())
    }

    func test04() {
        XCTAssertFalse("Hello World".isPalindrome())
        XCTAssertFalse("Hello World".isPalindrome2())
    }

    func testPerformance01() {
        let input = String(repeating: "a", count: 10)
        measure {
            _ = input.isPalindrome()
        }
    }

    func testPerformance02() {
        let input = String(repeating: "a", count: 10)
        measure {
            _ = input.isPalindrome2()
        }
    }
}
