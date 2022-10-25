//
//  LoginView.swift
//  wings
//
//  Created by ACI 2 on 25/10/22.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @State private var nis: String = ""
    @State private var pas: String = ""
    @State private var errNis: String = ""
    @State private var errPas: String = ""
    
    var body: some View {
        VStack(spacing: 40) {
            VStack(spacing: 12) {
                Text("Hello, world!")
                    .font(.custom(Cnst.txt.fInterBold, size: 24))
                    .foregroundColor(.G100)
                Text("Masukkan Username dan Password kamu untuk bisa melakukanan pengetesan terhadap technical test dari Ibrohim Dasuqi...")
                    .font(.custom(Cnst.txt.fInterRegular, size: 14))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.N50)
            }
            
            VStack(spacing: 24) {
                //Error
                if viewModel.unautorize {
                    HStack(spacing: 10) {
                        Image(systemName: "info.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.R100)
                            .frame(width: 24, height: 24)
                        Text("Username atau Password kamu salah. Coba Lagi...")
                            .font(.custom(Cnst.txt.fInterRegular, size: 12))
                            .foregroundColor(.R100)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.vertical, 14)
                    .padding(.horizontal, 20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.R100, lineWidth: 1)
                    )
                }
                
                //NIS
                CustomTextFiledWtErrorView(txt: $nis, ertxt: $errNis, tittl: "Username", plcdr: "Masukkan username kamu")
                    .autocapitalization(.none)
                
                //Psswd
                CustomTextFiledWtErrorView(txt: $pas, ertxt: $errPas, tittl: "Password", plcdr: "Masukkan password kamu", pswd: true)
            }
            
            Button {
                if nis.isEmpty && pas.isEmpty {
                    errNis = Cnst.err.required
                    errPas = Cnst.err.required
                } else if nis.isEmpty {
                    errNis = Cnst.err.required
                } else if pas.isEmpty {
                    errPas = Cnst.err.required
                } else {
                    viewModel.LoginReadDataWtAuthentication(un: nis, ps: pas)
                    viewModel.unautorize = false
                }
            } label: {
                Text("Login")
                    .font(.custom(Cnst.txt.fInterSemiBold, size: 14))
                    .foregroundColor(Color.N0)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                    .background(Color.G100)
                    .cornerRadius(10)
            }
            
            
            Spacer(minLength: 0)
        }
        .padding()
        .navigationBarHidden(true)
        .background{ NavigationLink(destination: viewModel.destView, isActive: $viewModel.actv) {EmptyView()} }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
