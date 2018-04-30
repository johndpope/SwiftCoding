//
//  Challenge_31.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 4/29/18.
//

import XCTest

// Write a function that accepts two paths: the first should point to a directory to copy, and the second should be where the directory should be copied to. Return true if the directory and all its contents were copied successfully; false if the copy failed, or the user specified something other than a directory.

private func copyContents(source: URL, destination: URL) -> Bool {
    let fileManager = FileManager.default

    guard fileManager.isReadableFile(atPath: source.path) else {
            return false
    }

    do {
        try fileManager.copyItem(at: source, to: destination)
        return true
    } catch {
        print(error.localizedDescription)
        return false
    }
}

class Challenge_31: XCTestCase {

    let source = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask).first!
        .appendingPathComponent("source", isDirectory: true)
    let destination = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask).first!
        .appendingPathComponent("destination", isDirectory: true)
    let files = ["A":
                    ["A1": ["A1_1.txt", "A1_2.txt", "A1_3.txt"],
                     "A2": ["A2_1.txt", "A2_2.txt", "A2_3.txt"]
                    ],
                 "B":
                    ["B1":
                        ["B1a": ["B1a_1.txt", "B1a_2.txt"]]
                    ]
                ]

    func write( structure: [String: Any], at base: URL) {
        structure.forEach { (key, value) in
            let folder = base.appendingPathComponent(key, isDirectory: true)
            try? FileManager.default.createDirectory(at: folder, withIntermediateDirectories: false, attributes: nil)

            if let subStructure = value as? [String: Any] {
                write(structure: subStructure, at: folder)
            } else if let fileList = value as? [String] {
                for file in fileList {
                    let filePath = folder.appendingPathComponent(file)
                    FileManager.default.createFile(atPath: filePath.path, contents: nil, attributes: nil)
                }

            }
        }
    }

    override func setUp() {
        super.setUp()
        write(structure: files, at: source)
    }
    
    override func tearDown() {
        try? FileManager.default.removeItem(at: source)
        try? FileManager.default.removeItem(at: destination)
        super.tearDown()
    }

    func test01() {
        XCTAssertTrue(copyContents(source: source, destination: destination))
    }
}
