//
//  EditPerson.swift
//  Four_Summer
//
//  Created by Рустам Хахук on 09.05.2021.
//

import Foundation

func editPerson(ls: inout list, index: Int) {
    mainLoop: while(true) {
        print("Выберите поле для изменения:")
        print("    1: Фамилия")
        print("    2: Имя")
        print("    3: Отчество")
        print("    4: Логин")
        print("    5: Почта")
        print("    6: Номер")
        print("    7: Пароль")
        print("    8: Выход")

        let ans = Int(readLine() ?? "-1")!
        
        switch ans {
        case 1:
            print("Введите фамилию:")
            var surname = readLine() ?? ""
            while(!checkFIO(val: surname)) {
                print("Некорректно введена фамилия, попробуйте снова:")
                surname = readLine() ?? ""
            }
            ls.persons[index].surname = currectFIO(val: surname)
            print("Фамилия успешно изменена")
            
        case 2:
            print("Введите имя:")
            var name = readLine() ?? ""
            while(!checkFIO(val: name)) {
                print("Некорректно введено имя, попробуйте снова:")
                name = readLine() ?? ""
            }
            ls.persons[index].name = currectFIO(val: name)
            print("Имя успешно изменено")
            
        case 3:
            print("Введите отчество:")
            var lastname = readLine() ?? ""
            while(!checkFIO(val: lastname)) {
                print("Некорректно введено отчество, попробуйте снова:")
                lastname = readLine() ?? ""
            }
            ls.persons[index].lastname = currectFIO(val: lastname)
            print("Отчество успешно изменено")
            
        case 4:
            print("Введите логин:")
            var login = readLine() ?? ""
            while(ls.persons.contains(where: {p in p.login == login})) {
                print("пользователь с данным логином уже существует, введите другой:")
                login = readLine() ?? ""
            }
            ls.persons[index].login = login
            print("Логин успешно изменен")
            
        case 5:
            print("Введите почту:")
            var email = readLine() ?? ""
            while(!checkemail(val: email)) {
                print("Некорректно введена почта, попробуйте снова:")
                email = readLine() ?? ""
            }
            ls.persons[index].email = email
            print("Почта успешно изменена")

        case 6:
            print("Введите номер телефона:")
            var phone = readLine() ?? ""
            while(!checkPhone(val: phone)) {
                print("Некорректно введен номер, попробуйте снова:")
                phone = readLine() ?? ""
            }
            ls.persons[index].phone = phone
            print("Номер успешно изменен")
            
        case 7:
            print("Введите пароль:")
            var password = readLine() ?? ""
            while(!checkPassword(val: password)) {
                print("Некорректно введен пароль, попробуйте снова:")
                password = readLine() ?? ""
            }
            ls.persons[index].password = password
            print("Пароль успешно изменен")
            
        case 8:
            break mainLoop
        default:
            print("Введен неверный номер, повторите попытку\n")

        }





    }
}
