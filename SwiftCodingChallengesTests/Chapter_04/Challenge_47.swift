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

    func min3() -> Element? {
        var iterator = makeIterator()
        guard var min = iterator.next() else { return nil }

        while let item = iterator.next() {
            if item < min {
                min = item
            }
        }

        return min
    }

    func min4() -> Element? {
        var iterator = makeIterator()
        guard let min = iterator.next() else { return nil }
        return reduce(min) { $1 < $0 ? $1 : $0 }
    }
}

class Challenge_47: XCTestCase {

    func test01() {
        XCTAssertEqual([1,2,3].min2(), 1)
        XCTAssertEqual(["q", "f", "k"].min2(), "f")
        XCTAssertEqual([4096, 256, 16].min2(), 16)
        XCTAssertEqual([String]().min2(), nil)

        XCTAssertEqual([1,2,3].min3(), 1)
        XCTAssertEqual(["q", "f", "k"].min3(), "f")
        XCTAssertEqual([4096, 256, 16].min3(), 16)
        XCTAssertEqual([String]().min3(), nil)

        XCTAssertEqual([1,2,3].min4(), 1)
        XCTAssertEqual(["q", "f", "k"].min4(), "f")
        XCTAssertEqual([4096, 256, 16].min4(), 16)
        XCTAssertEqual([String]().min4(), nil)

    }
}
