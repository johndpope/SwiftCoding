//
//  Challenge_60.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 6/26/18.
//

import XCTest

// Create a function that detects whether either player has won in a game of Tic-Tac-Toe.

private struct Board {

    typealias Position = (x: Int, y: Int)

    private let positions: [Position] = {
        var result = [Position]()
        (0...2).forEach { row in
            (0...2).forEach { column in
                result.append(Position(x: column, y: row))
            }
        }
        return result
    }()

    private let rows: [[Position]] = {
        (0...2).map { row in
            return (0...2).map { column in
                return Position(x: column, y: row)
            }
        }
    }()

    private let columns: [[Position]] = {
        (0...2).map { column in
            return (0...2).map { row in
                return Position(x: column, y: row)
            }
        }
    }()

    private let diagonals: [[Position]] = {
        var result = [[Position]]()
        result.append((0...2).map { column in
            return Position(x: column, y: column)
        })
        result.append((0...2).reversed().map { column in
            return Position(x: column, y: column)
        })
        return result
    }()

    private var values: [[String]] = {
        return (0...2).map { _ in
            return ["", "", ""]
        }
    }()

    init(content: [String]) {
        zip(positions, content).forEach { tuple in
            values[tuple.0.y][tuple.0.x] = tuple.1
        }
    }

    var isWin: Bool {
        for row in rows {
            let temp = row.map { values[$0.y][$0.x] }
            if (temp == ["X", "X", "X"] || temp == ["O", "O", "O"]) {
                return true
            }
        }

        for column in columns {
            let temp = column.map { values[$0.y][$0.x] }
            if (temp == ["X", "X", "X"] || temp == ["O", "O", "O"]) {
                return true
            }
        }

        for diagonal in diagonals {
            let temp = diagonal.map { values[$0.y][$0.x] }
            if (temp == ["X", "X", "X"] || temp == ["O", "O", "O"]) {
                return true
            }
        }

        return false
    }
}

public struct TicTacToe {

    typealias Position = (x: Int, y: Int)

    private let values: [[String]]

    init(values: [[String]]) {
        self.values = values
    }

    private let rows: [[Position]] = {
        (0...2).map {
            [
                Position(x: 0, y: $0),
                Position(x: 1, y: $0),
                Position(x: 2, y: $0)
            ]
        }
    }()

    private let columns: [[Position]] = {
        (0...2).map {
            [
                Position(x: $0, y: 0),
                Position(x: $0, y: 1),
                Position(x: $0, y: 2)
            ]
        }
    }()

    private let diagonals: [[Position]] = {
        [
            [Position(x: 0, y: 0), Position(x: 1, y: 1), Position(x: 2, y: 2)],
            [Position(x: 2, y: 2), Position(x: 0, y: 0), Position(x: 0, y: 0)]
        ]
    }()

    private func values(for unit: [Position]) -> [String] {
        return unit.map { position in
            values[position.y][position.x]
        }
    }

    private func isWin(values: [String]) -> Bool {
        guard let first = values.first,
            !first.isEmpty,
            first.rangeOfCharacter(from: CharacterSet.whitespaces) == nil else {
                return false
        }

        for value in values {
            if value != first { return false }
        }

        return true
    }

    var isWin: Bool {
        for units in [rows, columns, diagonals] {
            for unit in units {
                if isWin(values: values(for: unit)) { return true }
            }
        }
        return false
    }
}


class Challenge_60: XCTestCase {

    func test() {
        var board = Board(content: ["X", "", "O", "", "X", "O", "", "", "X"])
        XCTAssertTrue(board.isWin)

        board = Board(content: ["X", "", "O", "X", "", "O", "X", "", ""])
        XCTAssertTrue(board.isWin)

        board = Board(content: ["", "X", "", "O", "X", "", "O", "X", ""])
        XCTAssertTrue(board.isWin)

        board = Board(content:["", "X", "", "O", "X", "", "O", "", "X"])
        XCTAssertFalse(board.isWin)

        board = Board(content:["", "", "", "", "", "", "", "", ""])
        XCTAssertFalse(board.isWin)
    }

    func test2() {
        var board = TicTacToe(values: [["X", "", "O"], ["", "X", "O"], ["", "", "X"]])
        XCTAssertTrue(board.isWin)

        board = TicTacToe(values: [["X", "", "O"], ["X", "", "O"], ["X", "", ""]])
        XCTAssertTrue(board.isWin)

        board = TicTacToe(values: [["", "X", ""], ["O", "X", ""], ["O", "X", ""]])
        XCTAssertTrue(board.isWin)

        board = TicTacToe(values: [["", "X", ""], ["O", "X", ""], ["O", "", "X"]])
        XCTAssertFalse(board.isWin)

        board = TicTacToe(values: [["", "", ""], ["", "", ""], ["", "", ""]])
        XCTAssertFalse(board.isWin)

        board = TicTacToe(values: [[" ", " ", " "], [" ", " ", " "], ["", "", ""]])
        XCTAssertFalse(board.isWin)
    }
}
