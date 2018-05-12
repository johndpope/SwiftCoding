//
//  Challenge_43.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 5/10/18.
//

import XCTest

/// Create a linked list of lowercase English alphabet letters, along with a method that traverses all nodes and prints their letters on a single line separated by spaces.

private indirect enum Node<T> {
    case empty
    case node(value: T, next: Node<T>)

    func insert(_ value: T) -> Node {
        return .node(value: value, next: self)
    }

    var values: [T] {
        switch self {
        case .empty:
            return []
        case .node(value: let value, next: let next):
            return [value] + next.values
        }
    }
}

extension Node: CustomStringConvertible where T: CustomStringConvertible {
    var description: String {
        return values.map { $0.description }
            .joined(separator: " ")
    }
}


class Challenge_43: XCTestCase {

    let alphabetLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

    func test() {

        let head = alphabetLetters.reversed().reduce(Node<Character>.empty) { (head, char) in
            return Node.node(value: char, next: head)
        }

        XCTAssertEqual(head.description,
                       "A B C D E F G H I J K L M N O P Q R S T U V W X Y Z")
    }
}
