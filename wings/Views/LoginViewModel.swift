//
//  LoginViewModel.swift
//  wings
//
//  Created by ACI 2 on 25/10/22.
//

import SwiftUI

class LoginViewModel: BaseViewModel {
    @Published var destView: AnyView = AnyView(EmptyView())
    @Published var actv: Bool = false
    
    @Published var unautorize: Bool = false
    
    func LoginReadDataWtAuthentication(un: String, ps: String) {
        ShowLoading()
        CentralRepository.shared.login(un: un, ps: ps) { reslt in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                switch reslt {
                case .success(let dta):
                    self.destView = AnyView(ListView(listData: dta))
                    self.actv = true
                case .failure(let err):
                    switch err {
                    case .bad401:
                        self.unautorize = true
                    default:
                        self.ShowError(err)
                    }
                }
                self.DissLoadRefr()
            }
        }
    }
}
