//
//  Challenge_14.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 4/12/18.
//

import XCTest

/// Write a function that prints all possible permutations of a given input string.

/// Tip: A string permutation is any given rearrangement of its letters, for example “boamtw” is a permutation of “wombat”.

private extension String {

    func allPermutations() -> [String] {
        guard !isEmpty else { return [String]() }

        var permutations = [String]()
        var runner = startIndex
        while runner < endIndex {
            var subString = self
            subString.remove(at: runner)
            let subStringPermutations = subString.allPermutations()

            if subStringPermutations.isEmpty {
                permutations += ["\(self[runner])"]
            } else {
                permutations += subStringPermutations.map {
                    return "\(String(self[runner]))\($0)"
                }
            }
            runner = index(after: runner)
        }
        return permutations
    }
}

class Challenge_14: XCTestCase {

    func test01() {
        XCTAssertEqual("".allPermutations(), [String]())
        XCTAssertEqual("a".allPermutations(), ["a"])
        XCTAssertEqual("ab".allPermutations(), ["ab", "ba"])
        XCTAssertEqual("abc".allPermutations(), ["abc", "acb", "bac", "bca", "cab", "cba"])
        XCTAssertEqual("wombat".allPermutations().count, 720)
    }
}
