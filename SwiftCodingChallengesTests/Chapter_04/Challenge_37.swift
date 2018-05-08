//
//  Challenge 37.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 5/5/18.
//

import XCTest

/// Write an extension for collections of integers that returns the number of times a specific digit appears in any of its numbers.

private func count(of digit: Int, in collection: [Int]) -> Int {

    let count = collection.reduce(0) { (res, value) in
        return res + value.count(of: digit)
    }
    return count
}

private extension Int {

    func count(of digit: Int) -> Int {
        var count = 0
        var iterator = NumberIterator(self)
        while let aDigit = iterator.next() {
            if aDigit == digit { count += 1 }
        }
        return count
    }
}

public struct NumberIterator: IteratorProtocol {

    var dividend: Int?
    var remainder = 0

    init(_ number : Int) {
        self.dividend = number
    }

    public mutating func next() -> Int? {
        guard let dividend = dividend else { return nil }

        let temp = dividend / 10
        remainder = dividend % 10

        if temp == 0 {
            self.dividend = nil
        } else {
            self.dividend = temp
        }

        return remainder
    }
}

class Challenge_37: XCTestCase {

    func test01() {
        XCTAssertEqual(count(of: 5, in: [5, 15, 55, 515]), 6)
        XCTAssertEqual(count(of: 1, in: [5, 15, 55, 515]), 2)
        XCTAssertEqual(count(of: 5, in: [55555]), 5)
        XCTAssertEqual(count(of: 1, in: [55555]), 0)
    }

}
