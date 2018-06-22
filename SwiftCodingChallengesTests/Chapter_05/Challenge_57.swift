//
//  Challenge_57.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 6/20/18.
//

import XCTest

// Write a function that accepts two values and returns true if they are isomorphic. That is, each part of the value must map to precisely one other, but that might be itself.

private func areIsomorphic(_ lhs: Any, _ rhs: Any) -> Bool {
    return areIsomorphic(String(describing: lhs), String(describing: rhs))
}

private func areIsomorphic(_ lhs: String, _ rhs: String) -> Bool {
    guard lhs.count == rhs.count else {
        return false
    }

    var unique = Set<Character>()
    var mapping = [Character: Character]()
    let tuples = zip(lhs, rhs)
    for (lhsValue, rhsValue) in tuples {
        let lhsIsoValue = mapping[lhsValue]
        switch (lhsValue, lhsIsoValue, rhsValue) {
        case let (_, lhsIsoValue?, rhsValue ):
            if rhsValue != lhsIsoValue {
                return false
            }
        case let (_, nil, rhsValue ):
            if unique.contains(rhsValue) {
                return false
            }
            mapping[lhsValue] = rhsValue
            unique.insert(rhsValue)
        }
    }

    return true
}

class Challenge_57: XCTestCase {
    
    func test() {
        XCTAssertTrue(areIsomorphic("clap", "slap"))
        XCTAssertTrue(areIsomorphic("rum", "mud"))
        XCTAssertTrue(areIsomorphic("pip", "did"))
        XCTAssertTrue(areIsomorphic("carry", "baddy"))
        XCTAssertTrue(areIsomorphic("cream", "lapse"))
        XCTAssertTrue(areIsomorphic(123123, 456456))
        XCTAssertTrue(areIsomorphic(3.14159, 2.03048))
        XCTAssertTrue(areIsomorphic([1, 2, 1, 2, 3], [4, 5, 4, 5, 6]))

        XCTAssertFalse(areIsomorphic("carry", "daddy"))
        XCTAssertFalse(areIsomorphic("did", "cad"))
        XCTAssertFalse(areIsomorphic("maim", "same"))
        XCTAssertFalse(areIsomorphic("curry", "flurry"))
        XCTAssertFalse(areIsomorphic(112233, 112211))

    }
}
