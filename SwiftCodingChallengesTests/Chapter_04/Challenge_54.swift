//
//  Challenge_54.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 6/15/18.
//

import XCTest


// Create a binary search tree data structure that can be initialized from an unordered array of comparable values, then write a method that returns whether the tree is balanced.

private indirect enum TreeNode<T: Comparable> {
    case empty
    case node(leftNode: TreeNode, value: T, rightNode: TreeNode)

    func insert(value: T) -> TreeNode {
        switch self {
        case .empty:
            return .node(leftNode: .empty, value: value, rightNode: .empty)
        case .node(leftNode: let lhs, value: let nodeValue, rightNode: let rhs):
            if value > nodeValue {
                let updatedNode = rhs.insert(value: value)
                return .node(leftNode: lhs, value: nodeValue, rightNode: updatedNode)
            } else if value < nodeValue {
                let updatedNode = lhs.insert(value: value)
                return .node(leftNode: updatedNode, value: nodeValue, rightNode: rhs)
            } else {
                return self
            }
        }
    }

    var depth: Int {
        switch self {
        case .empty:
            return 0
        case .node(leftNode: let lhs, value: _, rightNode: let rhs):
            return 1 + max(lhs.depth, rhs.depth)
        }
    }

    var description: String {
        switch self {
        case .empty:
            return ""
        case .node(leftNode: let lhs, value: let value, rightNode: let rhs):
            return lhs.description + " " + String(describing: value) + " " + rhs.description
        }
    }
}

private struct Tree<T: Comparable> {

    private var head: TreeNode<T> = .empty

    init(values: T...) {
        values.forEach { value in
            head = head.insert(value: value)
        }
    }

    var isBalanced: Bool {
        switch head {
        case .empty:
            return true
        case .node(leftNode: let lhs, value: _, rightNode: let rhs):
            let lhsDepth = lhs.depth
            let rhsDepth = rhs.depth
            return abs(lhsDepth-rhsDepth) <= 1
        }
    }

    var description: String {
        return head.description
    }
}

class Challenge_54: XCTestCase {

    func test01() {
        var tree = Tree(values: 2,1,3)
        XCTAssertTrue(tree.isBalanced)

        tree = Tree(values: 5, 1, 7, 6, 2, 1, 9)
        XCTAssertTrue(tree.isBalanced)

        tree = Tree(values: 5, 1, 7, 6, 2, 1, 9, 1)
        XCTAssertTrue(tree.isBalanced)

        tree = Tree(values: 5, 1, 7, 6, 2, 1, 9, 1, 3)
        XCTAssertTrue(tree.isBalanced)

        tree = Tree(values: 50, 25, 100, 26, 101, 24, 99)
        XCTAssertTrue(tree.isBalanced)

        tree = Tree(values: 1)
        XCTAssertTrue(tree.isBalanced)

        tree = Tree(values: 1, 2, 3, 4, 5)
        XCTAssertFalse(tree.isBalanced)

        tree = Tree(values: 10, 5, 4, 3, 2, 1, 11, 12, 13, 14, 15)
        XCTAssertFalse(tree.isBalanced)

        var tree2: Tree<Character> = Tree(values: "k", "t", "d", "a", "z", "m", "f")
        XCTAssertTrue(tree2.isBalanced)

        tree2 = Tree(values: "f", "d", "c", "e", "a", "b")
        XCTAssertFalse(tree2.isBalanced)
    }
}
