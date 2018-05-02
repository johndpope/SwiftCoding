//
//  Challenge_33.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 5/1/18.
//

import XCTest

/// Write a function that accepts the name of a directory to scan, and returns an array of filenames that appear more than once in that directory or any of its subdirectories. Your function should scan all subdirectories, including subdirectories of subdirectories.

private func repeatedFiles(in url: URL) -> [String] {
    let directoryContents = recursiveContentsOfDirectory(at: url)

    var files = Set<String>()
    var repeatedFiles = Set<String>()
    directoryContents.forEach { url in
        if files.contains(url.lastPathComponent) {
            repeatedFiles.insert(url.lastPathComponent)
        }
        files.insert(url.lastPathComponent)
    }
    return Array(repeatedFiles)
}

private func recursiveContentsOfDirectory(at url: URL) -> [URL] {
    let fileManager = FileManager.default
    guard fileManager.fileExists(atPath: url.path) else {
        return []
    }

    do {
        let propertiesKeys: [URLResourceKey] = [.isDirectoryKey, .isRegularFileKey]
        let content = try fileManager.contentsOfDirectory(at: url,
                                                          includingPropertiesForKeys: propertiesKeys,
                                                          options: [])
        return try content.reduce([URL](), { (acc, item) in
            var acc = acc
            let values = try item.resourceValues(forKeys: Set(propertiesKeys))
            if let isDirectory = values.isDirectory, isDirectory {
                acc += recursiveContentsOfDirectory(at: item)
            } else if let isFile = values.isRegularFile, isFile {
                acc += [item]
            }
            return acc
        })
    } catch {
        return []
    }
}

class Challenge_33: XCTestCase {

    let destination = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask).first!
    let fileStructureWithRepeatedFiles = [
        "A":
            ["A1": ["A1_1.txt", "A1_2.txt", "A1_3.txt"],
             "A2": ["A2_1.txt", "A2_2.txt", "A2_3.txt"]
        ],
        "B":
            ["B1":
                ["B1a": ["B1a_1.txt", "A1_1.txt"]]
        ]
    ]

    let fileStructureWithoutRepeatedFiles = [
        "A":
            ["A1": ["A1_1.txt", "A1_2.txt", "A1_3.txt"],
             "A2": ["A2_1.txt", "A2_2.txt", "A2_3.txt"]
        ],
        "B":
            ["B1":
                ["B1a": ["B1a_1.txt", "B1a_2.txt"]]
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
                    FileManager.default.createFile(atPath: filePath.path, contents: nil, attributes: nil)
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
        write(structure: fileStructureWithRepeatedFiles, at: destination)
        let documentsFolder = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask).first!
        XCTAssertEqual(repeatedFiles(in: documentsFolder), ["A1_1.txt"])
        delete(structure: fileStructureWithRepeatedFiles, at: destination)
    }

    func test02() {
        write(structure: fileStructureWithoutRepeatedFiles, at: destination)
        let documentsFolder = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask).first!
        XCTAssertEqual(repeatedFiles(in: documentsFolder), [])
        delete(structure: fileStructureWithoutRepeatedFiles, at: destination)
    }
}
