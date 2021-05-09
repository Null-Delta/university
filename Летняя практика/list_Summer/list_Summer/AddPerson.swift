//
//  AddPerson.swift
//  Four_Summer
//
//  Created by Рустам Хахук on 09.05.2021.
//

import Foundation
import CommonCrypto

func checkFIO(val: String) -> Bool {
    let redex = try! NSRegularExpression(pattern: #"(?=.*[0-9 ])"#, options: .caseInsensitive)
    return NSRegularExpression.numberOfMatches(redex)(in: val, options: .anchored, range: NSRange(location: 0, length: val.count)) == 0
}

func checkemail(val: String) -> Bool {
    let redex = try! NSRegularExpression(pattern: #"([a-z0-9.]){1,}@([a-z0-9.]){1,}.([a-z0-9.]){2,}"#, options: .caseInsensitive)
    return NSRegularExpression.numberOfMatches(redex)(in: val, options: .anchored, range: NSRange(location: 0, length: val.count)) != 0
}

func checkPhone(val: String) -> Bool {
    let redex = try! NSRegularExpression(pattern: #"^(\+7)([0-9]){10}$"#, options: .caseInsensitive)
    return NSRegularExpression.numberOfMatches(redex)(in: val, options: .anchored, range: NSRange(location: 0, length: val.count)) != 0
}

func checkPassword(val: String) -> Bool {
    let redex = try! NSRegularExpression(pattern: #"(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[\.,()!@#$%^&*])([a-zA-Z0-9\.,()!@#$%^&*]){8}"#, options: .caseInsensitive)
    return NSRegularExpression.numberOfMatches(redex)(in: val, options: .anchored, range: NSRange(location: 0, length: val.count)) != 0
}

func currectFIO(val: String) -> String {
    var last = val
    last = String(last.dropFirst(1))
    return String(val.first!.uppercased()) + last.lowercased()
}

func currectPhone(val: String) -> String {
    var last = val
    last.insert("-", at: val.index(val.startIndex, offsetBy: 10))
    last.insert("-", at: val.index(val.startIndex, offsetBy: 8))
    last.insert("-", at: val.index(val.startIndex, offsetBy: 5))
    last.insert(")", at: val.index(val.startIndex, offsetBy: 5))
    last.insert("(", at: val.index(val.startIndex, offsetBy: 2))
    last.insert("-", at: val.index(val.startIndex, offsetBy: 2))
    return last
}

func currectPhoneBack(val: String) -> String {
    var last = val
    last.removeAll(where: {char in "() -".contains(char)})
    return last
}

func sha256(input : String) -> String {
    let data = NSData(data: input.data(using: .utf8)!)
    var hash: [UInt8] = Array<UInt8>(repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
    CC_SHA256(data.bytes, CC_LONG(data.length), &hash)
    let res = NSData(bytes: hash, length: Int(CC_SHA256_DIGEST_LENGTH))
    return res.base64EncodedString(options: .endLineWithCarriageReturn)
}

//func sha256(val: String) -> String {
//    return val
//}

func addPerson( ls: inout list) {
    print("Введите фамилию:")
    var surname = readLine() ?? ""
    while(!checkFIO(val: surname)) {
        print("Некорректно введена фамилия, попробуйте снова:")
        surname = readLine() ?? ""
    }
    print("Введите имя:")
    var name = readLine() ?? ""
    while(!checkFIO(val: name)) {
        print("Некорректно введено имя, попробуйте снова:")
        name = readLine() ?? ""
    }
    print("Введите отчество:")
    var lastname = readLine() ?? ""
    while(!checkFIO(val: lastname)) {
        print("Некорректно введено отчество, попробуйте снова:")
        lastname = readLine() ?? ""
    }
    print("Введите логин:")
    var login = readLine() ?? ""
    while(ls.persons.contains(where: {p in p.login == login})) {
        print("пользователь с данным логином уже существует, введите другой:")
        login = readLine() ?? ""
    }
    
    print("Введите почту:")
    var email = readLine() ?? ""
    while(!checkemail(val: email)) {
        print("Некорректно введена почта, попробуйте снова:")
        email = readLine() ?? ""
    }
    
    print("Введите номер телефона:")
    var phone = readLine() ?? ""
    while(!checkPhone(val: phone)) {
        print("Некорректно введен номер, попробуйте снова:")
        phone = readLine() ?? ""
    }
    
    print("Введите пароль:")
    var password = readLine() ?? ""
    while(!checkPassword(val: password)) {
        print("Некорректно введен пароль, попробуйте снова:")
        password = readLine() ?? ""
    }
    
    let p = person(surname: currectFIO(val: surname), name: currectFIO(val: name), lastname: currectFIO(val: lastname), email: email, phone: currectPhone(val: phone), password: sha256(input: password), login: login)
    
    ls.persons.append(p)
    ls.sort(type: SortTypes(rawValue: ls.sortType)!)
    
    print("Пользователь успешно добавлен")
}
