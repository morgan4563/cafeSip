//
//  String+Validation.swift
//  cafeSip
//
//  Created by hyunMac on 1/19/25.
//

import Foundation

extension String {
    func isValidEmail() -> Bool {
        let lowercasedEmail = self.lowercased()
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: lowercasedEmail)
    }
}
