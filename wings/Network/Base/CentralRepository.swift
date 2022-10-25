//
//  CentralRepository.swift
//  wings
//
//  Created by ACI 2 on 25/10/22.
//

import Foundation

class CentralRepository: BaseRepository {
    static let shared = CentralRepository()
    
    func login(un: String, ps: String, completion: @escaping (Result<[ProductResponse], NetworkError>) -> Void) {
        urlRequestr(route: CentralRoute.readDataWtAuthentication(uNme: un, pswd: ps), completion: completion)
    }
}
