//
//  main.swift
//  Log_Summer
//
//  Created by Рустам Хахук on 09.05.2021.
//

import Foundation

func LogFromFile(name: String) {
    do {
        let vals = try String(contentsOf: Bundle.main.executableURL!.deletingLastPathComponent().appendingPathComponent(name))
        let x = Double(vals.split(separator: " ")[0])!
        let e = Double(vals.split(separator: " ")[1])!
        try "\(ln(x: x, e: e))".write(to: Bundle.main.executableURL!.deletingLastPathComponent().appendingPathComponent("output.txt"), atomically: true, encoding: .utf8)
        print("Результат сохранен в файл output.txt")
    } catch {
        print("Файл не найден, попробуйте снова")
    }
}

func ln(x: Double, e: Double, isMinus: Bool = false) -> Double {
    var result: Double = 0
    
    if x < 1 {
        return ln(x: 1/x, e: e, isMinus: true)
    }
    
    for i in (0..<Int(x)) {
        let value = Double(x - Double(i)) / Double(x - Double(i) - 1)
        
        var res = 0.0, last = e
        var iter = 1.0
        
        while(abs(res - last) >= e) {
            last = res
            if x - Double(i) <= 2 {
                res += (pow(x - Double(i) - 1, iter) / iter) * pow(-1, iter + 1)
            } else {
                res += (pow(value - 1, iter) / iter) * pow(-1, iter + 1)
            }
            iter += 1
        }
    
        result += res
    }
    
    return result * (isMinus ? -1 : 1)
}

//try "5.5 0.001".write(to: Bundle.main.executableURL!.deletingLastPathComponent().appendingPathComponent("input.txt"), atomically: true, encoding: .utf8)


while(true) {
    print("Введите имя файла:")
    let fileName = readLine() ?? ""
    LogFromFile(name: fileName)
}
