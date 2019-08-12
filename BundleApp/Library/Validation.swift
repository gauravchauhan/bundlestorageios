
import Foundation

import UIKit

class Validation {
    
    func isValidVechileNumber(_ vechileNumber: String) -> Bool {
        let vechileRegex = "^[A-Z]{2}[ -][0-9]{1,2}(?: [A-Z])?(?: [A-Z]*)? [0-9]{4}$"
        let vechileNumberCheck = NSPredicate(format: "SELF MATCHES %@", vechileRegex)
        return vechileNumberCheck.evaluate(with: vechileNumber)
    }
    
    func isValidPassword(_ passwordString: String) -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[0-9])(?=.*[$@$#!%*?&])[A-Za-z\\d0-9$@$#!%*?&]{8,}"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordCheck.evaluate(with: passwordString)
    }
    
    func isValidEmail(_ emailString: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: emailString)
    }
    
    func isValidZipCode(_ zipcodeString: String) -> Bool {
        let zipcodeRegex = "[0-9]{6,8}"
        let zipcodeTest = NSPredicate(format: "SELF MATCHES %@", zipcodeRegex)
        return zipcodeTest.evaluate(with: zipcodeString)
    }
    
    func isValidNumber(_ numberString: String) -> Bool {
        let numberRegex = "[0-9]{1,}"
        let numberTest = NSPredicate(format: "SELF MATCHES %@", numberRegex)
        return numberTest.evaluate(with: numberString)
    }
    
    
    func isValidDiscount(_ numberString: String) -> Bool {
        
        let numberRegex = "[0-9]{0,99}"
        
        let numberTest = NSPredicate(format: "SELF MATCHES %@", numberRegex)
        
        return numberTest.evaluate(with: numberString)
    }
    
    func isValidPhoneNumber(_ phoneString: String) -> Bool {
        
        let phoneRegex = "[0-9]{10}"
        
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        
        return phonePredicate.evaluate(with: phoneString)
    }
    
    func isValidCharacters(_ string: String) -> Bool {
        // "[A-Za-z\\s]{1,}"
        let regex = "[A-Za-z\\s]{1,14}"
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        return test.evaluate(with: string)
    }
    
    func validate(_ string: String, equalTo match: String) -> Bool {
        if (string == match) {
            return true
        }else {
            return false
            
        }
    }
}
