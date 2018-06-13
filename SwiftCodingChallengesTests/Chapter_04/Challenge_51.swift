//
//  Challenge_51.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 6/12/18.
//

import XCTest

/// Create a linked list of lowercase English alphabet letters, along with a method
// that traverses all nodes and prints their letters on a single line separated by spaces.
// Expand your code from challenge 43 so that it has a reversed() method that returns a copy of itself in reverse.

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

    func reversed() -> Node {
        var result = Node.empty
        values.forEach { value in
            result = result.insert(value)
        }
        return result
    }
}

extension Node: CustomStringConvertible where T: CustomStringConvertible {
    var description: String {
        return values.map { $0.description }
            .joined(separator: " ")
    }
}

private class LinkedListNode<T> {
    let value: T
    var next: LinkedListNode?

    init(value: T) {
        self.value = value
        self.next = nil
    }
}

private class LinkedList<T> {

    private var head: LinkedListNode<T>?
    private var tail: LinkedListNode<T>?

    func append(value: T) {
        let newNode = LinkedListNode<T>(value: value)

        if head == nil && tail == nil {
            head = newNode
            tail = newNode
        } else {
            tail?.next = newNode
            tail = newNode
        }
    }

    func insert(value: T) {
        let newNode = LinkedListNode<T>(value: value)

        if head == nil && tail == nil {
            head = newNode
            tail = newNode
        } else {
            newNode.next = head
            head = newNode
        }
    }

    func reversed() -> LinkedList {
        let reversedLinkedList = LinkedList()
        values.forEach { value in
            reversedLinkedList.insert(value: value)
        }
        return reversedLinkedList
    }

    var values: [T] {
        var currentNode = head
        var result = [T]()
        while let node = currentNode {
            result.append(node.value)
            currentNode = node.next
        }
        return result
    }
}

class Challenge_51: XCTestCase {

    let alphabetLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

    func test() {

        let head = alphabetLetters.reversed().reduce(Node<Character>.empty) { (head, char) in
            return Node.node(value: char, next: head)
        }
        XCTAssertEqual(head.description,
                       "A B C D E F G H I J K L M N O P Q R S T U V W X Y Z")
        XCTAssertEqual(head.reversed().description,
                       "Z Y X W V U T S R Q P O N M L K J I H G F E D C B A")
    }

    func test2() {
        let linkedList = LinkedList<Character>()
        alphabetLetters.forEach { letter in
            linkedList.append(value: letter)
        }
        XCTAssertEqual(linkedList.values.map { $0.description }.joined(separator: " "),
                       "A B C D E F G H I J K L M N O P Q R S T U V W X Y Z")
        XCTAssertEqual(linkedList.reversed().values.map { $0.description }.joined(separator: " "),
                       "Z Y X W V U T S R Q P O N M L K J I H G F E D C B A")
    }
}
