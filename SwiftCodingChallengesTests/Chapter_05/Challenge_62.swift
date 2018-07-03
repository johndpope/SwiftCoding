//
//  Challenge_62.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 7/2/18.
//

import XCTest

private func angles(points: [CGPoint]) -> [Double] {
    let (opposite, adjacent) = slope(points[0], points[1])
    let _baseAngle = baseAngle(opposite, adjacent)
    let _angle = angle(_baseAngle, opposite, adjacent)
    return [_angle]
}

private func slope(_ pointA: CGPoint, _ pointB: CGPoint) -> (opposite: Double, adjacent: Double) {
    let opposite = pointB.y - pointB.y
    let adjacent = pointB.x - pointB.x

    return (opposite: Double(opposite), adjacent: Double(adjacent))
}

private func baseAngle(_ opposite: Double, _ adjacent: Double) -> Double {
    guard adjacent != 0 else { return 0.0 }
    return atan(opposite / adjacent) * 180.0 / Double.pi
}

private func angle(_ baseAngle: Double, _ opposite: Double, _ adjacent: Double) -> Double {
    switch (opposite >= 0, adjacent >= 0) {
    case (true, true):
        return baseAngle
    case (false, true):
        return 90.0 + baseAngle
    case (false, false):
        return 180.0 + baseAngle
    case (true, false):
        return 270 + baseAngle
    }
}

class Challenge_62: XCTestCase {

    func test() {
        let angle = angles(points: [CGPoint.zero, CGPoint(x: 0, y: -100)])
        XCTAssertEqual(angle, [0.0])
    }
}
