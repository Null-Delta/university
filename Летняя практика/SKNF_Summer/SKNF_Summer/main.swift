//
//  main.swift
//  SKNF_Summer
//
//  Created by Рустам Хахук on 09.05.2021.
//

import Foundation

func readFromFile(name: String) {
    do {
    let input = try String(contentsOf: URL(string: Bundle.main.executableURL!.deletingLastPathComponent().appendingPathComponent(name).absoluteString)!)
        try buildSKNF(vector: input).write(to: Bundle.main.executableURL!.deletingLastPathComponent().appendingPathComponent("output.txt"), atomically: true, encoding: .utf8)
        print("результат сохранен в файл output.txt")
    } catch {
        print("Файл не найден")
    }
}

func buildSKNF(vector: String) -> String {
    var result = ""
    for i in 0..<vector.count {
        result += vector[vector.index(vector.startIndex, offsetBy: i)] == "0" ? getExpression(vect:getDoubleNum(x: i, size: Int(log2f(Float(vector.count))))) + " ∧ " : ""
    }
    result.removeLast(3)
    
    return result
}

func getDoubleNum(x: Int, size: Int) -> String {
    var result = ""
    for i in 0..<size {
        result += "\((x / Int(powf(2, Float(size - i - 1)))) % 2)"
    }
    return result
}

func getExpression(vect: String) -> String {
    var result = "("
    for i in 0..<vect.count {
        result += "\(vect[vect.index(vect.startIndex, offsetBy: i)] == "1" ? "¬":"")\(i)X ∨ "
    }
    result.removeLast(3)
    result += ")"
    return result
}

while(true) {
    print("введите название файла:")
    let fileName = readLine()!
    readFromFile(name: fileName)
}

