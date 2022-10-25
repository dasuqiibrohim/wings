//
//  CheckoutRequest.swift
//  wings
//
//  Created by ACI 2 on 25/10/22.
//

import Foundation

struct CheckoutRequest: Codable, Identifiable {
    var id = UUID()
    var productCode, productName, price, currency: String
    var dimension, unit: String
    var jumlah: Int

    enum CodingKeys: String, CodingKey {
        case productCode = "product_code"
        case productName = "product_name"
        case price, currency, dimension, unit, jumlah
    }
}
