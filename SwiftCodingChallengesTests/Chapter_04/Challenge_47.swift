//
//  Challenge_47.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 5/16/18.
//

import XCTest

private extension Collection where Element: Comparable {

    func min2() -> Element? {
        return reduce(nil) { (min, element) -> Element? in
            if let nonOptionalMin = min {
                return element < nonOptionalMin ? element : nonOptionalMin
            } else {
                return element
            }
        }
    }
}

class Challenge_47: XCTestCase {

    func test01() {
        XCTAssertEqual([1,2,3].min2(), 1)
        XCTAssertEqual(["q", "f", "k"].min2(), "f")
        XCTAssertEqual([4096, 256, 16].min2(), 16)
        XCTAssertEqual([String]().min2(), nil)
    }
}
