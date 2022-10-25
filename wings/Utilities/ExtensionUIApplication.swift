//
//  ExtensionUIApplication.swift
//  wings
//
//  Created by ACI 2 on 25/10/22.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
