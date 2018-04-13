//
//  Chapter_16.swift
//  SwiftCodingChallengesTests
//
//  Created by Erick Andrade on 4/13/18.
//

import XCTest

/// Write a function that counts from 1 through 100, and prints “Fizz” if the counter is evenly divisible by 3, “Buzz” if it’s evenly divisible by 5, “Fizz Buzz” if it’s even divisible by three and five, or the counter number for all other cases.

func fizzBuzz(limit: Int) -> [String] {
    return (1...limit).map { value -> String in
        if value % 3 == 0 && value % 5 == 0 {
            return "Fizz Buzz"
        } else if value % 3 == 0 {
            return "Fizz"
        } else if value % 5 == 0 {
            return "Buzz"
        } else {
            return "\(value)"
        }
    }
}
