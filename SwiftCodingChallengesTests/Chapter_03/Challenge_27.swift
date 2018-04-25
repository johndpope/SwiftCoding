//
//  Challenge_27.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 4/25/18.
//

import XCTest

/// “Write a function that accepts a filename on disk, then prints its last N lines in reverse order, all on a single line separated by commas.”

private func file(filename: String, lineCount: Int, reversed: Bool) -> [String]? {
    let bundle = Bundle(for: Challenge_27.self)
    guard let path = bundle.path(forResource: filename, ofType: "txt") else {
        return nil
    }
    let fileContent = try? String(contentsOfFile: path)
    let newLine = CharacterSet.newlines
    let fileContentLines = fileContent?.components(separatedBy: newLine).filter { !$0.isEmpty } ?? []

    let lineOutput = reversed ? fileContentLines.reversed() : fileContentLines
    return Array(lineOutput.prefix(lineCount))
}

private func print2(filename: String, lineCount: Int) -> [String]?  {
    let bundle = Bundle(for: Challenge_27.self)
    guard let path = bundle.path(forResource: filename, ofType: "txt"),
        let input = try? String(contentsOfFile: path) else {
        return nil
    }

    var lines = input.components(separatedBy: "\n").filter { !$0.isEmpty }
    guard lines.count > 0 else { return nil }

    lines.reverse()

    var output = [String]()

    for i in 0 ..< min(lines.count, lineCount) {
        output.append(lines[i])
    }

    return output

}

class Challenge_27: XCTestCase {

    func test01() {
        XCTAssertEqual(file(filename: "Challenge_27", lineCount: 3, reversed: true),
                       ["Twelfth Night", "Othello", "Macbeth"])
        XCTAssertEqual(file(filename: "Challenge_27", lineCount: 100, reversed: true),
                       ["Twelfth Night", "Othello", "Macbeth", "King Lear", "Julius Caesar", "Hamlet", "Cymbeline",  "Coriolanus", "Antony And Cleopatra"])
        XCTAssertEqual(file(filename: "Challenge_27", lineCount: 0, reversed: true),
                      [])
    }

    func test02() {
        XCTAssertEqual(print2(filename: "Challenge_27", lineCount: 3),
                       ["Twelfth Night", "Othello", "Macbeth"])
        XCTAssertEqual(print2(filename: "Challenge_27", lineCount: 100),
                       ["Twelfth Night", "Othello", "Macbeth", "King Lear", "Julius Caesar", "Hamlet", "Cymbeline",  "Coriolanus", "Antony And Cleopatra"])
        XCTAssertEqual(print2(filename: "Challenge_27", lineCount: 0),
                       [])
    }
}
