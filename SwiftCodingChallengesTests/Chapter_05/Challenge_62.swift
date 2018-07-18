//
//  Challenge_62.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 7/2/18.
//

import XCTest

private func angles(points: [(CGPoint, CGPoint)]) -> [Double] {
    return points.map { pointA, pointB -> Double in
        let (opposite, adjacent) = slope(pointA, pointB)
        let _baseAngle = baseAngle(opposite, adjacent)
        return angle(_baseAngle, opposite, adjacent)
    }
}

private func slope(_ pointA: CGPoint, _ pointB: CGPoint) -> (opposite: Double, adjacent: Double) {
    let opposite = pointA.y - pointB.y
    let adjacent = pointA.x - pointB.x

    return (opposite: Double(opposite), adjacent: Double(adjacent))
}

private func baseAngle(_ opposite: Double, _ adjacent: Double) -> Double {
    return (atan2(opposite, adjacent) * 180.0 / Double.pi) - 90.0
}

private func angle(_ baseAngle: Double, _ opposite: Double, _ adjacent: Double) -> Double {
    var result: Double = baseAngle
    if result < 0 { result += 360.0 }
    if result == 360.0 { result = 0.0 }
    return result
}

class Challenge_62: XCTestCase {

    func test() {
        let points = [
            (CGPoint.zero, CGPoint(x: 0, y: -100)),
            (CGPoint.zero, CGPoint(x: 100, y: -100)),
            (CGPoint.zero, CGPoint(x: 100, y: 0)),
            (CGPoint.zero, CGPoint(x: 100, y: 100)),
            (CGPoint.zero, CGPoint(x: 0, y: 100)),
            (CGPoint.zero, CGPoint(x: -100, y: 100)),
            (CGPoint.zero, CGPoint(x: -100, y: 0)),
            (CGPoint.zero, CGPoint(x: -100, y: -100)),
        ]
        let pointsToAngles = angles(points: points)
        XCTAssertEqual(pointsToAngles, [0.0, 45.0, 90.0, 135.0, 180.0, 225.0, 270.0, 315.0])
    }

    func test2() {
        let points = [
            (CGPoint.zero, CGPoint(x: 100, y: -100)),
            ]
        let pointsToAngles = angles(points: points)
        XCTAssertEqual(pointsToAngles, [45.0])
    }
}
