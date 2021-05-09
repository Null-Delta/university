//
//  main.swift
//  Four_Summer
//
//  Created by Рустам Хахук on 09.05.2021.
//

import Foundation
import Cocoa
import SwiftSMTP

var peoples = list(file: "list.json")


    print("enter email sending")
    let body = "This is an email for auto testing throug code."
    let shareItems = [body] as NSArray

    let service = NSSharingService(named: NSSharingService.Name.composeEmail)

    //service?.delegate = self
    service?.recipients = ["zed.null@icloud.com"]

    let subject = "Vea Software"
    service?.subject = subject

    service?.perform(withItems: shareItems as [AnyObject])

while(true) {
    print("Выберите комманду:")
    print("    1: показать список")
    print("    2: добавить пользователя")
    print("    3: удалить пользователя")
    print("    4: изменить пользователя")
    print("    5: отправить письмо пользователю")
    print("    6: отсортировать пользователей")
    print("    7: сохранить в файл")
    print("    8: выход")

    let ans = Int(readLine() ?? "-1")!
    
    switch ans {
    case 1:
        for i in peoples.persons {
            print(i.surname + " " + i.name + " " + i.lastname + ":")
            print("    login: \(i.login)")
            print("    email: \(i.email)")
            print("    phone: \(i.phone)")
            print("    password: \(i.password)\n")
        }
    case 2:
        addPerson(ls: &peoples)
        
    case 3:
        print("Выберите удаление:")
        print("    1: По фамилии имени")
        print("    2: По логину")
        print("    3: По номеру")

        var res = Int(readLine() ?? "-1")!
        while(res < 1 || res > 3) {
            print("Введен неверный номер, повторите попытку")
            res = Int(readLine() ?? "-1")!
        }
        
        verification(ls: &peoples, type: res - 1, onVerifivation: {index, ls in
            ls.persons.remove(at: index)
            print("Пользователь удален")
        })
        
    case 4:
        print("Выберите изменение:")
        print("    1: По фамилии имени")
        print("    2: По логину")
        print("    3: По номеру")

        var res = Int(readLine() ?? "-1")!
        while(res < 1 || res > 3) {
            print("Введен неверный номер, повторите попытку")
            res = Int(readLine() ?? "-1")!
        }
        
        verification(ls: &peoples, type: res - 1, onVerifivation: {index, ls in editPerson(ls:&ls, index: index)})
        
    case 5:
        print("Выберите отправку почты:")
        print("    1: По фамилии имени")
        print("    2: По логину")
        print("    3: По номеру")

        var res = Int(readLine() ?? "-1")!
        while(res < 1 || res > 3) {
            print("Введен неверный номер, повторите попытку")
            res = Int(readLine() ?? "-1")!
        }
        
        verification(ls: &peoples, type: res - 1, onVerifivation: {index, ls in
            print("Введите сообщение:")
            let message = readLine() ?? ""
            
            let drLight = Mail.User(name: "Rustam", email: "rustamxaxyk@gmail.com")
            let megaman = Mail.User(name: ls.persons[index].name, email: ls.persons[index].email)

            let smtp = SMTP(
                hostname: "Smtp.gmail.com",     // SMTP server address
                email: "MailSenderRustam@gmail.com",        // username to login
                password: "nnzdbgipqrmautox"            // password to login
            )
            
            let mail = Mail(
                from: drLight,
                to: [megaman],
                subject: "Hi from app!",
                text: message
            )

            smtp.send(mail) { (error) in
                if let error = error {
                    print(error)
                }
            }
            
            print("Сообщение отправлено")
        })
        
    case 6:
        print("Выберите сортировку:")
        print("    1: По фамилии имени")
        print("    2: По почте")
        print("    3: По логину")
        
        var res = Int(readLine() ?? "-1")!
        while(res < 1 || res > 3) {
            print("Введен неверный номер, повторите попытку")
            res = Int(readLine() ?? "-1")!
        }
        switch res {
        case 1:
            peoples.sort(type: .name)
        case 2:
            peoples.sort(type: .email)
        case 3:
            peoples.sort(type: .login)
        default:
            break
        }
        
    case 7:
        peoples.saveTo(fileName: "list.json")
        print("Данные сохранены в list.json")
    case 8:
        exit(0)
    default:
        print("Введен неверный номер, повторите попытку\n")
    }
}

