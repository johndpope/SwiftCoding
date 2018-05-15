//
//  Challenge_45.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 5/14/18.
//

import XCTest

/// Write a new method for your binary search tree that traverses the tree in order, running a closure on each node.

private indirect enum Tree<T: Comparable> {
    case empty
    case node(left: Tree, element: T, right: Tree)

    init() {
        self = .empty
    }

    init(elements: [T]) {
        self = elements.reduce(.empty) { tree, element in
            return tree.insert(element)
        }
    }

    func insert(_ element: T) -> Tree {
        switch self {
        case .empty:
            return .node(left: .empty, element: element, right: .empty)
        case .node:
            return insert(element, in: self)
        }
    }

    private func insert(_ element: T, in tree: Tree) -> Tree {
        switch tree {
        case .empty:
            return .node(left: .empty, element: element, right: .empty)
        case let .node(left: lst, element: nodeElement, right: rst):
            if element < nodeElement {
                return .node(left: insert(element, in: lst), element: nodeElement, right: rst)
            } else if element == nodeElement {
                return self
            } else {
                return .node(left: lst, element: nodeElement, right: insert(element, in: rst))
            }
        }
    }

    func inOrderTraverse() -> [T] {
        switch self {
        case .empty:
            return []
        case let .node(left: lst, element: element, right: rst):
            return lst.inOrderTraverse() + [element] + rst.inOrderTraverse()
        }
    }
}

class Challenge_45: XCTestCase {

    func test01() {
        let tree1 = Tree(elements: [2,1,3])
        XCTAssertEqual(tree1.inOrderTraverse(), [1,2,3])

        let tree2 = Tree(elements: [5,4,7,2,6,8,1,3,9])
        XCTAssertEqual(tree2.inOrderTraverse(), [1,2,3,4,5,6,7,8,9])
    }
}
