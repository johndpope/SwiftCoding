//
//  Challenge_34.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 5/2/18.
//

import XCTest

/// Write a function that accepts the name of a directory to scan, and returns an array containing the name of any executable files in there.

private func executableFiles(in url: URL) -> [String] {
//    do {
//        let keys: [URLResourceKey] = [.isExecutableKey]
//        return try onlyFiles(in: url).filter { url in
//            let values = try url.resourceValues(forKeys: Set(keys))
//            return values.isExecutable ?? false
//            }
//            .map { $0.lastPathComponent }
//    } catch {
//        return []
//    }
    return onlyFiles(in: url).filter { url in
        return FileManager.default.isExecutableFile(atPath: url.path)
        }
        .map { $0.lastPathComponent }
}

private func onlyFiles(in url: URL) -> [URL] {
    let fileManager = FileManager.default
    do {
        let keys: [URLResourceKey] = [.isExecutableKey, .isDirectoryKey, .isRegularFileKey]
        let allContent = try fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: keys, options: [])
        return try allContent.filter { url in
            let values = try url.resourceValues(forKeys: Set(keys))
            return values.isRegularFile ?? false
        }
    } catch {
        return []
    }
}

class Challenge_34: XCTestCase {

    let destination = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask).first!
    let noExecutableFiles = [
        "A":
            ["A1": ["A1_1.txt", "A1_2.txt", "A1_3.txt"],
             "A2": ["A2_1.txt", "A2_2.txt", "A2_3.txt"]
        ],
        "B":
            ["B1":
                ["B1a": ["B1a_1.txt", "A1_1.txt"]]
        ]
    ]

    func write(structure: [String: Any], at base: URL) {
        structure.forEach { (key, value) in
            let folder = base.appendingPathComponent(key, isDirectory: true)
            try? FileManager.default.createDirectory(at: folder, withIntermediateDirectories: false, attributes: nil)

            if let subStructure = value as? [String: Any] {
                write(structure: subStructure, at: folder)
            } else if let fileList = value as? [String] {
                for file in fileList {
                    let filePath = folder.appendingPathComponent(file)
                    FileManager.default.createFile(atPath: filePath.path, contents: nil, attributes: [FileAttributeKey.posixPermissions : 0777])
                }

            }
        }
    }

    func delete(structure: [String: Any], at base: URL) {
        structure.forEach { (key, _ ) in
            let folder = base.appendingPathComponent(key, isDirectory: true)
            try? FileManager.default.removeItem(at: folder)
        }
    }

    func test01() {
        let destination = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask).first!
        write(structure: noExecutableFiles, at: destination)
        XCTAssertEqual(executableFiles(in: destination), [])
        delete(structure: noExecutableFiles, at: destination)
    }

    func test02() {
        let destination = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask).first!
        write(structure: noExecutableFiles, at: destination)
        ["A1.txt", "A2.txt"].forEach { filename in
            let url = destination.appendingPathComponent(filename)
            FileManager.default.createFile(atPath: url.path, contents: nil, attributes: [FileAttributeKey.posixPermissions: 0445])
        }
        XCTAssertEqual(executableFiles(in: destination), ["A1.txt", "A2.txt"])
        delete(structure: noExecutableFiles, at: destination)
        ["A1.txt", "A2.txt"].forEach { filename in
            let url = destination.appendingPathComponent(filename)
            try? FileManager.default.removeItem(at: url)
        }

    }
}
