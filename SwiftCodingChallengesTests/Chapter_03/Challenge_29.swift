//
//  Challenge_29.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 4/26/18.
//

import XCTest

/// Write a function that returns a URL to the user’s documents directory.

private func documentURL() -> URL {
    let urls = FileManager.default.urls(for: .documentDirectory,
                                        in: .allDomainsMask)
    return urls[0]
}

class Challenge_29: XCTestCase {

    func test01() {
        XCTAssertTrue(documentURL().absoluteString.contains("Documents"))
    }

}
