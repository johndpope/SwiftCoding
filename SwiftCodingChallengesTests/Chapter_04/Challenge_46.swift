//
//  Challenge_46.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 5/15/18.
//

import XCTest

/// Write an extension for all collections that reimplements the map() method

private extension Collection {

    func newMap<T>(_ transform: (Element) throws -> T) rethrows -> [T] {
        var result = [T]()
        for element in self {
            let newElement = try transform(element)
            result.append(newElement)
        }
        return result
    }
}

class Challenge_46: XCTestCase {

    func test01() {
        let res = [1,2,3].newMap { String($0) }
        XCTAssertEqual(res, ["1","2","3"])

        let res2 = ["1","2","3"].newMap { Int($0)! }
        XCTAssertEqual(res2, [1,2,3])
    }
}
