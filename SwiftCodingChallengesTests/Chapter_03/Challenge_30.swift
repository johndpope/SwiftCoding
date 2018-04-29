//
//  Challenge_30.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 4/27/18.
//

import XCTest

/// Write a function that accepts a path to a directory and returns an array of all JPEGs that have been created in the last 48 hours.

fileprivate func jpegs(in path: String) -> [String] {
    return ["jpeg", "jpg"]
        .flatMap { files(type: $0, path: path, creationTime: -48 * 60 * 60) }
}

fileprivate func files(type: String, path: String, creationTime: TimeInterval) -> [String] {
    let files = try? FileManager.default.contentsOfDirectory(atPath: path)
        .compactMap { file in
            return (file, try! FileManager.default.attributesOfItem(atPath: path + "/" + file))
        }
        .filter { (file, fileAttributes) in
            (fileAttributes as NSDictionary).fileCreationDate()! >= Date().addingTimeInterval(creationTime) &&
            URL(fileURLWithPath: file).pathExtension.contains(type)
        }.map { (file, _) in
            file
        }
    return files ?? []
}

fileprivate func files(types: [String], url: URL, keys: [URLResourceKey], predicate: (URLResourceValues) -> Bool) -> [URL] {
    do {
        let urls = try FileManager.default.contentsOfDirectory(at: url,
                                                                includingPropertiesForKeys: keys,
                                                                options: [])
        let matchedUrls = try urls.filter { url in
            let filename = url.lastPathComponent
            let values = try url.resourceValues(forKeys: Set(keys))
            return predicate(values) &&
                types.reduce(false, { (contains, type) -> Bool in
                    return contains || filename.contains(type)
                })
        }
        return matchedUrls
    } catch {

    }
    return []
}

class Challenge_30: XCTestCase {

    let testDirectory = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask)[0]
    let testFiles: [(name: String, creationDate: Date)] = [
        ("now.jpeg", Date()),
        ("oneDayAgo.jpg", Date(timeIntervalSinceNow: -60 * 60)),
        ("lastYear.jpeg", Date(timeIntervalSinceNow: -365 * 60 * 60)),
        ("sixMonthsAgo.jpeg", Date(timeIntervalSinceNow: -182 * 60 * 60))
    ]

    override func setUp() {
        super.setUp()

        testFiles.forEach { name, creatinonDate in
            let filePath = testDirectory.appendingPathComponent(name)
            FileManager.default.createFile(atPath: filePath.path,
                                           contents: nil,
                                           attributes: [FileAttributeKey.creationDate: creatinonDate])
        }
    }

    override func tearDown() {
        testFiles.forEach { name, _ in
            let fileUrl = testDirectory.appendingPathComponent(name)
            try! FileManager.default.removeItem(at: fileUrl)
        }
        super.tearDown()
    }

    func test01() {
        let images = jpegs(in: testDirectory.path)
        XCTAssertEqual(images.count, 2)
        XCTAssertEqual(images.first, testFiles[0].name)
        XCTAssertEqual(images.last, testFiles[1].name)
    }

    func test02() {
        let jpegFiles = files(types: ["jpeg", "jpg"],
                              url: testDirectory,
                              keys: [URLResourceKey.creationDateKey],
                              predicate: { values in
                                guard let creationDate = values.creationDate else {
                                    return false
                                }
                                let match = creationDate >= Date(timeIntervalSinceNow: -48 * 60 * 60)
                                return match
        })
        XCTAssertEqual(jpegFiles.first?.lastPathComponent, testFiles[0].name)
        XCTAssertEqual(jpegFiles.last?.lastPathComponent, testFiles[1].name)
        XCTAssertEqual(jpegFiles.count, 2)
    }
}
