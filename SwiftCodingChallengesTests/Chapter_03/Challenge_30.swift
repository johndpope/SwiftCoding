//
//  Challenge_30.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 4/27/18.
//

import XCTest

/// Write a function that accepts a path to a directory and returns an array of all JPEGs that have been created in the last 48 hours.

func jpegs(in path: String) -> [String] {
    return ["jpeg", "jpg"]
        .flatMap { files(type: $0, path: path, creationTime: -48 * 60 * 60) }
}

func files(type: String, path: String, creationTime: TimeInterval) -> [String] {
    let files = try? FileManager.default.contentsOfDirectory(atPath: path)
        .map {
            path + "/" + $0
        }
        .compactMap { file in
            return (file, try! FileManager.default.attributesOfItem(atPath: file))
        }
        .filter { (file, fileAttributes) in
            (fileAttributes as NSDictionary).fileCreationDate()! >= Date().addingTimeInterval(creationTime) &&
            URL(fileURLWithPath: file).pathExtension.contains(type)
        }.map { (file, _) in
            file
        }
    return files ?? []
}

class Challenge_30: XCTestCase {

    func test01() {
        let picturesDirectory = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask).first!
        let images = jpegs(in: picturesDirectory.path)
        XCTAssertTrue(images.count == 1)
    }
}
