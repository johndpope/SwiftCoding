//
//  Challenge_35.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 5/3/18.
//

import XCTest
/// Write a function that accepts a path to a directory, then converts to PNGs any JPEGs it finds in there, leaving the originals intact. If any JPEG can’t be converted the function should just quietly continue.

private func convertJpegToPng(in url: URL) {
    let fileManager = FileManager.default
    guard fileManager.isReadableFile(atPath: url.path) else { return }
    let jpegFilenames = try? fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])
        .filter { url in
            url.isFileURL && (url.pathExtension == "jpeg" || url.pathExtension == "jpg" )
    }

    let jpegImages = jpegFilenames?.map { filename -> (URL, UIImage?) in
            guard let data = fileManager.contents(atPath: filename.path),
                let jpegFile = UIImage(data: data) else { return (filename, nil) }
            return (filename, jpegFile)
        }.compactMap { value -> (URL, UIImage)? in
            guard let nonNilImage = value.1 else { return nil }
            return (value.0, nonNilImage)
        }

    jpegImages?.forEach { url, image in
        let newUrl = url.deletingPathExtension().appendingPathExtension("png")
        let data = UIImagePNGRepresentation(image)
        fileManager.createFile(atPath: newUrl.path, contents: data, attributes: nil)
    }
}

class Challenge_35: XCTestCase {

    func test01() {
        let source = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask).first!
        convertJpegToPng(in: source)
    }
}
