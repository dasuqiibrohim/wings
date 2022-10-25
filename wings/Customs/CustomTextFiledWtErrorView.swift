//
//  CustomTextFiledWtErrorView.swift
//  wings
//
//  Created by ACI 2 on 25/10/22.
//

import SwiftUI

struct CustomTextFiledWtErrorView: View {
    @Binding var txt: String
    @Binding var ertxt: String
    let tittl: String
    let plcdr: String
    var pswd: Bool = false
    
    @State private var showNwPin = false
    
    var body: some View {
        let showError = !ertxt.isEmpty
        return VStack(alignment: .leading, spacing: 8) {
            Text(tittl)
                .font(.custom(Cnst.txt.fInterSemiBold, size: 14))
                .foregroundColor(.N100)
            HStack {
                if showNwPin || !pswd {
                    TextField(plcdr, text: $txt)
                        .frame(maxWidth: .infinity)
                } else {
                    SecureField(plcdr, text: $txt)
                        .frame(maxWidth: .infinity)
                }
                if pswd {
                    Image(systemName: showNwPin ? "eye.slash.fill": "eye.fill")
                        .resizable()
                        .frame(width: 22, height: 15)
                        .foregroundColor(.N50)
                        .frame(width: 24, height: 24)
                        .onTapGesture {
                            withAnimation {
                                showNwPin.toggle()
                            }
                        }
                }
            }
            .font(.custom(Cnst.txt.fInterRegular, size: 14))
            .contentShape(Rectangle())
            .padding(.horizontal, 20)
            .padding(.vertical, 14)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(showError ? Color.R100: Color.N50, lineWidth: 1)
            )
            if showError {
                Text(ertxt)
                    .font(.custom(Cnst.txt.fInterRegular, size: 12))
                    .foregroundColor(.R100)
            }
        }
        .onChange(of: txt) { nv in
            ertxt = ""
        }
    }
}
