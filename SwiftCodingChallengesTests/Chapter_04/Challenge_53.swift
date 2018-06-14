//
//  Challenge_53.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 6/13/18.
//

import XCTest

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

    private(set) var count: Int = 0

    func append(value: T) {
        let newNode = LinkedListNode<T>(value: value)

        if head == nil && tail == nil {
            head = newNode
            tail = newNode
        } else {
            tail?.next = newNode
            tail = newNode
        }

        count += 1
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

        count += 1
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

    var first: LinkedListNode<T>? {
        guard let first = head else {
            return nil
        }
        return first
    }

    var last: LinkedListNode<T>? {
        guard let last = tail else {
            return nil
        }
        return last
    }

    func findLoopStart() -> LinkedListNode<T>? {
        var slowRunner = first
        var fastRunner = first

        while true {
            slowRunner = slowRunner?.next
            fastRunner = fastRunner?.next?.next

            if fastRunner == nil {
                return nil
            }

            if slowRunner === fastRunner {
                break
            }
        }

        slowRunner = first

        while slowRunner !== fastRunner {
            slowRunner = slowRunner?.next
            fastRunner = fastRunner?.next
        }

        return slowRunner
    }

    func createLoopStart() -> LinkedListNode<T>? {
        guard count > 0 else { return nil }
        let randomIndex = arc4random_uniform(UInt32(count))
        var randomNode = first
        for _ in 0 ..< randomIndex {
            randomNode = randomNode?.next
        }
        last?.next = randomNode
        return randomNode
    }
}

class Challenge_53: XCTestCase {

    func test() {
        let linkedList = LinkedList<Int>()
        let loopStart = linkedList.createLoopStart()
        XCTAssertTrue(loopStart === linkedList.findLoopStart())
    }

    func test02() {
        let linkedList = LinkedList<Int>()
        (0..<10).forEach { value in
            linkedList.append(value: value)
        }
        let randomNode = linkedList.createLoopStart()
        let loopStart = linkedList.findLoopStart()
        XCTAssertTrue(randomNode === loopStart)
        XCTAssertEqual(randomNode?.value, loopStart?.value)
    }
}
