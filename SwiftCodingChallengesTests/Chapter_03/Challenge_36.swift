//
//  Challenge_36.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 5/4/18.
//

import XCTest

/// Write a function that accepts accepts a path to a log file on disk, and returns how many lines start with “[ERROR]”. The log file could be as large as 10GB, but may also not exist.

private func lineCount(prefix: String, in url: URL) -> Int {
    guard FileManager.default.isReadableFile(atPath: url.path) else {
        return 0
    }

    let chunkSize = 1024
    var count = 0

    do {
        let fileHandle = try FileHandle(forReadingFrom: url)

        while let fileData = nextDataChunk(fileHandle: fileHandle, chunkSize: chunkSize) {
            let lines = splitInNewLines(data: fileData)
            count += lines.reduce(0, { res, line in
                return res + (line.hasPrefix(prefix) ? 1 : 0)
            })
        }
        return count
    } catch {
        return 0
    }
}

private func nextDataChunk(fileHandle: FileHandle, chunkSize: Int) -> Data? {
    let data = fileHandle.readData(ofLength: chunkSize)
    return !data.isEmpty ? data : nil
}

private func splitInNewLines(data: Data) -> [String] {

    var dataChunks = [Data]()
    var runner = data.startIndex
    while runner < data.endIndex {
        if let range = data.range(of: "\n".data(using: .utf8)!, options: [], in: runner..<data.endIndex) {
            let subdata = data.subdata(in: runner..<range.upperBound)
            dataChunks.append(subdata)
            runner = range.upperBound
        } else {
            runner = data.endIndex
        }
    }

    let lines = dataChunks.map { chunk in
            return String(data: chunk, encoding: .utf8)
        }
        .compactMap { $0 }

    return lines
}


class Challenge_36: XCTestCase {

    let destination = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask).first!

    lazy var firstInputFilename = {
        return destination.appendingPathComponent("firstInput.log")
    }()

    lazy var secondInputFilename = {
        return destination.appendingPathComponent("secondInput.log")
    }()

    let firstInput = """
    This is a test
    How many lines
    Start with [ERROR]
    [ERROR] This line
    At least one
    """

    let secondInput = """
    This is a test
    How many lines
    Start with [ERROR]
    No lines :-(
    """
    override func setUp() {
        try? firstInput.write(to: firstInputFilename,
                              atomically: true,
                              encoding: .utf8)

        try? secondInput.write(to: secondInputFilename,
                               atomically: true,
                               encoding: .utf8)

        super.setUp()
    }

    override func tearDown() {
        try? FileManager.default.removeItem(at: firstInputFilename)
        try? FileManager.default.removeItem(at: secondInputFilename)
        super.tearDown()
    }
    func test01() {
        XCTAssertEqual(lineCount(prefix: "[ERROR]", in: firstInputFilename), 1)
        XCTAssertEqual(lineCount(prefix: "[ERROR]", in: secondInputFilename), 0)
    }
}
