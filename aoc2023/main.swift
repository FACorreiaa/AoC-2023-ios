//
//  main.swift
//  aoc2023
//
//  Created by Fernando Correia on 04.12.23.
//

import Foundation

let lookup = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]

func partOne() {
    let lines = getLines(from: CommandLine.arguments[1])
    let numbers = extractNumbers(from: lines)
    print(sum(nums: numbers))
}

func partTwo() {
    var lines = getLines(from: CommandLine.arguments[1])
    lines = replaceAlphaNumbers(in: lines)
    let numbers = extractNumbers(from: lines)
    print(sum(nums: numbers))
}

func sum(nums: [Int]) -> Int {
    return nums.reduce(0, +)
}

func replaceAlphaNumbers(in lines: [String]) -> [String] {
    return lines.map { replaceAlphaNumber(in: $0) }
}

func replaceAlphaNumber(in line: String) -> String {
    var updatedLine = line
    for (index, word) in lookup.enumerated() {
        updatedLine = updatedLine.replacingOccurrences(of: word, with: "\(word)\(index + 1)\(word)")
    }
    return updatedLine
}

func extractNumbers(from lines: [String]) -> [Int] {
    return lines.map { extractNumber(from: $0) }
}

func extractNumber(from line: String) -> Int {
    let digits = line.compactMap { $0.isNumber ? Int(String($0)) : nil }
    return digits.first! * 10 + digits.last!
}

func getLines(from filename: String) -> [String] {
    print(filename)
    do {
        let content = try String(contentsOfFile: filename, encoding: .utf8)
        return content.components(separatedBy: .newlines)
    } catch {
        print("Error reading file: \(error)")
        fatalError("Error reading file: \(error)")
    }
}


let partOneStart = DispatchTime.now()
partOne()
let partOneEnd = DispatchTime.now()
let partOneTime = Double(partOneEnd.uptimeNanoseconds - partOneStart.uptimeNanoseconds) / 1_000_000_000
print("Part one day one took: \(partOneTime) seconds")

let partTwoStart = DispatchTime.now()
partTwo()
let partTwoEnd = DispatchTime.now()
let partTwoTime = Double(partTwoEnd.uptimeNanoseconds - partTwoStart.uptimeNanoseconds) / 1_000_000_000
print("Part two day one took: \(partTwoTime) seconds")
