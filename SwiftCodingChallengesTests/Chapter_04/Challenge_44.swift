//
//  Challenge_44.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 5/13/18.
//

import XCTest

/// Extend your linked list class with a new method that returns the node at the mid point of the linked list using no more than one loop.
/// If the linked list contains an even number of items, returning the one before or the one after the center is acceptable.


private final class Node<T> {
    let value: T
    var next: Node<T>?

    init(value: T, next: Node<T>? = nil) {
        self.value = value
        self.next = next
    }
}

private final class LinkedList<T> {
    private(set) var head: Node<T>? = nil
    private(set) var tail: Node<T>? = nil

    init(values: T...) {
        values.forEach {
            append($0)
        }
    }

    init(values: [T]) {
        values.forEach {
            append($0)
        }
    }

    var count: Int {
        var runner = head
        var count = 0
        while runner != nil {
            count += 1
            runner = runner?.next
        }
        return count
    }

    func append(_ value: T) {
        let newNode = Node(value: value)
        if count == 0 {
            head = newNode
            tail = newNode
        } else {
            tail?.next = newNode
            tail = newNode
        }
    }

    var middle: Node<T>? {
        guard count > 0 else { return nil }

        var runner = head
        var twoStepRunner = head?.next?.next

        while twoStepRunner != nil {
            runner = runner?.next
            twoStepRunner = twoStepRunner?.next?.next
        }
        return runner
    }
}

extension LinkedList where T: CustomStringConvertible {

    var description: String {
        var runner = head
        var result = ""
        while runner != nil {
            if !result.isEmpty {
                result += " "
            }
            result += runner?.value.description ?? ""
            runner = runner?.next
        }
        return result
    }
}


class Challenge_44: XCTestCase {

    let alphabetLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

    func testDescription() {
        let linkedList = LinkedList<Character>()
        alphabetLetters.forEach {
            linkedList.append($0)
        }

        XCTAssertEqual(linkedList.description,
                       "A B C D E F G H I J K L M N O P Q R S T U V W X Y Z")
    }

    func testMidPoint() {

        let list1 = LinkedList<Int>(values: 1,2,3,4,5)
        XCTAssertEqual(list1.middle?.value, 3)

        let list2 = LinkedList<Int>(values: 1,2,3,4)
        XCTAssertEqual(list2.middle?.value, 2)

        let list3 = LinkedList<Character>(values: "ABCDEFGHIJKLMNOPQRSTUVWXYZ".map{ $0 })
        XCTAssertEqual(list3.middle?.value, "M")
    }
}
