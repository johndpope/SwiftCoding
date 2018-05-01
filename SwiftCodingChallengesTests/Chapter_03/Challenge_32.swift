//
//  Challenge_32.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 4/30/18.
//

import XCTest

/// Write a function that accepts a filename on disk, loads it into a string, then returns the frequency of a word in that string, taking letter case into account. How you define “word” is worth considering carefully.

private func occurrences(of word: String, in file: String) -> Int? {

    do {
        let url = URL(fileURLWithPath: file)
        let fileContent = try String(contentsOf: url)
        let fileWords = fileContent.split(separator: " ").map { String($0) }
        var count = 0
        fileWords.forEach { (fileWord) in
            if fileWord.contains(word: word) {
                count += 1
            }
        }
        return count
    } catch {
        return nil
    }
}

private extension String {
    func contains(word: String) -> Bool {
        var pattern = self
        if let start = word.range(of: "^[^\\w]*", options: .regularExpression, range: nil, locale: nil) {
            pattern.removeSubrange(start)
        }
        if let end = pattern.range(of: "[^\\w]*$", options: .regularExpression, range: nil, locale: nil) {
            pattern.removeSubrange(end)
        }

        let match = pattern.range(of: "^[^\\w]*" + word + "[^\\w]*$", options: .regularExpression, range: nil, locale: nil)
        return match != nil ? true : false
    }
}

class Challenge_32: XCTestCase {

    let testFiles: [(filename: String, content: String)] = [
        ("test1.txt", "Hello, World!"),
        ("test2.txt", "The rain in Spain falls mainly on the plain"),
        ("test3.txt", "I'm a great coder")
    ]

    typealias WordCount = (word: String, count: Int)
    let matches: [String: [WordCount]] = [
        "test1.txt": [WordCount(word: "Hello", count: 1), WordCount(word: "Hello,", count: 0)],
        "test2.txt": [WordCount(word: "Spain", count: 1), WordCount(word: "in", count: 1)],
        "test3.txt": [WordCount(word: "I'm", count: 1)]
    ]

    override func setUp() {
        super.setUp()
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask).first!
        testFiles.forEach { (filename, content) in
            let url = documentsDirectory.appendingPathComponent(filename)
            FileManager.default.createFile(atPath: url.path,
                                           contents: content.data(using: .utf8),
                                           attributes: nil)
        }
    }
    
    override func tearDown() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask).first!
        testFiles.forEach { (filename, _) in
            let url = documentsDirectory.appendingPathComponent(filename)
            try! FileManager.default.removeItem(at: url)
        }
        super.tearDown()
    }

    func testContains() {
        XCTAssertTrue("Hello,".contains(word: "Hello"))
        XCTAssertFalse("HelloHello".contains(word: "Hello"))
        XCTAssertFalse("Hello,".contains(word: "Hello,"))
        XCTAssertTrue("Spain".contains(word: "Spain"))
        XCTAssertFalse("Spain".contains(word: "in"))
        XCTAssertTrue("I'm a greate coder".contains(word: "I'm"))
        XCTAssertFalse("test@swift.com".contains(word: "test"))
        XCTAssertFalse("test@swift.com".contains(word: "swift.com"))
        XCTAssertTrue("test@swift.com".contains(word: "test@swift.com"))
    }

    func testOccurrences() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask).first!
        matches.forEach { (key, values) in
            let fileURL = documentsDirectory.appendingPathComponent(key)
            for item in values {
                let count = occurrences(of: item.word, in: fileURL.path)
                XCTAssertEqual(count, item.count, "\(item.word) count should be: \(item.count). Instead is: \(String(describing: count))")
            }
        }
    }
}
