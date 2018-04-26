//
//  Challenge_28.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 4/26/18.
//

import XCTest

/// Write a logging function that accepts accepts a path to a log file on disk as well as a new log message. Your function should open the log file (or create it if it does not already exist), then append the new message to the log along with the current time and date.

private func log(message: String, filename: String) {
    let fullPath = Bundle(for: Challenge_28.self).bundlePath.appending(filename)
    var logContent = (try? String(contentsOfFile: fullPath)) ?? ""
    logContent.append("\(Date()): \(message)\n")
    try? logContent.write(toFile: fullPath, atomically: true, encoding: .utf32)
}

class Challenge_28: XCTestCase {

    func test01() {
//        log(message: "Hi There!", filename: "Challenge_28.log")
    }
}
