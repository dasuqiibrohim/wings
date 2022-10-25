//
//  BaseViewModel.swift
//  wings
//
//  Created by ACI 2 on 25/10/22.
//

import SwiftUI

class BaseViewModel: NSObject, ObservableObject {
    @Published var isRefresh = false
    @Published var isLoading = false
    
    @Published var isError = false
    @Published var errorText: NetworkError = .badError
    
    @Published var isToast = false
    @Published var textToast = ""
    
    @Published var shmrAll: Bool = false
    
    @Published var isExit = false
    
    @Published var limid = 10
    @Published var oppset = 0
    @Published var page = 1
    
    
    func ShowToast(_ txToast: String) {
        withAnimation(.easeInOut) {
            UIApplication.shared.endEditing()
            BaseState.shared.textToast = txToast
            BaseState.shared.isToast = true
        }
    }
    func ShowError(_ txError: NetworkError) {
        withAnimation(.easeInOut) {
            UIApplication.shared.endEditing()
            BaseState.shared.errorText = txError
            BaseState.shared.isError = true
        }
    }
    func ShowLoading() {
        withAnimation(.easeInOut) {
            UIApplication.shared.endEditing()
            BaseState.shared.isLoading = true
        }
    }
    func ShowRefresh() {
        withAnimation(.easeInOut) {
            UIApplication.shared.endEditing()
            self.isRefresh = true
        }
    }
    func DissLoadRefr() {
        withAnimation(.easeInOut) {
            UIApplication.shared.endEditing()
            BaseState.shared.isLoading = false
            self.isRefresh = false
            self.shmrAll = false
        }
    }
}
