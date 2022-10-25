//
//  CentralRoute.swift
//  wings
//
//  Created by ACI 2 on 25/10/22.
//

import Foundation

enum CentralRoute: ApiConfig {
    case readDataWtAuthentication(uNme: String, pswd: String)
}

extension CentralRoute {
    var baseUrl: String {
        return "https://api.steinhq.com/v1/storages/" + Cnst.ntw.apiID
    }
    var path: String {
        switch self {
        case .readDataWtAuthentication:
            return "product"
        }
    }
    var parameter: [String : Any] {
        return [:]
    }
    var header: [String : String] {
        switch self {
        case .readDataWtAuthentication(let uNme, let psswd):
            let stringAuth = String(format: "%@:%@", uNme, psswd)
            let dataAuth = stringAuth.data(using: String.Encoding.utf8)!
            let base64Auth = dataAuth.base64EncodedString()
            return [
                "Accept": "application/json",
                "Content-Type": "application/json",
                "Authorization": "Basic \(base64Auth)"
            ]
        }
    }
    var method: HttpMethod {
        switch self {
        case .readDataWtAuthentication:
            return .get
        }
    }
    var body: [String : Any] {
        return [:]
    }
}

