//
//  Person.swift
//  Four_Summer
//
//  Created by Рустам Хахук on 09.05.2021.
//

import Foundation

struct person: Codable {
    var surname: String
    var name: String
    var lastname: String
    var email: String
    var phone: String
    var password: String
    var login: String
}

enum SortTypes: Int {
    case login = 0
    case email = 1
    case name = 2
}

struct list: Codable {
    var persons: [person]
    var sortType: Int
    
    mutating func sort(type: SortTypes) {
        sortType = type.rawValue
        switch sortType {
        case 2:
            persons.sort(by: {p1, p2 in p1.surname + " " + p1.name < p2.surname + " " + p2.name})
        case 0:
            persons.sort(by: {p1, p2 in p1.login < p2.login})
        case 1:
            persons.sort(by: {p1, p2 in p1.email < p2.email})
        default:
            break
        }
    }
    
    func saveTo(fileName: String) {
        try! JSONEncoder().encode(self).write(to: Bundle.main.executableURL!.deletingLastPathComponent().appendingPathComponent(fileName))
    }
    
    init(file: String) {
        do {
        self = try JSONDecoder().decode(list.self, from: Data(contentsOf: Bundle.main.executableURL!.deletingLastPathComponent().appendingPathComponent(file)))
        } catch {
            persons = []
            sortType = 0
        }

    }
}
