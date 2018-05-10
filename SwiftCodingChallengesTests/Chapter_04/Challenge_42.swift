//
//  Challenge_42.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 5/10/18.
//

import XCTest

/// “Write an extension for all collections that reimplements the index(of:) method.

private extension Collection where Element: Equatable {

    func indexOf(_ element: Element) -> Index? {
        for index in indices {
            let value = self[index]
            if value == element {
                return index
            }
        }
        return nil
    }
}

class Challenge_42: XCTestCase {

    func test01() {
        XCTAssertEqual([1,2,3].indexOf(1), 0)
        XCTAssertEqual([1,2,3].indexOf(3), 2)
        XCTAssertEqual([1,2,3].indexOf(5), nil)
    }
}
