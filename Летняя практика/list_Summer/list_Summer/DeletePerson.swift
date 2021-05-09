//
//  DeletePerson.swift
//  Four_Summer
//
//  Created by Рустам Хахук on 09.05.2021.
//

import Foundation

func verification(ls: inout list, type: Int, onVerifivation: (Int, inout list)->()) {
    print("Введите \(type == 0 ? "фамилию имя" : type == 1 ? "логин" : "номер") пользователя:")
    var inp = readLine() ?? ""
    var index: Int? = ls.persons.firstIndex(where: {p in
        switch type {
        case 0:
            return p.surname + " " + p.name == inp
        case 1:
            return p.login == inp
        case 2:
            return p.phone == currectPhone(val: inp)
        default:
        return false
        }
    })
    
    while(index == nil) {
        print("Пользователь не найден, попробуйте снова")
        inp = readLine() ?? ""
        index = ls.persons.firstIndex(where: {p in
            switch type {
            case 0:
                return p.surname + " " + p.name == inp
            case 1:
                return p.login == inp
            case 2:
                return p.phone == currectPhoneBack(val: inp)
            default:
            return false
            }
        })
    }
    
    print("Введите пароль:")
    let pass = readLine() ?? ""

    if ls.persons[index!].password == sha256(input: pass) {
        onVerifivation(index!, &ls)
    } else {
        print("Введен неверный пароль, команда удаления отменена")
    }
}
